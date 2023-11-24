import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  void handleFacebookLogin(){
    print('Facebook Login');
  }

  void handleGoogleLogin(){
    print('Google Login');
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
                onTap: handleFacebookLogin,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('lib/assets/facebook.png'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: handleGoogleLogin,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('lib/assets/google.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
