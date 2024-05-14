import 'package:flutter/material.dart';
import 'sections/calendar.dart';
import 'sections/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
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
                      onPressed: () => scaffoldKey.currentState!.closeDrawer(),
                    )
                  )
                
              )
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app.
                // ...
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
      ),
      body: Stack(children: <Widget>[
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sculling-cropped.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            height: 600,
          ),
          Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color(0x00003330),
                    Color(0xFF003330),
                  ],
                  stops: [
                    0.3,
                    0.6,
                  ])),
        ),
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
