
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:super_planner/components/display_tabs.dart';
import 'package:super_planner/components/display_task.dart';
import 'package:super_planner/components/quote_tabs.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/auth.dart';
import 'package:super_planner/components/small_button.dart';

import 'package:super_planner/models/user.dart';
import 'package:provider/provider.dart';
import 'package:super_planner/views/calendar/add_event.dart';

import 'package:super_planner/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_planner/views/tasks/add_task.dart';
import 'package:super_planner/services/db.dart';
<<<<<<< HEAD
import 'package:super_planner/views/tasks/view_task.dart';
=======
import 'package:intl/intl.dart';
>>>>>>> 1162f89fa56096753dddd2b69324819679a74e37
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final DBService db = DBService();

  @override
  Widget build(BuildContext context) {
    
    var user = FirebaseAuth.instance.currentUser;
    String _displayName = 'User';

    if (user != null) {
      _displayName = user.displayName;
      print('DISPLAY NAME: $_displayName');
    }
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                children: <Widget> [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.19),
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
                      child: Image.asset(
                        'assets/logos/logo-nt.png',
                        scale: 1,
                        color: Colors.white,
                        width: 50
                      )
                    )
                  ),
                  SizedBox(width: 20.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text( 
                          'Hi,', 
                          style: header_text
                        ),
                        SizedBox(width: 5.0),
                        Text( 
                         _displayName == null ? 'User' : _displayName, 
                          style: header_text
                        ),
                        Text( 
                          '!', 
                          style: header_text
                        ),                    
                      ],
                    )
                  ),                        
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( 
                    'Quote of the Day', 
                    style: section_title_text
                  ),
                  SmallButton(
                    height: 35, 
                    width: 35,
                    image: 'assets/images/edit_btn.png'
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              QuoteTab(
                color: Colors.blue[100], 
                quote: '\"All our dreams can come true, if we have the courage to pursue them.\”\n\- Walt Disney'
              ),            
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( 
                    'Today\'s Classes', 
                    style: section_title_text
                  ),
                  SmallButton(
                    height: 35, 
                    width: 35,
                    image: 'assets/images/add_btn.png', 
                    press:  () {
                      Navigator.push(
                      context,MaterialPageRoute(builder: (context) => AddEvent()));
                    },
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              FutureBuilder(
                future: db.getEvents(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    var events = snapshot.data;
              
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: events != null ? events.length : 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            DisplayTabs(
                              color: Colors.orange[100],
                              icon_color: Colors.orange,
                              time: showTime(events[index]['startTime'], events[index]['endTime']),
                              event: events[index]['title'],
                              tags: listTags(events[index]['categories']),
                              notes: events[index]['notes'],
                            ),
                          ],
                        );
                      },
                    );
                  }
                  
                  return Container();
                },
              ),
              // DisplayTabs(
              //   color: Colors.orange[100],
              //   icon_color: Colors.orange,
              //   time: '10:30 AM - 12:00PM',
              //   event: 'CS 33 Data Structures',
              //   tags: 'Lecture', 
              //   notes: 'Mr Kevin Buno // Zoom'
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( 
                    'Today\'s Meetings', 
                    style: section_title_text
                  ),
                  SmallButton(
                    height: 35, 
                    width: 35,
                    image: 'assets/images/add_btn.png', 
                    press:  () => Navigator.push(
                      context,MaterialPageRoute(builder: (context) => AddEvent()),
                    )
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              DisplayTabs(
                color: Colors.purple[100],
                icon_color: Colors.purple,
                time: '6:00 PM - 7:00PM',
                event: 'CS 192 Sprint',
                tags: 'Meeting', 
                notes: 'CS 192 Group 2 Teammates // Discord'
              ),                   
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( 
                    'My Tasks', 
                    style: section_title_text
                  ),
                  SmallButton(
                    height: 35, 
                    width: 35,
                    image: 'assets/images/add_btn.png',
                    press:  () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AddTask()),
                    )
                  )
                ],
              ),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
              FutureBuilder(
                future: db.getTasks(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    var tasks = snapshot.data;
              
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks != null ? tasks.length : 0,
                      itemBuilder: (context, index) {
                        return 
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => ViewTask(task: tasks[index])) 
                                  );
                                },
                                child: DisplayTask(
                                  taskName: tasks[index]['title'],
                                ),
                              ),
                              SizedBox(height: 5.0)
                            ],
                          );
                        
                      },
                    );
                  }
                  
                  return Container();
                },
              ),
            ],
          )
        ), 
      ),
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
                onPressed: () async {
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                    builder: (context) => Login()),
                  );
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
    );
  }

  String showTime(Timestamp start, Timestamp end) {
    DateTime startDateTime = DateTime.fromMicrosecondsSinceEpoch(start.microsecondsSinceEpoch);
    DateTime endDateTime = DateTime.fromMicrosecondsSinceEpoch(end.microsecondsSinceEpoch);

    String s = DateFormat.jm().format(startDateTime);
    String e = DateFormat.jm().format(endDateTime);

    return (s + ' - ' + e);
  }

  String listTags(List<dynamic> categories) {
    List<String> list = [];
    if (categories.length == 0) return "";
    for (String tag in categories) list.add(tag);
    return list.join(', ');
  }
}
