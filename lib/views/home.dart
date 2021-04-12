import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/auth.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: <Widget> [
              const SizedBox(height: 100.0),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff40a8c4),
                      width: 2.0
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xff40a8c4),
                  ),
                  child: Image.asset('assets/logos/logo-nt.png',
                    scale: 1,
                    color: Colors.white,
                  )
                )
              ),
              const SizedBox(width: 20.0),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Hi,', 
                  style: header_text
                ),
              ),
              // add the name of user via backend 
            ]
          ),
        )
      ),
      /*
        put code here :DD
      */  
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff40a8c4),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (){
                  // redirect to home page
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                iconSize: 25.0,
              ),
              IconButton(
                onPressed: (){
                  // redirect to calendar page
                },
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                ),
                iconSize: 25.0,
              ),
              IconButton(
                onPressed: (){
                  // redirect to tasks page
                },
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                iconSize: 25.0,
              ),
              IconButton(
                onPressed: (){
                  // redirect to settings page
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                iconSize: 25.0,
              ),
              IconButton( // Log Out
                onPressed: () async {
                  await _auth.logOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                iconSize: 25.0,
              ),
            ],
          ),
        )
      ),
      // body: Home()
    );
  }
}
