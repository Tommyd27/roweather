import 'dart:ffi';

import 'package:flutter/material.dart';
import 'hours.dart';
import 'minutes.dart';

class TimeSelector extends StatefulWidget {
  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {


  int _startHour = 7;
  int _startMin = 0;
  int _endHour = 8;
  int _endMin = 0;

  late FixedExtentScrollController _controller1;
  late FixedExtentScrollController _controller2;
  late FixedExtentScrollController _controller3;
  late FixedExtentScrollController _controller4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = FixedExtentScrollController();
    _controller2 = FixedExtentScrollController();
    _controller3 = FixedExtentScrollController();
    _controller4 = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SizedBox(
        height: 200,
        width: 500,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff85B09A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  children:[
                    Container(
                      child: const Text('Start time:',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 48
                        )                  
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),  
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container( 
                            child: SizedBox(
                              height: 100,
                              width: 80,
                              child: ListWheelScrollView.useDelegate(
                                controller: _controller1,
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 4.0,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 17,
                                  builder:(context, index){
                                    return Hours(
                                      hours: (index + 5)
                                    );
                                  }
                                ),
                                onSelectedItemChanged: (value) {
                                  setState(( ) {
                                    _startHour = value;
                                  });
                                },
                            
                              ),
                            ),
                          ),
                          Text(":", style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                          )),
                          Container( 
                            child: SizedBox(
                              height: 100,
                              width: 80,
                              child: ListWheelScrollView.useDelegate(
                                controller: _controller2,
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
                                ),
                                onSelectedItemChanged: (value) {
                                  setState(( ) {
                                    _startMin = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],                    
                      ),
                    )
                  ],
                )
              ),
              Container(width: 50, color:Color(0xff85B09A) ),
              Container(
                child: Column(
                  children:[
                    Container(
                      child: const Text('End time:',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 48
                        )                  
                      )
                    ),
                    Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: SizedBox(
                              height: 100,
                              width: 80,
                              child: ListWheelScrollView.useDelegate(
                                controller: _controller3,
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 4.0,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 17,
                                  builder:(context, index){
                                    return Hours(
                                      hours: (index + 5)
                                    );
                                  }
                                ),
                                onSelectedItemChanged: (value) {
                                  setState(( ) {
                                    _endHour = value;
                                  });
                                },
                            
                              ),
                            ),
                          ),
                          Text(":", 
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w500,
                          )),
                          Container(
                            child: SizedBox(
                              height: 100,
                              width: 80,
                              child: ListWheelScrollView.useDelegate(
                                controller: _controller4,
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
                                ),
                                onSelectedItemChanged: (value) {
                                  setState(( ) {
                                    _endMin = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],                    
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

}