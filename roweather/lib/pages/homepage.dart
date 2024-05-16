import 'package:flutter/material.dart';
import 'sections/sidebar.dart';
import 'sections/nextfewdays.dart';
import 'package:provider/provider.dart';
import 'appstate.dart';

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
        Center(
          child: NextFewDays(),
        ),
        Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            )),
        Consumer<AppState>(
          // Demo of using weather data in the homepage
          builder: (context, appstate, child) {
            return Container(
                padding: const EdgeInsets.only(left: 64.0, top: 400.0),
                child: appstate.flagColour == FlagColour.unknown
                    ? CircularProgressIndicator()
                    : Text(
                        '''Flag is currently: ${appstate.flagColour == FlagColour.green ? "Green" : appstate.flagColour == FlagColour.yellow ? "Yellow" : "Red"}
                    
River level (Baits Bite): ${appstate.riverLevel}m''',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ));
          },
        ),
      ]),
    );
  }
}
