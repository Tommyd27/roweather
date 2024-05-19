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

  final settings = Settings();

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
    var response = await http.post(
        Uri.parse(
            "https://api.tomorrow.io/v4/timelines?apikey=CYpkQpfLKYHARs2asQLOQ0GD214pX57F"),
        body: '''{
	"location": "42.3478, -71.0466",
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
    var js = jsonDecode(response.body);
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
          'https://environment.data.gov.uk/flood-monitoring/id/stations/E60101/measures'));
      if (response.statusCode != 200)
        throw Exception("Failure fetching weather API");
      var js = jsonDecode(response.body);
      riverLevel = js['items'][0]['latestReading']['value'];
  }

  Future<void> _fetchHourlyWeather() async {
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
      var js = jsonDecode(response.body);
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
      return true;
    } else {
      for (Outing outing in outings[key]!){
        if (isAfter(start, outing.start) && isAfter(outing.start, end) || isAfter(start, outing.end) && isAfter(outing.end, end)) {
          return false;
        }
      }
      outings[key]!.add(newO);
      return true;
    }
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
}
