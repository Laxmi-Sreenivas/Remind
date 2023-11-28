import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Future<MeetingData> fetchAppointments() async {
  List<Appointment> appointments = <Appointment>[];
  //Fetch Data From Backend

  appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(minutes: 1)),
      endTime: DateTime.now().add(Duration(minutes: 30)),
      subject: "Mock Meeting",
      color: Colors.blue));

  print('Backend Call For Appointments');
  return await Future.delayed(
      Duration(seconds: 2), () => MeetingData(appointments));
}

class MeetingData extends CalendarDataSource {
  MeetingData(List<Appointment> source) {
    appointments = source;
  }
}
