import 'package:flutter/material.dart';
import 'package:remind/profile/emailquerybox.dart';
import 'package:remind/profile/socialcard.dart';
import 'package:remind/services/services.dart';

class Socials extends StatelessWidget {
  final Service auth;
  const Socials({super.key, required this.auth});

  Future<void> handleGoogleAuth() async {
    print('Google Auth');
    await auth.linkAccountWithGoogle();
  }

  Future<void> handleFacebookAuth() async {
    print('Facebook Auth');
    await auth.linkAccountWithFacebook();
  }

  Future<void> handleEmailAuth(BuildContext context) async {
    print('Email Auth');
    Map<String, String>? result = await context.showEmailPopup(auth);
    String email = result!['email'] ?? "";
    String password = result['password'] ?? "";


    if(email != "" && password != ""){
      await auth.linkAccountWithEmailPassword(email, password);
    }
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
            authHandler: (context) async => {await handleEmailAuth(context)},
          ),
          SocialCard(
            auth: auth,
            account: "facebook",
            authHandler: (context) async => {await handleFacebookAuth()},
          ),
          SocialCard(
            auth: auth,
            account: "google",
            authHandler: (context) async => {await handleGoogleAuth()},
          )
        ],
      ),
    );
  }
}
