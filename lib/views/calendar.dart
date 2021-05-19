import 'package:flutter/material.dart';
import 'package:super_planner/components/calendar_widget.dart';
import 'package:super_planner/components/screen_header.dart';
import 'package:super_planner/constants.dart';
import 'package:intl/intl.dart';


class Calendar extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  String date = DateFormat.yMMMMd('en_US').format(DateTime.now());// 28/03/2020

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ScreenHeader(
              title: 'TODAY\'S DATE', 
              subtitle: date, 
              press: () {Navigator.pop(context);}
            ), 
            TableBasicsExample()
          ],
        ),
      ),
    );
  }
}

