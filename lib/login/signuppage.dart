import 'package:flutter/material.dart';
import 'package:remind/login/infotext.dart';
import 'package:remind/login/inputfield.dart';
import 'package:remind/login/loginpage.dart';
import 'package:remind/login/options.dart';
import 'package:remind/login/submit.dart';
import 'package:remind/login/swappage.dart';
import 'package:remind/login/toplogo.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void signup(){
      print(username.text);
      print(password.text);


      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Placeholder()),
      // );
    }

    return Scaffold(
      appBar: null,
      body: ListView(
        children: <Widget>[
          TopLogo(),
          InfoText(
            bigText: 'Sign Up Now',
            smallText: 'Please fill the details & create account',
          ),
          InputField(
              controllers: [username, password],
              hintTexts: const ['Username', 'Password']),
          Submit(
            submitText: 'Sign Up',
            submitAction: signup,
          ),
          SwapPage(
            infoText: 'Already have an account ? ',
            tapText: 'Login',
            page: LoginPage(),
          ),
          Options(),
        ],
      ),
    );
  }
}