import 'package:flutter/material.dart';
import 'package:remind/services/services.dart';
import 'package:remind/template/templatepage.dart';

class Options extends StatelessWidget {
  final Service auth;
  const Options({super.key, required this.auth});

  handleFacebookLogin(BuildContext context) async {
    print('Facebook Login');
    try {
      bool authWorked = await auth.facebookAuth();

      if (authWorked) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TemplatePage(
                    auth: auth,
                    loginMethod: "Facebook OAuth",
                  )),
        );
      } else {
        print("Facebook Auth Failed");
      }
    } catch (e) {
      print("Facebook Oauth Error : ");
      print(e);
    }
  }

  handleGoogleLogin(BuildContext context) async {
    print('Google Login');
    try {
      bool authWorked = await auth.googleAuth();

      if (authWorked) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TemplatePage(
                    auth: auth,
                    loginMethod: "Google OAuth",
                  )),
        );
      } else {
        print("Google Auth Failed");
      }
    } catch (e) {
      print("Google Oauth Error : ");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Or connect with',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () async => {await handleFacebookLogin(context)},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('lib/assets/facebook.png'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async => {await handleGoogleLogin(context)},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('lib/assets/google.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
