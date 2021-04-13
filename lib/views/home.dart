import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/auth.dart';

import 'package:super_planner/components/image_button.dart';

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
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: new BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0)
                  )
                ),                
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text(
                      '\"All our dreams can come true, if we have the courage to pursue them.\”\n\- Walt Disney', 
                      style: quote_tab_text 
                    )
                  ],
                )
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
              Container(
                // constraints: BoxConstraints.expand(
                //   height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
                // ),
                padding: const EdgeInsets.all(30.0),
                decoration: new BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0)
                  )
                ),                
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.orange,
                          size: 20.0,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Text( 
                          '10:30 AM - 12:00PM', 
                          style: time_tabs_text
                        ),                      
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( 
                          'CS 33 Data Structures', 
                          style: title_tabs_text
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('Lecture'),
                          )
                        )                                              
                      ],
                    ),  
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Text( 
                          'Mr Kevin Buno // Zoom', 
                          style: notes_tabs_text
                        )                    
                      ],
                    )
                  ],
                )
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
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: new BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0)
                  )
                ),                
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.purple,
                          size: 20.0,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Text( 
                          '6:00 PM - 7:00PM', 
                          style: time_tabs_text
                        ),                      
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( 
                          'CS 192 Sprint', 
                          style: title_tabs_text
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('Study Group'),
                          )
                        )                                              
                      ],
                    ),  
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Text( 
                          'CS 192 Group 2 Teammates // Discord', 
                          style: notes_tabs_text
                        )                    
                      ],
                    )
                  ],
                )
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
