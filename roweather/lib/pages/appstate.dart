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
  int humidity;
  DailyWeather(
      this.day, this.weather, this.temperature, this.windSpeed, this.uvIndex, this.humidity);
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

  // lastHour is an arbitrary DateTime that is used as a reference point to produce Duration objects
  DateTime lastHour = DateTime(2024, 5, 16, 15, 0, 0);
  var hourly = <HourlyWeather>[];
  List<DailyWeather>? daily;
  int daySelectedIndex = 0;
  var lightingDown = <TimeOfDay>[TimeOfDay(hour: 0, minute: 0)];
  var lightingUp = <TimeOfDay>[TimeOfDay(hour: 0, minute: 0)];
  final settings = Settings();

  final exampleResponse = true;
  final riverRegressionPoints = 100;
  DateTime? lastRiverTime;
  double? riverRegressionGradient;

  AppState() {
    _fetchData();
  }

  // fetch flag colour from the CUCBC API
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

  FlagColour estimateFlagColour(int dayIndex){
    try{
      DailyWeather data = daily![dayIndex];
      double mphWindSpeed = (settings.unitSpeed == "KM/H")? data.windSpeed / 1.609 : data.windSpeed;
      double celsiusTemp = (settings.unitTemperature == "Fahrenheit")? ((data.temperature - 32) * 5 / 9) : data.temperature;
      if (data.weather == Weather.thunderstorm || data.weather == Weather.freezing){
        return FlagColour.red;
      } else if (data.weather == Weather.fog || mphWindSpeed > 35 || (mphWindSpeed > 25 && celsiusTemp < 0)){
          return FlagColour.yellow;
      } else {
        return FlagColour.green;
      }
    }
    catch (e) {
      return FlagColour.unknown;
    }
  }

  // return list of outings associated with the key of a given day, empty list if none
  List<Outing> getOutingsForDay(DateTime day) {
    return outings[DateTime(day.year, day.month, day.day)] ?? [];
  }

  // fetch 24hr timestep weather information from the tomorrow.io API
  Future<void> _fetchDailyWeather() async {
    var body;

    if (exampleResponse)
      body =
          '{"data":{"timelines":[{"timestep":"1d","endTime":"2024-05-24T10:00:00Z","startTime":"2024-05-20T10:00:00Z","intervals":[{"startTime":"2024-05-20T10:00:00Z","values":{"humidity":94,"temperature":16.53,"uvIndex":6,"weatherCode":1001,"windSpeed":3.5}},{"startTime":"2024-05-21T10:00:00Z","values":{"humidity":86.01,"temperature":26.73,"uvIndex":7,"weatherCode":1001,"windSpeed":4.86}},{"startTime":"2024-05-22T10:00:00Z","values":{"humidity":84.34,"temperature":26.39,"uvIndex":7,"weatherCode":1000,"windSpeed":6.59}},{"startTime":"2024-05-23T10:00:00Z","values":{"humidity":87.82,"temperature":27.98,"uvIndex":6,"weatherCode":1001,"windSpeed":4.98}},{"startTime":"2024-05-24T10:00:00Z","values":{"humidity":84.01,"temperature":27.11,"uvIndex":7,"weatherCode":1001,"windSpeed":4.5}}]}]}}';
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
          "uvIndex",
          "humidity"
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
        values['humidity'] is int ? values['humidity'] : values['humidity'].round()
      );
    }).toList();

    print("Daily weather information fetched. ");
  }

  // fetch river level information for the last riverRegressionPoints days from the Environment Agency API
  Future<void> _fetchRiverLevel() async {
    // Environment Agency API river levels
    /* 
      Cambridge river stations:
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
      throw Exception("Failure fetching river level API");
    var js = jsonDecode(response.body);

    riverLevel = js['items'][0]['value'].toDouble();
    lastRiverTime = DateTime.parse(js['items'][0]['dateTime']);

    var points = <double, double>{
      for (var v in js['items'])
        DateTime.parse(v['dateTime']).difference(lastHour).inMinutes.toDouble():
            v['value'].toDouble()
    };

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
    var mx =
        points.keys.reduce((value, element) => value + element) / points.length;
    var my = points.values.reduce((value, element) => value + element) /
        points.length;

    riverRegressionGradient = (riverLevel! - my) /
        (lastRiverTime!.difference(lastHour).inMinutes.toDouble() - mx);
  }

  // return the estimated river level at a DateTime using the linear regression model
  double estimateRiverLevel(DateTime at) {
    return riverLevel! +
        at.difference(lastHour).inMinutes.toDouble() * riverRegressionGradient!;
  }

  // fetch the 1h timestep weather information from the tomorrow.io API
  Future<void> _fetchHourlyWeather() async {
    var body;

    if (exampleResponse)
      body =
          '{"data":{"timelines":[{"timestep":"1h","endTime":"2024-05-19T20:00:00Z","startTime":"2024-05-19T14:00:00Z","intervals":[{"startTime":"2024-05-19T14:00:00Z","values":{"cloudCover":22,"precipitationProbability":0,"temperature":19.81,"windSpeed":4.81}},{"startTime":"2024-05-19T15:00:00Z","values":{"cloudCover":0.78,"precipitationProbability":0,"temperature":19.35,"windSpeed":5.34}},{"startTime":"2024-05-19T16:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":18.84,"windSpeed":5.23}},{"startTime":"2024-05-19T17:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":17.81,"windSpeed":5.03}},{"startTime":"2024-05-19T18:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":16.38,"windSpeed":4.8}},{"startTime":"2024-05-19T19:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":14.76,"windSpeed":4.01}},{"startTime":"2024-05-19T20:00:00Z","values":{"cloudCover":0,"precipitationProbability":0,"temperature":12.75,"windSpeed":3.69}}]}]}}';
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

  // fetch lighting times from the CUCBC API
  Future<void> _fetchLightingTimes() async {
    var response = await http.get(Uri.parse('https://www.cucbc.org/lighting'));
    if (response.statusCode != 200)
      throw Exception("Failure fetching CUCBC lighting times");

    var body = response.body;
    var tableData = body.split('<table>')[1].split('</table>')[0];
    var rows = tableData.split('<tr>');
    rows.removeRange(0, 2);
    for (var row in rows) {
      if (row.isEmpty) continue;
      var cells = row.split('<td>');
      if (cells.isNotEmpty) {
        var lightingDown = cells[3].split('</td>')[0];
        var lightingUp = cells[4].split('</td>')[0];
        List<String> lightDown = lightingDown.split(':');
        TimeOfDay lightDownTime = TimeOfDay(
            hour: int.parse(lightDown[0]), minute: int.parse(lightDown[1]));
        List<String> lightUp = lightingUp.split(':');
        TimeOfDay lightUpTime = TimeOfDay(
            hour: int.parse(lightUp[0]), minute: int.parse(lightUp[1]));
        this.lightingDown.add(lightDownTime);
        this.lightingUp.add(lightUpTime);
      }
    }
    this.lightingDown.removeAt(0);
    this.lightingUp.removeAt(0);
  }

  // asynchronously perform the API fetches, then notify appstate listeners
  Future<void> _fetchData() async {
    try {
      // Executes all requests concurrently
      // Even if one of the requests fail, the other requests are unaffected
      await Future.wait([
        _fetchFlagColour(),
        _fetchHourlyWeather(),
        _fetchDailyWeather(),
        _fetchRiverLevel(),
        _fetchLightingTimes()
      ]);
    } catch (e) {
      print(e);
    } finally {
      // Notify listeners when the last of all fetches complete
      // TODO: Decide if it's better to notifyListeners after each of the fetches have completed
      notifyListeners();
    }
  }

  // add an outing to the HashMap for a given day with a start and end time
  // returns false if an overlap occurs, true otherwise
  bool addOuting(DateTime key, TimeOfDay start, TimeOfDay end) {
    Outing newO = Outing(start: start, end: end);
    if (outings[key] == null) {
      outings.addAll({
        key: [newO]
      });
    } else {
      for (Outing outing in outings[key]!) {
        if (isOverlap(start, end, outing.start, outing.end)) {
          return false;
        }
      }
      outings[key]!.add(newO);
    }
    notifyListeners();
    return true;
  }


  // utility function returns true if t1 is after t2
  bool isAfter(TimeOfDay t1, TimeOfDay t2) {
    if (t2.hour != t1.hour) {
      return t1.hour > t2.hour;
    }
    return t1.minute > t2.minute;
  }

  // returns whether two times overlap given their start and end points
  bool isOverlap(
      TimeOfDay start1, TimeOfDay end1, TimeOfDay start2, TimeOfDay end2) {
    return !(isAfter(start1, end2) || isAfter(start2, end1));
  }

  // delete all outings from the HashMap
  void deleteOutings() {
    outings.clear();
    notifyListeners();
  }

  // update the selected day for the per-day weather display
  void selectDay(int index) {
    daySelectedIndex = index;
    notifyListeners();
  }
}
