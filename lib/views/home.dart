
import 'package:flutter/material.dart';
import 'package:super_planner/components/display_tabs.dart';
import 'package:super_planner/components/quote_tabs.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/auth.dart';

import 'package:super_planner/components/small_button.dart';

import 'package:super_planner/models/user.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
 
  @override
  Widget build(BuildContext context) {
    // String _displayName = Provider.of<CustomUser>(context).getName();
    // print('DISPLAY NAME: $_displayName');
    
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
                         'John', 
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
                    image: 'assets/images/add_btn.png'
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              DisplayTabs(
                color: Colors.orange[100],
                icon_color: Colors.orange,
                time: '10:30 AM - 12:00PM',
                event: 'CS 33 Data Structures',
                tags: 'Lecture', 
                notes: 'Mr Kevin Buno // Zoom'
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( 
                    'Today\'s Meetings', 
                    style: section_title_text
                  ),
                  SmallButton(
                    image: 'assets/images/add_btn.png'
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
              /*ADD OTHER ELEMENTS HERE*/
            ],
          )
        ), 
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
