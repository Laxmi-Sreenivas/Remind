import 'package:flutter/material.dart';

class Subject extends StatelessWidget {
  final TextEditingController subjectController;
  const Subject({super.key, required this.subjectController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const [
              Icon(
                Icons.note,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                "Add Subject",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 25),
          TextField(
            controller: subjectController,
            decoration: InputDecoration(
              hintText: 'Subject',
              border: OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}
