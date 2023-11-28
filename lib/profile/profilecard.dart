import 'package:flutter/material.dart';


class ProfileCard extends StatelessWidget {
  final String name;
  final String date;
  const ProfileCard({super.key,required this.name,required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('lib/assets/user.png'),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '* Member Since $date',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
