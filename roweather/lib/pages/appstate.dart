import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'dart:convert';

enum FlagColour { unknown, red, yellow, green }

class Outing {
  DateTime start;
  Duration length;
  Outing(this.start, this.length);
}

class HourlyWeather {
  DateTime dt;
  double temperature;
  double windSpeed;
  double cloudCover;
  double precipitationProbability;
  HourlyWeather(this.dt, this.temperature, this.windSpeed, this.cloudCover, this.precipitationProbability);
}

enum Weather { sunny, fullCloudy, partialCloudy, rainy }

class DayWeatherData {
  DateTime day;
  Weather weather;
  DayWeatherData(this.day, this.weather);
}

class AppState with ChangeNotifier {
  int? temperature;
  FlagColour flagColour = FlagColour.unknown;
  double? riverLevel;
  List<DayWeatherData> nextFewDays = <DayWeatherData>[
    DayWeatherData(DateTime(2024, 5, 20), Weather.sunny),
    DayWeatherData(DateTime(2024, 5, 21), Weather.partialCloudy),
    DayWeatherData(DateTime(2024, 5, 22), Weather.rainy)
  ];

  final outings = <Outing>[];
  DateTime lastHour = DateTime(2024, 5, 16, 15, 0, 0);
  var hourly = <HourlyWeather>[];

  AppState() {
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
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
      response = await http.get(Uri.parse(
        'https://environment.data.gov.uk/flood-monitoring/id/stations/E60101/measures'));
      if (response.statusCode != 200)
      throw Exception("Failure fetching weather API");
      var js = jsonDecode(response.body);
      riverLevel = js['items'][0]['latestReading']['value'];
    
    

    response = await http.post(
        Uri.parse(
            "https://api.tomorrow.io/v4/timelines?apikey=CYpkQpfLKYHARs2asQLOQ0GD214pX57F"),
        body: '''{
  "location": "42.3478, -71.0466",
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
    js = jsonDecode(response.body);
    hourly = js['data']['timelines'][0]['intervals'].map<HourlyWeather>((datapoint) =>
      HourlyWeather(DateTime.parse(datapoint['startTime']), datapoint['values']['temperature'], datapoint['values']['windSpeed'], datapoint['values']['cloudCover'].toDouble(), datapoint['values']['precipitationProbability'].toDouble())
    ).toList();

    notifyListeners();
  }

  void addOuting(DateTime start, Duration length) {
    outings.add(Outing(start, length));
  }

  void deleteOutings() {
    outings.clear();
    notifyListeners();
  }
}
