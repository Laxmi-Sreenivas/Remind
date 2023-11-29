import 'package:remind/services/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Future<MeetingData> fetchAppointments(Service auth) async {
  print('Backend Call For Appointments');
  List<Appointment> appointments = await auth.fetchEvents() ?? [];
  return MeetingData(appointments);
}

class MeetingData extends CalendarDataSource {
  MeetingData(List<Appointment> source) {
    appointments = source;
  }
}
