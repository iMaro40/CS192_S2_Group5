import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:super_planner/components/display_tabs.dart';
import 'package:super_planner/components/display_task.dart';
import 'package:super_planner/components/quote_tabs.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/views/calendar/add_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_planner/views/calendar/view_event.dart';
import 'package:super_planner/views/tasks/add_task.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/views/tasks/view_task.dart';
import 'package:super_planner/views/quote/edit_quote.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DBService db = DBService();
  String? quote = '';
  dynamic events = [];
  dynamic classes = [];
  dynamic meetings = [];
  dynamic exams = [];

  void initState() {
    super.initState();
    db.getQuote().then((q) {
      if (q != null) quote = q['quote'];
    }).onError((dynamic error, stackTrace) => null);

    db.getEvents().then((eventsData) {
      setState(() {
        events = eventsData;

        for (dynamic event in events) {
          DateTime startDateTime =
              DateTime.fromMicrosecondsSinceEpoch(event['startTime'].microsecondsSinceEpoch);
          if (isSameDay(startDateTime, DateTime.now())) {
            if (event['categories'].contains('Class')) {
              classes.add(event);
            } else if (event['categories'].contains('Meeting')) {
              meetings.add(event);
            } else {
              exams.add(event);
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    String? _displayName = 'User';

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
                Row(children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.19),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff40a8c4), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xff40a8c4),
                          ),
                          child: Image.asset('assets/logos/logo-nt.png',
                              scale: 1, color: Colors.white, width: 50))),
                  SizedBox(width: 20.0),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text('Hi,', style: header_text),
                          SizedBox(width: 5.0),
                          Text(_displayName == null ? 'User' : _displayName,
                              style: header_text),
                          Text('!', style: header_text),
                        ],
                      )),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quote of the Day', style: section_title_text),
                    SmallButton(
                      height: 35,
                      width: 35,
                      image: 'assets/images/edit_btn.png',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditQuote()));
                      },
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                FutureBuilder(
                  future: db.getQuote(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && quote != '') {
                      return QuoteTab(
                        color: Colors.blue[100],
                        quote: quote,
                      );
                    }

                    return EmptyTab(
                      color: Colors.blue[100],
                      text: "You don't have a quote yet!",
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today\'s Classes', style: section_title_text),
                    SmallButton(
                      height: 35,
                      width: 35,
                      image: 'assets/images/add_btn.png',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEvent(defaultCategories: ['Class'],)));
                      },
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // FutureBuilder(
                //   future: db.getEvents(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       dynamic events = snapshot.data;

                //       if (events.length == 0) {
                //         return EmptyTab(
                //           color: Colors.orange[100],
                //           text: "You don't have classes today!",
                //         );
                //       }

                //       return ListView.builder(
                //         shrinkWrap: true,
                //         itemCount: events != null ? events.length : 0,
                //         itemBuilder: (context, index) {
                //           return Column(
                //             children: [
                //               GestureDetector(
                //                 onTap: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) =>
                //                               ViewEvent(event: events[index])));
                //                 },
                //                 child: DisplayTabs(
                //                   color: Colors.orange[100],
                //                   icon_color: Colors.orange,
                //                   time: showTime(events[index]['startTime'],
                //                       events[index]['endTime']),
                //                   event: events[index]['title'],
                //                   tags: listTags(events[index]['categories']),
                //                   notes: events[index]['notes'],
                //                 ),
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     }

                //     return EmptyTab(
                //       color: Colors.blue[100],
                //       text: "You don't have classes today!",
                //     );
                //   },
                // ),
                getClasses(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today\'s Meetings', style: section_title_text),
                    SmallButton(
                        height: 35,
                        width: 35,
                        image: 'assets/images/add_btn.png',
                        press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEvent(defaultCategories: ['Meeting'],)),
                            ))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                getMeetings(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today\'s Quizzes & Exams', style: section_title_text),
                    SmallButton(
                        height: 35,
                        width: 35,
                        image: 'assets/images/add_btn.png',
                        press: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEvent(defaultCategories: [],)),
                            ))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                getExams(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              ],
            )),
      ),
    );
  }

  Widget getClasses() {
    dynamic events = classes;

    if (events.length == 0) {
      return EmptyTab(
        color: Colors.orange[100],
        text: "You don't have classes today!",
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: events != null ? events.length : 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEvent(event: events[index])));
              },
              child: DisplayTabs(
                color: Colors.orange[100],
                icon_color: Colors.orange,
                time: showTime(
                    events[index]['startTime'], events[index]['endTime']),
                event: events[index]['title'],
                tags: listTags(events[index]['categories']),
                notes: events[index]['notes'],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getMeetings() {
    dynamic events = meetings;

    if (events.length == 0) {
      return EmptyTab(
        color: Colors.purple[100],
        text: "You don't have meetings today!",
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: events != null ? events.length : 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEvent(event: events[index])));
              },
              child: DisplayTabs(
                color: Colors.purple[100],
                icon_color: Colors.purple,
                time: showTime(
                    events[index]['startTime'], events[index]['endTime']),
                event: events[index]['title'],
                tags: listTags(events[index]['categories']),
                notes: events[index]['notes'],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getExams() {
    List events = exams;

    if (events.length == 0) {
      return EmptyTab(
        color: Colors.pink[100],
        text: "You don't have exams today!",
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEvent(event: events[index])));
              },
              child: DisplayTabs(
                color: Colors.pink[100],
                icon_color: Colors.pink,
                time: showTime(
                    events[index]['startTime'], events[index]['endTime']),
                event: events[index]['title'],
                tags: listTags(events[index]['categories']),
                notes: events[index]['notes'],
              ),
            ),
          ],
        );
      },
    );
  }

  String showTime(Timestamp start, Timestamp end) {
    DateTime startDateTime =
        DateTime.fromMicrosecondsSinceEpoch(start.microsecondsSinceEpoch);
    DateTime endDateTime =
        DateTime.fromMicrosecondsSinceEpoch(end.microsecondsSinceEpoch);

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
