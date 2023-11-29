import 'package:flutter/material.dart';
import 'package:remind/profile/socialcard.dart';
import 'package:remind/services/services.dart';

class Socials extends StatelessWidget {
  final Service auth;
  const Socials({super.key,required this.auth});

  void handleGoogleAuth() {
    print('Google Auth');
  }

  void handleFacebookAuth() {
    print('Facebook Auth');
  }

  void handleEmailAuth() {
    print('Outlook Auth');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Socials",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SocialCard(
            auth: auth,
            account: "email",
            authHandler: handleEmailAuth,
          ),
          SocialCard(
            auth: auth,
            account: "facebook",
            authHandler: handleFacebookAuth,
          ),
          SocialCard(
            auth: auth,
            account: "google",
            authHandler: handleGoogleAuth,
          )
        ],
      ),
    );
  }
}
