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
  String selectedCategory = 'All';
  
  Set categoriesSet = Set();
  

  final DBService db = DBService();
  dynamic tasks = [];
  dynamic toDisplay = [];

  void initState(){
      super.initState();
      
      //add 'All' to display all tasks
      categoriesSet.add('All');

      db.getTasks().then((tasksData) {
        setState(() {
          tasks = tasksData;
          toDisplay = tasks;
          for(dynamic task in tasks) {
            for(dynamic category in task['categories']) {
              categoriesSet.add(category);
            }
          }
          
          selectedCategory = categoriesSet.first.toString();
        });
      });
  }

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
                      DropdownButton(
                        value: selectedCategory,
                        items: categoriesSet.toList()
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                            if(selectedCategory == 'All') {
                              toDisplay = tasks;
                            }
                            else {
                              toDisplay = [];
                              for(dynamic task in tasks) {
                                if(task['categories'].contains(selectedCategory)) {
                                  toDisplay.add(task);
                                }
                              }
                            }
                          });
                        },
                      )
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: toDisplay?.length,
                itemBuilder: (context, index) {
                  return Column(//DISPLAY TASKS HERE
                    children: [
                      Text(toDisplay[index]['title']),
                      SizedBox(height: 5.0)
                    ],
                  );
                }
              ),
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



