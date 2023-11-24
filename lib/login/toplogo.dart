import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 40,top: 60),
      child: Image.asset(
        'lib/assets/calender.png',
        width: 100,
      ),
    );
  }
}
