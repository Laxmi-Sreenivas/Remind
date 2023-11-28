import 'package:flutter/material.dart';
import 'package:remind/update/datepicker.dart';
import 'package:remind/update/subject.dart';
import 'package:remind/update/submit.dart';
import 'package:remind/update/timepicker.dart';

class AddMeetingPage extends StatelessWidget {
  final Function onUpdate;
  AddMeetingPage({super.key, required this.onUpdate});

  final TextEditingController subject = TextEditingController();
  TimeOfDay startTime = TimeOfDay(hour: 1, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 1, minute: 0);
  DateTime selectedDate = DateTime.now();

  onSubmit() async {
    print(subject.text);
    print(startTime);
    print(endTime);

    //Send The Event Data to Backend

    onUpdate();
  }

  onStartTimeSelected(pickedTime) {
    startTime = pickedTime;
  }

  onEndTimeSelected(pickedTime) {
    endTime = pickedTime;
  }

  onDateSelected(pickedDate) {
    selectedDate = pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10),
        DatePicker(onPicked: onDateSelected),
        TimePicker(onStartTimePicked: onStartTimeSelected,onEndTimePicked: onEndTimeSelected,),
        Subject(subjectController: subject),
        SizedBox(height: 20),
        SubmitButton(submitAction: () async => {await onSubmit()})
      ],
    );
  }
}
