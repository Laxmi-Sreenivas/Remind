import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remind/landing/landingpage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Remind());
}

class Remind extends StatelessWidget {
  const Remind({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
