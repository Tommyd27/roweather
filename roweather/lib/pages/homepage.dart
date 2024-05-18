import 'package:flutter/material.dart';
import 'sections/sidebar.dart';
import 'sections/nextfewdays.dart';
import 'sections/selectedDay.dart';
import 'sections/carousel.dart';
import 'package:provider/provider.dart';
import 'appstate.dart';
import 'package:fl_chart/fl_chart.dart';

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
        Positioned(
          top: 300,
          left: 0,
          right: 0,
          child: Column(children: <Widget>[
          Container(
            height: 120,
            child: NextDaysCarousel(),
          ),
          Center(child: SelectedDay()),
        ])),
        
        
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
                padding: const EdgeInsets.only(left: 64.0, top: 0.0),
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
        Consumer<AppState>(
          builder: (context, appstate, child) {
            var spots = appstate.hourly.map<FlSpot>((datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.temperature)).toList();
            var lbd = [LineChartBarData(spots: spots)];
            return Container(
              padding: const EdgeInsets.only(left: 64.0, top:400.0, right: 32.0),
              height: 450,
              child: LineChart(
                LineChartData(
                  lineBarsData: lbd,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                  showingTooltipIndicators: spots.map((spot) {return ShowingTooltipIndicators([LineBarSpot(lbd[0], 0, spot)]);}).toList(),
                  lineTouchData: LineTouchData(enabled: false, handleBuiltInTouches: false, 
                  touchTooltipData: LineTouchTooltipData(
                    tooltipMargin: 16.0,
                    tooltipPadding: EdgeInsets.all(0),
                    getTooltipColor: (_) => Color(0x00000000),
                    getTooltipItems: (spots) => spots.map<LineTooltipItem>((spot) => LineTooltipItem(spot.y.round().toString(), TextStyle(color: Colors.white, fontSize: 20))).toList()
                  )
                  /*getTouchedSpotIndicator: (barData, spotIndexes) => barData.spots.map((spot) => TouchedSpotIndicatorData(
                    const FlLine(
                        color: Colors.pink,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          //radius: 8,
                          color: Colors.green,
                          //strokeWidth: 2,
                          strokeColor: Colors.red,
                        ),
                      ),
                    )).toList()*/
                  )
                ),
                duration: Duration(milliseconds: 150), // Optional
                curve: Curves.linear, // Optional
              )
            );
          }
        ),
        Consumer<AppState>(
          builder: (context, appstate, child) {
            return Container(
              padding: const EdgeInsets.only(left: 64.0, top:475.0),
              height: 525,
              child: LineChart(
                LineChartData(
                  lineBarsData: [LineChartBarData(spots: 
                    appstate.hourly.map<FlSpot>((datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.windSpeed)).toList()
                  )],
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                ),
                duration: Duration(milliseconds: 150), // Optional
                curve: Curves.linear, // Optional
              )
            );
          }
        ),
        Consumer<AppState>(
          builder: (context, appstate, child) {
            return Container(
              padding: const EdgeInsets.only(left: 64.0, top:550.0),
              height: 600,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [LineChartBarData(spots: 
                    appstate.hourly.map<FlSpot>((datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.cloudCover)).toList()
                  )],
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                ),
                duration: Duration(milliseconds: 150), // Optional
                curve: Curves.linear, // Optional
              )
            );
          }
        ),
        Consumer<AppState>(
          builder: (context, appstate, child) {
            return Container(
              padding: const EdgeInsets.only(left: 64.0, top:625.0),
              height: 675,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [LineChartBarData(spots: 
                    appstate.hourly.map<FlSpot>((datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.precipitationProbability)).toList()
                  )],
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                ),
                duration: Duration(milliseconds: 150), // Optional
                curve: Curves.linear, // Optional
              )
            );
          }
        )
      ]),
    );
  }
}
