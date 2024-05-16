import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextComponent extends StatelessWidget {
  final String mainText;

  const TextComponent(this.mainText, { super.key });

  @override
  Widget build(BuildContext context) {
    return Text(mainText, 
      style: GoogleFonts.urbanist(fontSize: 48)
    );
  }
}

class SelectedDay extends StatelessWidget{
  SelectedDay({ super.key });

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[TextComponent("19"), TextComponent("8.2 KM/H"), TextComponent("2.3")]);
  }
}