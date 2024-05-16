import 'pages/homepage.dart';
import 'pages/appstate.dart';
import 'pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'pages/calendar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => AppState(),
    child: BaseApp()
    ),
  );
}

class BaseApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roweather',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Roweather Home Page'),
    );
  }
}
