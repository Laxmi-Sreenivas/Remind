import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback submitAction;
  const SubmitButton({super.key,required this.submitAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical : 10,horizontal: 80),
      child: ElevatedButton(
        onPressed: submitAction,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          "Add Event",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
