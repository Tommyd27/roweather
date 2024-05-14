import 'package:flutter/material.dart';

class Mins extends StatelessWidget{

  int mins;

  Mins({required this.mins});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          mins < 10? '0' + mins.toString() : mins.toString(),
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          )
        )
      ),
    );

  }
}