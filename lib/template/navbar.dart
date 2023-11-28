import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int index;
  final Function update;
  const NavBar({super.key,required this.index,required this.update});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      currentIndex: index,
      onTap: (i) => update(i),
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded), label: "Events"),
        BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add), label: "Add"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2), label: "Profile"),
      ],
    );
  }
}
