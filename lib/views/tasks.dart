import 'package:flutter/material.dart';
import 'package:super_planner/components/task_category.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/db.dart';
import 'package:intl/intl.dart';
import 'package:super_planner/views/tasks/add_task.dart';


class Tasks extends StatefulWidget {
  @override
  _Tasks createState() => _Tasks();
}


class _Tasks extends State<Tasks> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 80.0),
              Align(
                alignment: Alignment.topLeft,
                child:
                  Column(
                    children: [
                      Text('MY TASKS', style: header_text), 
                      Text('Category name', style: subheader_text) //fetch tasks category
                    ],
                  )
              ), 
              SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row( //Task category initials
                  children: [
                    TaskCategory(category_initial: 'A'), //fetch category initial
                    TaskCategory(category_initial: 'W'),
                  ],
                ),
              ), 
              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              //**INSERT TASKS HERE**
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: dark_blue,
      ),
    );
  }
}



