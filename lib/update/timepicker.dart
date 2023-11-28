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
  TimeOfDay endTime = TimeOfDay(hour: 1, minute: 0);

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
      widget.onEndTimePicked(picked);
      setState(() {
        endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap if needed for the entire widget
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
    );
  }
}
