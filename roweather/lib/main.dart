import 'pages/sections/calendar.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(BaseApp());
}

class BaseApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );

  }

}