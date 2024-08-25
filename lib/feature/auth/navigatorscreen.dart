
import 'package:flutter/material.dart';
import 'package:habittrackerapp/feature/appscreens/HomeScreen.dart';
import 'package:habittrackerapp/feature/appscreens/habit_title.dart';
import 'package:habittrackerapp/feature/appscreens/profileScreen.dart';
import 'package:habittrackerapp/feature/appscreens/progress.dart';

// ignore: must_be_immutable
class Navigatorscreen extends StatefulWidget {
  Navigatorscreen({required this.currentIndex});
  int currentIndex;

  @override
  State<Navigatorscreen> createState() => _NavigatorscreenState();
}
const List<Widget> screens = [
  Homescreen(),
  Progressscreen(),
  HabitsScreen(),
  Profilescreen()
];

class _NavigatorscreenState extends State<Navigatorscreen> {
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Habits"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
      
    );
  }
}
























