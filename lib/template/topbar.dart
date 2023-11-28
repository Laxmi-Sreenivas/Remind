import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Colors.blue,
      title: Text(
        "Remind",
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'Kdam',
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
