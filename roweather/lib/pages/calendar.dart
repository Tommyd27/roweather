//All the packages we are using for this page

import 'package:demo/pages/appstate.dart';
import 'package:demo/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'sections/hours.dart';
import 'sections/minutes.dart';
import 'sections/sidebar.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedCalendarDate = DateTime.now();
  DateTime? selectedCalendarDate;

  int _startHour = 0; //The variables representing start and end times
  int _startMin = 0;
  int _endHour = 0;
  int _endMin = 0;
  String _textPrompt = ''; //This changes the text prompt we may need to display to notify users that they have made an error

  late FixedExtentScrollController _controller1; //These make it possible to choose a booking time
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
        key: scaffoldKey,
        drawer: Sidebar(),
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(
              Icons.close, // The exit button, to bring the user back to the Home Page
              color: Colors.white,
            ),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Roweather'))),
            },
          ),
          backgroundColor: Color(0xFF4e7c65),
          title: const FittedBox(
            alignment: Alignment.topLeft,
            fit: BoxFit.fitWidth,
            child: Text( //The title, which can shrink to fit the device's width
              'Select date and time to schedule:',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF4e7c65),
          child: SingleChildScrollView( //This is to make "scrolling down" possible
            child: Column(
              children: [
                SingleChildScrollView(
                    child: Column(children: <Widget>[
                  const Card( //This acts as vertical padding
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          side: BorderSide(
                              color: Color(0xff85B09A), width: 2.0))),
                  Container(
                    color: Colors.white,
                    child: TableCalendar( //An off-the-shelf calendar-based widget, with customisations
                      focusedDay: _focusedCalendarDate,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 60)), //Ensures a two-month advance booking limit
                      calendarFormat: _calendarFormat,
                      weekendDays: const [DateTime.sunday, 6],
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekHeight: 40.0,
                      rowHeight: 60.0,
                      headerStyle: const HeaderStyle( //Customises the calendar header
                        titleTextStyle:
                            TextStyle(color: Colors.white, fontSize: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xff85B09A),
                        ),
                        formatButtonTextStyle:
                            TextStyle(color: Color(0xff85B09A), fontSize: 16.0),
                        formatButtonDecoration: BoxDecoration(
                          color: Color(0xff85B09A),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
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
                      calendarStyle: const CalendarStyle(
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
                          )),
                      selectedDayPredicate: (currentSelectedDate) { //Marks the current date
                        return (isSameDay(
                            selectedCalendarDate, currentSelectedDate));
                      },
                      onDaySelected: (selectedDay, focusedDay) { //Ensures that one can select days - and adapts the page state accordingly
                        if (!isSameDay(selectedCalendarDate, selectedDay)) {
                          setState(() {
                            selectedCalendarDate = selectedDay;
                            _focusedCalendarDate = focusedDay;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) { //Ensures the user can select days on a particular month, and focuses there
                        _focusedCalendarDate = focusedDay;
                      },
                    ),
                  ),
                  const Card( //More padding
                      margin: EdgeInsets.all(8.0),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          side: BorderSide(
                              color: Color(0xff85B09A), width: 2.0))),
                ])),
                SingleChildScrollView(
                  child: SizedBox(//This contains the time selector wheels
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.9, //Box width can adapt depending on screen size
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container( //A label
                                      child: const Text('Start time:',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 32,
                                          ))),
                                  Container(
                                    decoration: BoxDecoration(//The wheel's background
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: SizedBox(
                                            height: 100,
                                            width: MediaQuery.of(context) //Again, width dependent on screen size
                                                    .size
                                                    .width *
                                                0.12,
                                            child:
                                                ListWheelScrollView.useDelegate( //A selector wheel for the hour of the start time
                                              controller: _controller1,
                                              itemExtent: 50,
                                              perspective: 0.005,
                                              diameterRatio: 4.0,
                                              physics:
                                                  FixedExtentScrollPhysics(),
                                              childDelegate:
                                                  ListWheelChildBuilderDelegate(
                                                      childCount: 17,
                                                      builder:
                                                          (context, index) {
                                                        return Hours(
                                                            hours: (index + 5));
                                                      }),
                                              onSelectedItemChanged: (value) {
                                                setState(() {
                                                  _startHour = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(":",
                                            style: TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Container(
                                          child: SizedBox(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
                                            child:
                                                ListWheelScrollView.useDelegate( //A selector wheel for the minute of the start time
                                              controller: _controller2,
                                              itemExtent: 50,
                                              perspective: 0.005,
                                              diameterRatio: 4.0,
                                              physics:
                                                  FixedExtentScrollPhysics(),
                                              childDelegate:
                                                  ListWheelChildBuilderDelegate(
                                                      childCount: 12,
                                                      builder:
                                                          (context, index) {
                                                        return Mins(
                                                            mins: (index * 5));
                                                      }),
                                              onSelectedItemChanged: (value) {
                                                setState(() {
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
                              )),
                          Container(width: 50, color: Color(0xffA6C5B5)),
                          Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: const Text('End time:', //Another label
                                      style: TextStyle(
                                          fontFamily: 'Roboto', fontSize: 32))),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: SizedBox(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        child: ListWheelScrollView.useDelegate( //A selector wheel for the hour of the end time
                                          controller: _controller3,
                                          itemExtent: 50,
                                          perspective: 0.005,
                                          diameterRatio: 4.0,
                                          physics: FixedExtentScrollPhysics(),
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                                  childCount: 17,
                                                  builder: (context, index) {
                                                    return Hours(
                                                        hours: (index + 5));
                                                  }),
                                          onSelectedItemChanged: (value) {
                                            setState(() {
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.12,
                                        child: ListWheelScrollView.useDelegate( //A selector wheel for the minute of the end time
                                          controller: _controller4,
                                          itemExtent: 50,
                                          perspective: 0.005,
                                          diameterRatio: 4.0,
                                          physics: FixedExtentScrollPhysics(),
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                                  childCount: 12,
                                                  builder: (context, index) {
                                                    return Mins(
                                                        mins: (index * 5));
                                                  }),
                                          onSelectedItemChanged: (value) {
                                            setState(() {
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
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                const Card( //Padding, again
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side:
                            BorderSide(color: Color(0xff85B09A), width: 2.0))),
                Container(
                  decoration: BoxDecoration( //The "Book" button
                      color: Color(0xFFA6C5B5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      border: Border.all(color: Color(0xff639067), width: 4),
                      boxShadow: [
                        BoxShadow( //Included to make it look like a button
                            color: Color(0xFF444444),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(2, 2))
                      ]),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (selectedCalendarDate == null) { //Cases here to detect user error
                          setState(() {
                            _textPrompt = 'Please select a date';
                          });
                        } else if (_endHour < _startHour ||
                            (_endHour == _startHour && _endMin <= _startMin)) {
                          setState(() {
                            _textPrompt = 'Outing cannot end before it starts';
                          });
                        } else { //Here, the data structures are built for the AppState
                          DateTime key = DateTime(
                              selectedCalendarDate!.year,
                              selectedCalendarDate!.month,
                              selectedCalendarDate!.day);
                          TimeOfDay start = TimeOfDay(
                              hour: _startHour + 5, minute: _startMin * 5);
                          TimeOfDay end = TimeOfDay(
                              hour: _endHour + 5, minute: _endMin * 5);
                          if (Provider.of<AppState>(context, listen: false) //The AppState tries to add a booking
                              .addOuting(key, start, end)) {
                            Navigator.push( //The app returns to the home page if the booking is successful
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(title: 'Roweather')));
                          } else {
                            setState(() { //The appState will not book if outings clash
                              _textPrompt =
                                  'Outing seems to clash with another';
                            });
                          }
                        }
                      },
                      child: Text(
                        'Book',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 48,
                        ),
                      ),
                    ),
                  ),
                ),
                const Card( //Vertical padding
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side:
                            BorderSide(color: Color(0xff85B09A), width: 2.0))),
                Container( //This displays any prompts in case of user error
                  height: 100,
                  child: Text(
                    _textPrompt,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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
                        side:
                            BorderSide(color: Color(0xff85B09A), width: 2.0))),
              ],
            ),
          ),
        ));
  }
}
