import 'package:flutter/material.dart';
import 'package:remind/update/timebox.dart';

class DatePicker extends StatefulWidget {
  final Function onPicked;
  const DatePicker({super.key, required this.onPicked});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime pickedDate = DateTime.now();

  Future<void> updateDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != pickedDate) {
      widget.onPicked(picked);
      setState(() {
        pickedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => updateDate(context),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.edit,
                  size: 24,
                ),
                SizedBox(width: 8), // Add some spacing between icon and text
                Text(
                  "Edit Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TimeBox(
                  time: pickedDate.day.toString().padLeft(2, '0'),
                  size: 20,
                ),
                Text(
                  "-",
                  style: TextStyle(fontSize: 20),
                ),
                TimeBox(
                  time: pickedDate.month.toString().padLeft(2, '0'),
                  size: 20,
                ),
                Text(
                  "-",
                  style: TextStyle(fontSize: 20),
                ),
                TimeBox(
                  time: pickedDate.year.toString().padLeft(2, '0'),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
