import 'package:demo/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../calendar.dart';
import '../settings.dart';

class Sidebar extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color(0xFF003330),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          /*
          close icon crashes right now
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
          */
          SizedBox(
            height: 60,
          ),
          Container(
            color:
                Color(0xFF518B72), // Set the background color of the ListTile
            child: ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Roweather'))
                );
              },
            ),
          ),
          Container(
            color:
                Color(0xFF518B72), // Set the background color of the ListTile
            child: ListTile(
              title: const Text('Book an Outing'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingPage()),
                );
              },
            ),
          ),
          SizedBox(
            height: 485,
          ),
          Container(
            color:
                Color(0xFF518B72), // Set the background color of the ListTile
            child: ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
