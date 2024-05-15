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

class AppState with ChangeNotifier {
  int temperature = 0;
  FlagColour flagColour = FlagColour.unknown;
  double riverLevel = 0;
  final outings = <Outing>[];

  AppState() {
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    var response = await http.get(Uri.parse('http://m.cucbc.org/'));
    if (response.statusCode == 200) {
      final body = response.body;
      final re = RegExp(r'(?<=\<strong\>)(.*)(?=\</strong\>)');
      var colour = re.firstMatch(body)?.group(0);
      temperature = 10;
      if (colour != null) {
        switch (colour) {
          case "Green": flagColour = FlagColour.green;
          case "Yellow": flagColour = FlagColour.yellow;
          case "Red": flagColour = FlagColour.red;
        }
      }
    } else {
      throw Exception("Failure fetching CUCBC api"); 
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
    response = await http.get(Uri.parse('https://environment.data.gov.uk/flood-monitoring/id/stations/E60101/measures'));
    if (response.statusCode == 200) {
      var js = jsonDecode(response.body);

      riverLevel = js['items'][0]['latestReading']['value'];
    }

    notifyListeners();

  }

  void addOuting(DateTime start, Duration length) {
    outings.add(Outing(start, length));
  }
}