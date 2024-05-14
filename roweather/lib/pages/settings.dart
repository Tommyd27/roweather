import 'package:flutter/material.dart';
import 'calendar.dart';
import 'sections/sidebar.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Sidebar(),
      body: Stack(children: <Widget>[
        Positioned(
          left: 10,
          top: 20,
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => scaffoldKey.currentState!.openDrawer(),
          )
        )
        ]
      ),
    );
  }
}