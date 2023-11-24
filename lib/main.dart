import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:remind/landing/landingpage.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const Remind());
}

class Remind extends StatelessWidget {
  const Remind({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}
