import 'package:flutter/material.dart';

class SwapPage extends StatelessWidget {
  final String infoText;
  final String tapText;
  final Widget page;

  const SwapPage({super.key,required this.infoText,required this.tapText,required this.page});

  void toPage(BuildContext context) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(infoText),
        GestureDetector(
          onTap: () => toPage(context),
          child: Text(
            tapText,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
