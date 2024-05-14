import 'package:flutter/material.dart';

class Hours extends StatelessWidget{

  int hours;

  Hours({required this.hours});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          hours < 10? '0' + hours.toString() : hours.toString(),
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