import 'package:flutter/material.dart';
import 'package:remind/login/infotext.dart';
import 'package:remind/login/inputfield.dart';
import 'package:remind/login/options.dart';
import 'package:remind/login/signuppage.dart';
import 'package:remind/login/submit.dart';
import 'package:remind/login/swappage.dart';
import 'package:remind/login/toplogo.dart';
import 'package:remind/template/templatepage.dart';
import 'package:remind/services/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final Service _auth = Service();

  @override
  void dispose() {
    password.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    login() async {
      print(email.text);
      print(password.text);

      bool userExits = await _auth.logInWithEmailandPassword(email.text, password.text);

      if (userExits) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TemplatePage(auth: _auth)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Error'),
          duration: Duration(seconds: 2),
        ));
      }
    }

    return Scaffold(
      appBar: null,
      body: ListView(
        children: <Widget>[
          TopLogo(),
          InfoText(
            bigText: 'Login Now',
            smallText: 'Please login to continue using our app',
          ),
          InputField(
              controllers: [email, password],
              hintTexts: const ['E-mail', 'Password']),
          Submit(
            submitText: 'Login',
            submitAction: login,
          ),
          SwapPage(
            infoText: 'Don\'t have an account ? ',
            tapText: 'Sign Up',
            page: SignUpPage(),
          ),
          Options(auth: _auth),
        ],
      ),
    );
  }
}
