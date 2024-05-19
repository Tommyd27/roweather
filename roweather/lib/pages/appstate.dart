import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'dart:convert';

enum FlagColour { unknown, red, yellow, green }

class Outing {
  final TimeOfDay start;
  final TimeOfDay end;
  Outing({required this.start, required this.end});
}

class AppState with ChangeNotifier {
  int? temperature;
  FlagColour flagColour = FlagColour.unknown;
  double? riverLevel;
  final HashMap<DateTime, List<Outing>> outings = HashMap();

  AppState() {
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    var response = await http.get(Uri.parse('http://m.cucbc.org/'));
    if (response.statusCode != 200) throw Exception("Failure fetching CUCBC API");

    final body = response.body;
    final re = RegExp(r'(?<=\<strong\>)(.*)(?=\</strong\>)');
    var colour = re.firstMatch(body)?.group(0);
    if (colour == null) throw Exception("Failure parsing CUCBC API");
    switch (colour) {
      case "Green": flagColour = FlagColour.green;
      case "Yellow": flagColour = FlagColour.yellow;
      case "Red": flagColour = FlagColour.red;
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
    if (response.statusCode != 200) throw Exception("Failure fetching weather API");
    var js = jsonDecode(response.body);
    riverLevel = js['items'][0]['latestReading']['value'];

    notifyListeners();
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
}