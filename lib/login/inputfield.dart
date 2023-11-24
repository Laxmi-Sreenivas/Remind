import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<String> hintTexts;

  const InputField(
      {super.key, required this.controllers, required this.hintTexts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        controllers.length,
        (i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child: TextField(
            controller: controllers[i],
            decoration: InputDecoration(
              hintText: hintTexts[i],
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
