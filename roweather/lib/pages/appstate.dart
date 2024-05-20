import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/weather.dart';

enum FlagColour { unknown, red, yellow, green }

class Outing {
  final TimeOfDay start;
  final TimeOfDay end;
  Outing({required this.start, required this.end});
}

class HourlyWeather {
  DateTime dt;
  double temperature;
  double windSpeed;
  double cloudCover;
  double precipitationProbability;
  HourlyWeather(this.dt, this.temperature, this.windSpeed, this.cloudCover,
      this.precipitationProbability);
}

class DailyWeather {
  DateTime day;
  Weather weather;
  double temperature;
  double windSpeed;
  int uvIndex;
  DailyWeather(
      this.day, this.weather, this.temperature, this.windSpeed, this.uvIndex);
}

class Settings {
  String timeZone = 'BST';
  bool notifyFlagColour = false;
  bool notifyWeatherEvents = false;
  bool notifyWeatherChange = false;
  String language = 'English';
  String unitSpeed = 'KM/H';
  String unitTemperature = 'Celsius';
  String unitHeight = 'Meters';
}

class AppState with ChangeNotifier {
  int? temperature;
  FlagColour flagColour = FlagColour.unknown;
  double? riverLevel;
  final HashMap<DateTime, List<Outing>> outings = HashMap();

  DateTime lastHour = DateTime(2024, 5, 16, 15, 0, 0);
  var hourly = <HourlyWeather>[];
  var daily = <DailyWeather>[];
  int daySelectedIndex = 0;

  final settings = Settings();

  final exampleResponse = true;
  final riverRegressionPoints = 100;
  DateTime? lastRiverTime;
  double? riverRegressionGradient;

  AppState() {
    _fetchData();
  }

  Future<void> _fetchFlagColour() async {
    var response = await http.get(Uri.parse('http://m.cucbc.org/'));
      if (response.statusCode != 200)
        throw Exception("Failure fetching CUCBC API");

      final body = response.body;
      final re = RegExp(r'(?<=\<strong\>)(.*)(?=\</strong\>)');
      var colour = re.firstMatch(body)?.group(0);
      if (colour == null) throw Exception("Failure parsing CUCBC API");
      switch (colour) {
        case "Green":
          flagColour = FlagColour.green;
        case "Yellow":
          flagColour = FlagColour.yellow;
        case "Red":
          flagColour = FlagColour.red;
      }
  }

  Future<void> _fetchDailyWeather() async {

    var body;

    if (exampleResponse) body = '{"data":{"timelines":[{"timestep":"1d","endTime":"2024-05-23T10:00:00Z","startTime":"2024-05-19T10:00:00Z","intervals":[{"startTime":"2024-05-19T10:00:00Z","values":{"temperature":12.13,"uvIndex":2,"weatherCode":1001,"windSpeed":4.81}},{"startTime":"2024-05-20T10:00:00Z","values":{"temperature":15.53,"uvIndex":5,"weatherCode":1001,"windSpeed":3.42}},{"startTime":"2024-05-21T10:00:00Z","values":{"temperature":24.73,"uvIndex":7,"weatherCode":1000,"windSpeed":6.24}},{"startTime":"2024-05-22T10:00:00Z","values":{"temperature":28.24,"uvIndex":7,"weatherCode":1100,"windSpeed":6.55}},{"startTime":"2024-05-23T10:00:00Z","values":{"temperature":20.47,"uvIndex":3,"weatherCode":1001,"windSpeed":5.18}}]}]}}';
    else {
      var response = await http.post(
          Uri.parse(
              "https://api.tomorrow.io/v4/timelines?apikey=CYpkQpfLKYHARs2asQLOQ0GD214pX57F"),
          body: '''{
    "location": "52.1951, 0.1313",
      "fields": [
          "temperature",
          "windSpeed",
          "weatherCode",
          "uvIndex"
      ],
      "units": "metric",
      "timesteps": [
      "1d"
      ],
      "startTime": "now",
      "endTime": "nowPlus4d"
  }''');

      if (response.statusCode != 200)
        throw Exception("Failure fetching weather API");
      body = response.body;
    }
    
    var js = jsonDecode(body);
    daily =
        js['data']['timelines'][0]['intervals'].map<DailyWeather>((datapoint) {
      var values = datapoint['values'];
      return DailyWeather(
        DateTime.parse(datapoint['startTime']),
        parseWeatherCode[values['weatherCode']]!,
        values['temperature'],
        values['windSpeed'],
        values['uvIndex'],
      );
    }).toList();

    print("Daily weather information fetched. ");
  }

  Future<void> _fetchRiverLevel() async {
    // Environment Agency API river levels
      /* Cambridge river stations:
        E21732 - Byron's Pool (mASD)
        E60101 - Baits Bite (mASD)
        E60501 - Jesus Lock Sluice (mASD)
        E19035 - Bin Brook (mASD)
        2603 - FAKE Cambridge (mASD)
        E60502 - Jesus Lock Sluice (Downstream, mAOD)
        E24028 - Jesus Lock Sluice
        
      */
      var response = await http.get(Uri.parse(
          'https://environment.data.gov.uk/flood-monitoring/id/measures/E60101-level-stage-i-15_min-mASD/readings?_sorted&_limit=${riverRegressionPoints.toString()}'));
      if (response.statusCode != 200)
        throw Exception("Failure fetching weather API");
      var js = jsonDecode(response.body);

      riverLevel = js['items'][0]['value'].toDouble();
      lastRiverTime = DateTime.parse(js['items'][0]['dateTime']);
      
      var points = <double, double>{for (var v in js['items']) DateTime.parse(v['dateTime']).difference(lastHour).inMinutes.toDouble(): v['value'].toDouble()};

      /*
      // linear regression (least squares)      
      var sx = points.keys.reduce((value, element) => value+element);
      var sy = points.values.reduce((value, element) => value+element);
      var sxx = points.keys.reduce((value, element) => value+element*element);
      var sxy = points.entries.fold(0.0, (value, element) => value+element.key*element.value);
      riverRegressionA = (sy*sxx-sy*sxy)/(points.length*sxx-sx*sx);
      riverRegressionB = (points.length*sxy-sx*sy)/(points.length*sxx-sx*sx);
      */

      // simple linear regression (must pass through last point)
      var mx = points.keys.reduce((value, element) => value+element)/points.length;
      var my = points.values.reduce((value, element) => value+element)/points.length;

      riverRegressionGradient = (riverLevel!-my)/(lastRiverTime!.difference(lastHour).inMinutes.toDouble()-mx);
      
  }

  double estimateRiverLevel(DateTime at) {
    return riverLevel!+at.difference(lastHour).inMinutes.toDouble()*riverRegressionGradient!;
  }

  Future<void> _fetchHourlyWeather() async {

    var body;

    if (exampleResponse) body = '{"data":{"timelines":[{"timestep":"1h","endTime":"2024-05-19T20:00:00Z","startTime":"2024-05-19T14:00:00Z","intervals":[{"startTime":"2024-05-19T14:00:00Z","values":{"cloudCover":22,"precipitationProbability":0,"temperature":19.81,"windSpeed":4.81}},{"startTime":"2024-05-19T15:00:00Z","values":{"cloudCover":0.78,"precipitationProbability":0,"temperature":19.35,"windSpeed":5.34}},{"startTime":"2024-05-19T16:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":18.84,"windSpeed":5.23}},{"startTime":"2024-05-19T17:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":17.81,"windSpeed":5.03}},{"startTime":"2024-05-19T18:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":16.38,"windSpeed":4.8}},{"startTime":"2024-05-19T19:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":14.76,"windSpeed":4.01}},{"startTime":"2024-05-19T20:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":12.75,"windSpeed":3.69}}]}]}}';
    else {
      var response = await http.post(
            Uri.parse(
                "https://api.tomorrow.io/v4/timelines?apikey=CYpkQpfLKYHARs2asQLOQ0GD214pX57F"),
            body: '''{
                "location": "52.1951, 0.1313",
                "fields": [
                  "temperature",
                  "windSpeed",
                  "cloudCover",
                  "precipitationProbability"
                ],
                "units": "metric",
                "timesteps": [
                  "1h"
                ],
                "startTime": "now",
                "endTime": "nowPlus6h"
              }''');

        if (response.statusCode != 200)
          throw Exception("Failure fetching weather API");
        body = response.body;
    }

    var js = jsonDecode(body);
    hourly = js['data']['timelines'][0]['intervals']
        .map<HourlyWeather>((datapoint) => HourlyWeather(
            DateTime.parse(datapoint['startTime']),
            datapoint['values']['temperature'].toDouble(),
            datapoint['values']['windSpeed'].toDouble(),
            datapoint['values']['cloudCover'].toDouble(),
            datapoint['values']['precipitationProbability'].toDouble()))
        .toList();
  }

  Future<void> _fetchData() async {
    try {
      // Executes all requests concurrently
      // Even if one of the requests fail, the other requests are unaffected
      await Future.wait([_fetchFlagColour(), _fetchHourlyWeather(), _fetchDailyWeather(), _fetchRiverLevel()]);

    } catch (e) {
      print(e);
    } finally {
      // Notify listeners when the last of all fetches complete
      // TODO: Decide if it's better to notifyListeners after each of the fetches have completed
      notifyListeners();
    }
  }

  bool addOuting(DateTime key, TimeOfDay start, TimeOfDay end) {
    Outing newO = Outing(start: start, end: end);
    if (outings[key] == null) {
      outings.addAll({key: [newO]});
    } else {
      for (Outing outing in outings[key]!){
        if (isAfter(start, outing.start) && isAfter(outing.start, end) || isAfter(start, outing.end) && isAfter(outing.end, end)) {
          return false;
        }
      }
      outings[key]!.add(newO);
    }
    notifyListeners();
    return true;
  }
  bool isAfter(TimeOfDay t1, TimeOfDay t2) {
    if (t2.hour > t1.hour) {
      return true;
    } else if (t1.hour < t2.hour){
      return false;
    } else if (t1.minute > t2.minute) {
      return false;
    }
    return true;
  }

  void deleteOutings() {
    outings.clear();
    notifyListeners();
  }

  void selectDay(int index) {
    daySelectedIndex = index;
    notifyListeners();
  }
}
