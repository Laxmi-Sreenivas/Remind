import 'package:flutter/material.dart';

class TimeBox extends StatelessWidget {
  final String time;
  final double size;
  const TimeBox({super.key,required this.time,required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal : 5,vertical: 20),
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: size,
          color: Colors.blue
        ),
      ),
    );
  }
}
