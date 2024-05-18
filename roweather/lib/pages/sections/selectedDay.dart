import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(sideUpText ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            Text(sideDownText ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 18)),
          ])
          )
          
        ],
      );
  }
}

class SelectedDay extends StatelessWidget {
  SelectedDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextComponent("19°"),
                TextComponent("8.2", sideUpText: "KM/H", sideDownText: "Wind"),
                TextComponent("2.3", sideUpText: "KM/H", sideDownText: "Water"),
              ]),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextComponent("7.7", sideUpText: "UV"),
                TextComponent("3.5", sideUpText: "M", sideDownText: "River Level")
              ])
            )
          
        ]));
  }
}
