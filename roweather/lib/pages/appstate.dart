import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Outing {
  DateTime start;
  Duration length;
  Outing(this.start, this.length);
}

class AppState with ChangeNotifier {
  int temperature = 0;
  String testData = "";
  final outings = <Outing>[];

  AppState() {
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final response = await http.get(Uri.parse('http://m.cucbc.org/'));
    if (response.statusCode == 200) {
      //final r = json.decode(response.body);
      // process response
      temperature = 10;
      testData = response.body;
      notifyListeners();
    } else {
      throw Exception("Failure fetching APIs"); 
    }
  }

  void addOuting(DateTime start, Duration length) {
    outings.add(Outing(start, length));
  }
}