import 'package:flutter/material.dart';
import 'package:remind/update/timebox.dart';

class TimePicker extends StatefulWidget {
  final Function onStartTimePicked;
  final Function onEndTimePicked;

  const TimePicker({
    Key? key,
    required this.onStartTimePicked,
    required this.onEndTimePicked,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay startTime = TimeOfDay(hour: 1, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 2, minute: 30);

  Future<void> updateStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null && picked != startTime) {
      widget.onStartTimePicked(picked);
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> updateEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );

    if (picked != null && picked != endTime) {
      endTime = picked;
      if (validEndTime()) {
        widget.onEndTimePicked(picked);
        setState(() {
          endTime = picked;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Enter Valid end time'),
            duration: Duration(seconds: 2),
          ),
        );

        setState(() {
          endTime = startTime;
        });
      }
    }
  }

  bool validEndTime() {
    // Check if start time is less than end time
    return startTime.hour < endTime.hour ||
        (startTime.hour == endTime.hour && startTime.minute < endTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.access_time,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                "Edit Time",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => updateStartTime(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TimeBox(
                  time: startTime.hour.toString().padLeft(2, '0'),
                  size: 40,
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: 30),
                ),
                TimeBox(
                  time: startTime.minute.toString().padLeft(2, '0'),
                  size: 40,
                ),
                Spacer(),
                Text(
                  "(Start Time)",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => updateEndTime(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TimeBox(
                  time: endTime.hour.toString().padLeft(2, '0'),
                  size: 40,
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: 30),
                ),
                TimeBox(
                  time: endTime.minute.toString().padLeft(2, '0'),
                  size: 40,
                ),
                Spacer(),
                Text(
                  "(End Time)",
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
