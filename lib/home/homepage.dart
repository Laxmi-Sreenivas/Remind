import 'package:flutter/material.dart';
import 'package:remind/template/meetings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  final MeetingData meetingInfo;
  const HomePage({super.key,required this.meetingInfo});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      dataSource: meetingInfo,
      view: CalendarView.day,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(Duration(seconds: 1)),
    );
  }
}

