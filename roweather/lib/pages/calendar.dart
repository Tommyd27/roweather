import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'sections/hours.dart';
import 'sections/minutes.dart';


class BookingPage extends StatefulWidget{
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

final CalendarFormat _calendarFormat = CalendarFormat.month;
DateTime _focusedCalendarDate = DateTime.now();
DateTime? selectedCalendarDate;

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
    super.initState();
    _controller1 = FixedExtentScrollController();
    _controller2 = FixedExtentScrollController();
    _controller3 = FixedExtentScrollController();
    _controller4 = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4e7c65),
        title: Text('Select date and time to schedule:',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 26,
        )),
      ),
      body: Container(
        color: Color(0xFF4e7c65),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side: BorderSide(color: Color(0xff85B09A), width: 2.0)
                      )
                    ),
                    Container(
                      color: Colors.white,
                      child: TableCalendar(
                        focusedDay: _focusedCalendarDate,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 60)),
                        calendarFormat: _calendarFormat,
                        weekendDays: const[DateTime.sunday, 6],
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        daysOfWeekHeight: 40.0,
                        rowHeight: 60.0,
                        headerStyle: const HeaderStyle(
                          titleTextStyle:
                            TextStyle(color: Colors.white, fontSize: 20.0),
                          decoration: BoxDecoration(
                            color: Color(0xff85B09A),),
                          formatButtonTextStyle:
                            TextStyle(color: Color(0xff85B09A), fontSize: 16.0),
                          formatButtonDecoration: BoxDecoration(
                            color: Color(0xff85B09A),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                           ), ),
                          formatButtonVisible: false,
                         leftChevronIcon: Icon(
                           Icons.chevron_left,
                           color: Colors.white,
                           size: 28,
                         ),
                         rightChevronIcon: Icon(
                           Icons.chevron_right,
                           color: Colors.white,
                           size: 28,
                         ),
                        ),
                        calendarStyle: CalendarStyle(
                          weekendTextStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),
                          todayDecoration: BoxDecoration(
                            color: Color(0xff85B09A),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color(0xff808080),
                            shape: BoxShape.circle,
                          )
                        ),
                        selectedDayPredicate: (currentSelectedDate) {
                          return (isSameDay(selectedCalendarDate, currentSelectedDate));
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(selectedCalendarDate, selectedDay)) {
                            setState(() {
                              selectedCalendarDate = selectedDay;
                              _focusedCalendarDate = focusedDay;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedCalendarDate = focusedDay;
                        },
                      ),
                    ),
                    const Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side: BorderSide(color: Color(0xff85B09A), width: 2.0)
                      )
                    ),
                  ]
                )
              ),
              SingleChildScrollView(child: SizedBox(
            height: 200,
            width: 500,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffA6C5B5),
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
                  Container(width: 50, color:Color(0xffA6C5B5) ),
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
                    const Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side: BorderSide(color: Color(0xff85B09A), width: 2.0)
                      )
                    ),
              TextButton(
              style: ButtonStyle(
                foregroundColor: Color(0xffA6C5B5),
              ),
              onPressed: () { },
              child: Text('Book'),
              )
            ],
          ),
        ),
      )
    );
  }
}


