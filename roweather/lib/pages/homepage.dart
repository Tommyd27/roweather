import 'package:flutter/material.dart';
import 'sections/sidebar.dart';
import 'sections/selectedDay.dart';
import 'sections/carousel.dart';
import 'sections/hourline.dart';
import 'package:provider/provider.dart';
import 'appstate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'sections/hourlybox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Sidebar(),
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
            top: 250,
            left: 0,
            right: 0,
            child: Column(children: <Widget>[
              Container(
                height: 100,
                child: NextDaysCarousel(),
              ),
              SelectedDay(),
            ])),
        Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            )),
        Consumer<AppState>(
          builder: (context, appstate, child) {
            return Container(
                height: 150,
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: appstate.flagColour == FlagColour.unknown
                    ? CircularProgressIndicator()
                    : Column(children: 
                        [Text("Today's CBCUC flag rating:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )), Icon(Icons.flag,
                        color: appstate.flagColour == FlagColour.green
                            ? Colors.green
                            : appstate.flagColour == FlagColour.yellow
                                ? Colors.yellow
                                : Colors.red,
                        size: 90),
                        ]));
          },
        ),
        Positioned(
            top: 60,
            left: 100,
            child: Text(
              "Today's Sunrise Time:",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
        Positioned(
            top: 60,
            right: 100,
            child: Text(
              "Today's Sunset Time:",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
        Positioned(
            top: 85,
            right: 120,
            child: Text(
              "${Provider.of<AppState>(context).lightingUp[0].hour.toString().padLeft(2, '0')}:${Provider.of<AppState>(context).lightingUp[0].minute.toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        Positioned(
            top: 85,
            left: 120,
            child: Text(
              "${Provider.of<AppState>(context).lightingDown[0].hour.toString().padLeft(2, '0')}:${Provider.of<AppState>(context).lightingDown[0].minute.toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        HourlyBox(),
      ]),
    );
  }
}
