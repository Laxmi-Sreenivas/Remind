
import 'package:flutter/material.dart';
import 'package:remind/template/meetings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventPage extends StatefulWidget {
  final MeetingData meetingInfo;
  const EventPage({super.key, required this.meetingInfo});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SfCalendar(
          dataSource: widget.meetingInfo,
          view: CalendarView.month,
          showNavigationArrow: true,
          onSelectionChanged: (calendarSelectionDetails) => {
            setState(() {
              selectedDate = calendarSelectionDetails.date;
            })
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 6),
          child: SfCalendar(
            headerHeight: 0,
            dataSource: widget.meetingInfo,
            minDate: selectedDate,
            maxDate: selectedDate!.add(Duration(seconds: 1)),
          ),
        )
      ],
    );
  }
}
