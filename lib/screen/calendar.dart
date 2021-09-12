// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(300, 800),
        orientation: Orientation.portrait);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF02B3E8),
                Color(0xFF1A55B3),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, bottom: 20.0),
                      height: 45.0,
                      width: 45.0,
                      child: Image.asset(
                        "images/back.png",
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 87.0.w, top: 20.0),
                      height: 50.0,
                      width: 50.0,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                ]),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    height: 35.0,
                    width: 90.0.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: Text(
                        "User 4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(
                  thickness: 3.0,
                  height: 2.0,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: TableCalendar(
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                        weekdayStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    calendarFormat: format,
                    focusedDay: selectedDay,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    daysOfWeekVisible: true,
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                    },

                    // ignore: prefer_const_constructors
                    calendarStyle: CalendarStyle(

                        // defaultDecoration: BoxDecoration(color: Colors.white),
                        defaultTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                        selectedTextStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        weekendTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                        isTodayHighlighted: true,
                        selectedDecoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        todayDecoration: const BoxDecoration(
                            color: Colors.deepOrange, shape: BoxShape.circle)),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    headerStyle: HeaderStyle(
                        headerMargin: EdgeInsets.only(bottom: 15.0),
                        formatButtonVisible: false,
                        titleCentered: true,
                        leftChevronIcon: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                        ),
                        rightChevronIcon: Icon(
                          CupertinoIcons.forward,
                          color: Colors.white,
                        ),
                        titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0)),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 18.0, right: 18.0),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "MONTHLY TOTAL:",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Text(
                              "₹100000",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ]))
              ],
            ),
          ),
        )
      ],
    )));
  }
}
