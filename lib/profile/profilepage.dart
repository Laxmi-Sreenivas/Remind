import 'package:flutter/material.dart';
import 'package:remind/login/loginpage.dart';
import 'package:remind/profile/logout.dart';
import 'package:remind/profile/profilecard.dart';
import 'package:remind/profile/socials.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    return ListView(
      children: <Widget>[
        ProfileCard(name: "Laxmi Sreenivas", date: "21-10-2003"),
        Socials(),
        Logout(submitAction: signOut)
      ],
    );
  }
}
