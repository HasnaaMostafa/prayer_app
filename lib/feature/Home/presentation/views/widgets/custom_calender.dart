import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalender extends StatefulWidget {
  const CustomCalender({
    super.key,
    required this.onDaySelected,
  });

  final Function(DateTime) onDaySelected;

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
        color: const Color(0xffdcf9f7),
        child: TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          locale: "en_US",
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                  // color: Color(0xff546381),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              formatButtonVisible: false,
              titleCentered: true),
          availableGestures: AvailableGestures.all,
          calendarFormat: CalendarFormat.week,
          calendarStyle: const CalendarStyle(
            isTodayHighlighted: true,
            selectedTextStyle: TextStyle(color: Color(0xff4ee4df)),
            todayTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff4ee4df),
            ),
          ),
          currentDay: _selectedDay,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
            widget.onDaySelected(selectedDay); // Invoke the callback
          },
        ));
  }
}
