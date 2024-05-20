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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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


        // -- background image and gradient --
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
            height: 110,
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
            )
        ),

        Consumer<AppState>(
          // Demo of using weather data in the homepage
          builder: (context, appstate, child) {
            return Container(
                height: 170,
                alignment: Alignment.center,
                child: appstate.flagColour == FlagColour.unknown
                  ? CircularProgressIndicator()
                  : Icon(
                    Icons.flag,
                    color: appstate.flagColour == FlagColour.green
                      ? Colors.green
                      : appstate.flagColour == FlagColour.yellow
                        ? Colors.yellow
                        : Colors.red,
                      size: 90
                  )
            );
          },
        ),

        HourlyBox(),
      
      ]),
    );
  }
}
