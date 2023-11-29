import 'package:flutter/material.dart';
import 'package:remind/login/loginpage.dart';
import 'package:remind/profile/logout.dart';
import 'package:remind/profile/profilecard.dart';
import 'package:remind/profile/socials.dart';
import 'package:remind/profile/sync.dart';
import 'package:remind/services/services.dart';

class Profilepage extends StatelessWidget {
  final Service auth;
  const Profilepage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      auth.logout();
      print("Logged Out");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    Future<void> syncData() async{
      print("Synching Data");
      await auth.syncData();
    }

    //Fetching User Info
    String name = auth.fetchField("username") ?? "";
    String date = auth.fetchField("date") ?? "";

    return ListView(
      children: <Widget>[
        ProfileCard(name: name, date: date),
        Socials(auth: auth),
        Sync(submitAction: syncData),
        Logout(submitAction: signOut)
      ],
    );
  }
}
