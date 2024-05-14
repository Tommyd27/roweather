import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'timeTile.dart';
import 'hours.dart';
import 'minutes.dart';

class TimeWheel extends StatefulWidget{
  @override
  State<TimeWheel> createState() => _TimeWheelState();
}
class _TimeWheelState extends State<TimeWheel> {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: SizedBox(
                          height: 200,
                          width: 100,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 4.0,
                            physics: FixedExtentScrollPhysics(),
                            childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 12,
                              builder:(context, index){
                                return Mins(
                                  mins: (index*5)
                                );
                              }
                            )
                          ),
                        ),
    );
  }
}