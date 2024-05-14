import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class HomeCalendar extends StatefulWidget{
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendar> {

final CalendarFormat _calendarFormat = CalendarFormat.month;
DateTime _focusedCalendarDate = DateTime.now();
DateTime? selectedCalendarDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select date and time to schedule:'),
      ),
      body: SingleChildScrollView(
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
            TableCalendar(
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
                  color: Color(0xff85B09A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
                formatButtonTextStyle:
                  TextStyle(color: Color(0xff85B09A), fontSize: 16.0),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                 ), ),
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
            )
          ]
        )
      )
    );
  }
}


