import 'package:demo/pages/homepage.dart';
import 'package:flutter/material.dart';
import '../calendar.dart';
import '../settings.dart';

class Sidebar extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
              height: 100,
              child: DrawerHeader(
                  padding: EdgeInsets.only(left: 10, top: 0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Align(
                      alignment: Alignment(-1, -1),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () =>
                            scaffoldKey.currentState!.closeDrawer(),
                      )))),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Home")),
              );
            },
          ),
          ListTile(
            title: const Text('Book an Outing'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeCalendar()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
