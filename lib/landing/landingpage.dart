import 'package:flutter/material.dart';
import 'package:remind/login/loginpage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    //Navigate To New Page After 3s
    Future.delayed(const Duration(milliseconds: 7000), () {
      Navigator.of(context)
          .pushReplacement(NewFadeRoute(builder: (context) => LoginPage()));
    });

    return Scaffold(
      appBar: null,
      body: Column(
        children: <Widget>[
          Spacer(flex: 1),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Image.asset('lib/assets/calender_animated.gif'),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Remind',
              style: TextStyle(fontSize: 45,fontFamily: 'Kdam'),
            ),
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}

//Fading Aniation
class NewFadeRoute extends MaterialPageRoute{
  NewFadeRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}