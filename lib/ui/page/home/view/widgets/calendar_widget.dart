import 'dart:html';
import 'package:control_stock/ui/colors_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

AppColor StyleApp = AppColor();

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StyleApp.ColorContainer(context),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("MMM, yyyy").format(_focusedDay),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: StyleApp.ColorText(context)),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month - 1);
                      });
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: StyleApp.ColorText(context),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month + 1);
                      });
                    },
                    child: Icon(
                      Icons.chevron_right,
                      color: StyleApp.ColorText(context),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Calendario(),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Calendario() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2010),
      lastDay: DateTime.utc(2040),
      headerVisible: false,
      onFormatChanged: (result) {},
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) {
          return DateFormat("EEE").format(date).toUpperCase();
        },
        weekendStyle: TextStyle(
            fontWeight: FontWeight.bold, color: StyleApp.ColorText(context)),
        weekdayStyle: TextStyle(
            fontWeight: FontWeight.bold, color: StyleApp.ColorText(context)),
      ),
      onPageChanged: (day) {
        setState(() {
          _focusedDay = day;
        });
      },
      calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: StyleApp.ColorContText(),
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: StyleApp.ColorContText(),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(color: StyleApp.ColorText(context))),
      eventLoader: (day) {
        ///make event on 22 and 12 date every month
        if (day.day == 22 || day.day == 12) {
          return [Event("Event Name", canBubble: true)];
        }
        return [];
      },
    );
  }
}
