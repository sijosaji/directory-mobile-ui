import 'package:flutter/material.dart';
import 'package:directory/widgets/HomePage.dart';
import 'package:directory/widgets/FamilyProfile.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final BuildContext parentContext;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.parentContext,
  }) : super(key: key);

  void _onTap(int index) {
    if (index == currentIndex) return;
    
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          parentContext,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          parentContext,
          MaterialPageRoute(builder: (context) => FamilyProfile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: _onTap,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Directory',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}