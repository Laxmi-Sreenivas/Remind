import 'package:flutter/material.dart';
import 'package:remind/profile/socialcard.dart';

class Socials extends StatelessWidget {
  const Socials({super.key});

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
            account: "email",
            authHandler: handleEmailAuth,
          ),
          SocialCard(
            account: "facebook",
            authHandler: handleFacebookAuth,
          ),
          SocialCard(
            account: "google",
            authHandler: handleGoogleAuth,
          )
        ],
      ),
    );
  }
}
