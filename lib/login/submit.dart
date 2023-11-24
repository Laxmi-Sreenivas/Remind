import 'package:flutter/material.dart';

class Submit extends StatelessWidget {
  final String submitText;
  final VoidCallback submitAction;

  const Submit({super.key,required this.submitText,required this.submitAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: ElevatedButton(
        onPressed: submitAction,
        child: Text(
          submitText,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
