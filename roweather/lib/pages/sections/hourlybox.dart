import 'package:flutter/material.dart';
import 'hourline.dart';
import 'package:provider/provider.dart';
import '../appstate.dart';
import 'package:fl_chart/fl_chart.dart';

class HourlyBox extends Container {
  HourlyBox() : super(
    padding: EdgeInsets.only(top: 560, left: 0),
    child: Stack(children: [
      Consumer<AppState>(builder: (context, appstate, child) => 
        Container(
          padding: const EdgeInsets.only(left: 64.0, top:10.0, right: 32.0),
          height: 0,
          child:
        HourLine(
          appstate, 
          (datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.dt.hour.toDouble()),
          (spot) => LineTooltipItem("${
            (spot.y + ({"BST": 1, "UTC": 0, "GMT": 0}[appstate.settings.timeZone]))
            .round().toString()}:00", TextStyle(color: Colors.white, fontSize: 20)),
          showLine: false
        ))
      ),
      CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: Consumer<AppState>(builder: (context, appstate, child) => Container(
            color: Color.fromARGB(255, 1, 79, 74),
            padding: const EdgeInsets.only(left: 64.0, top:50.0, right: 32.0),
            height: 100,
            child: HourLine(
              appstate,
              (datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.temperature),
              (spot) => LineTooltipItem(spot.y.round().toString(), TextStyle(color: Colors.white, fontSize: 20)),
            )
          ))),
          SliverToBoxAdapter(child: Consumer<AppState>(builder: (context, appstate, child) => Container(
            padding: const EdgeInsets.only(left: 64.0, top:50.0, right: 32.0),
            height: 100,
            child: HourLine(
              appstate,
              (datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.windSpeed),
              (spot) => LineTooltipItem(spot.y.round().toString(), TextStyle(color: Colors.white, fontSize: 20)),
            )
          ))),
          SliverToBoxAdapter(child: Consumer<AppState>(builder: (context, appstate, child) => Container(
            color: Color.fromARGB(255, 1, 79, 74),
            padding: const EdgeInsets.only(left: 64.0, top:50.0, right: 32.0),
            height: 100,
            child: HourLine(
              appstate,
              (datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.cloudCover),
              (spot) => LineTooltipItem(spot.y.round().toString(), TextStyle(color: Colors.white, fontSize: 20)),
              minY: 0.0,
              maxY: 100.0,
            )
          ))),
          SliverToBoxAdapter(child: Consumer<AppState>(builder: (context, appstate, child) => Container(
            padding: const EdgeInsets.only(left: 64.0, top:50.0, right: 32.0),
            height: 100,
            child: HourLine(
              appstate,
              (datapoint) => FlSpot(datapoint.dt.difference(appstate.lastHour).inHours.toDouble(), datapoint.precipitationProbability),
              (spot) => LineTooltipItem(spot.y.round().toString(), TextStyle(color: Colors.white, fontSize: 20)),
              minY: 0.0,
              maxY: 100.0,
            )
          ))),
        ]
    )])
  );
}