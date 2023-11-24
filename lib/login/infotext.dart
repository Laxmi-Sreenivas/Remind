import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String bigText;
  final String smallText;

  const InfoText({super.key,required this.bigText,required this.smallText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              bigText,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
        Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              smallText,
              style: TextStyle(fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
