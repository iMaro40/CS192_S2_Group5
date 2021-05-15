import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../views/login.dart';
import '../views/home.dart';

List<Widget> _widgetDisplay = <Widget>[
   Home(),
   Center(
     child: Text(
       'PUT VIEW 2 HERE',
       textAlign: TextAlign.center,
     ),
   ),
   Center(
     child: Text(
       'PUT VIEW 3 HERE',
       textAlign: TextAlign.center,
     ),
   ),
   Center(
     child: Text(
       'PUT VIEW 4 HERE, probably put log out here',
       textAlign: TextAlign.center,
     ),
   ),
];

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}
class _DisplayState extends State<Display> {
  int currentTab = 0;
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if(user == null) {
      return Login();
    }
    else {
      return Scaffold(
        body: _widgetDisplay[currentTab],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff40a8c4),
          onTap: (int index) {
            setState(() {
             currentTab = index;
            });
          },
          currentIndex: currentTab,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 25.0,
              ),
              label: 'Home',
              backgroundColor: Color(0xff40a8c4),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                    size: 25.0,
              ),
              label: 'Calendar',
              backgroundColor: Color(0xff40a8c4),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 25.0,
              ),
              label: 'Notifications',
              backgroundColor: Color(0xff40a8c4),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
              ),
              label: 'Settings',
              backgroundColor: Color(0xff40a8c4),
            ),
          ],
        ),
      );
    }
  }
}