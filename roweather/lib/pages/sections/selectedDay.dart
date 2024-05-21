import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../appstate.dart';
import 'package:intl/intl.dart';

/**
 * Widget which displays a single statistic
 */
class TextComponent extends StatelessWidget {
  final String mainText;
  final String? sideUpText;
  final String? sideDownText;

  const TextComponent(this.mainText,
      {this.sideUpText, this.sideDownText, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          mainText,
          style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w700)),
        ),
        Container(
            margin: const EdgeInsets.only(left: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(sideUpText ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
              Text(sideDownText ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 18)),
            ]))
      ],
    );
  }
}

/** 
 * Widget for the section displaying weather statistics for the selected day
 */
class SelectedDay extends StatelessWidget {
  SelectedDay({super.key});

  var formatter = NumberFormat("#0.0");

  @override
  Widget build(BuildContext context) =>
      Consumer<AppState>(builder: (context, appstate, child) {
        DailyWeather? info = appstate.daily?[appstate.daySelectedIndex];
        // Does not load widget if daily weather API has not been fetched
        if (info == null) return const CircularProgressIndicator();

        double? temp = info.temperature;
        double? wind = info.windSpeed;
        double? riverLevel = appstate.estimateRiverLevel(info.day);
        String tempSign = "°C";
        String speedUnits = "KM/H";
        String lengthUnits = "m";

        // Metric / imperial units conversion
        if (appstate.settings.unitTemperature == "Fahrenheit") {
          temp = 1.8 * temp! + 32;
          tempSign = '°F';
        }
        if (appstate.settings.unitSpeed == "MPH") {
          wind = wind! / 1.609;
          speedUnits = "MPH";
        }
        if (appstate.settings.unitHeight == "Feet") {
          riverLevel = riverLevel! * 3.281;
          lengthUnits = "ft";
        }
        return Container(
            margin: const EdgeInsets.all(8),
            child: Column(children: [
              const Text("Selected day statistics:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Card(margin: EdgeInsets.only(top: 5),),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextComponent(
                        '${NumberFormat("#0").format(temp ?? 19)}' + tempSign),
                    TextComponent(formatter.format(wind ?? 8.2),
                        sideUpText: speedUnits, sideDownText: "Wind"),
                    TextComponent(NumberFormat("#0").format(info.humidity ?? 50),
                        sideUpText: "%", sideDownText: "Humidity")
                  ]),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextComponent(info.uvIndex.toString(),
                            sideUpText: "UV"),
                        riverLevel == null
                            ? const CircularProgressIndicator()
                            : TextComponent(
                                formatter.format(
                                    riverLevel),
                                sideUpText: lengthUnits,
                                sideDownText: "River Level")
                      ]))
            ]));
      });
}
