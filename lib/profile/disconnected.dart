import 'package:flutter/material.dart';

class DisConnected extends StatelessWidget {
  final String account;
  final Function authHandler;
  const DisConnected({super.key,required this.account,required this.authHandler});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {authHandler()},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 15, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlueAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/assets/$account.png'),
              radius: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Haven't Linked to $account ?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Consider Linking For Easier Login",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}