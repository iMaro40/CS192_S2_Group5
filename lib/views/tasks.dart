import 'package:flutter/material.dart';
import 'package:super_planner/components/display_task.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/views/tasks/add_task.dart';
import 'package:super_planner/views/tasks/view_task.dart';

class Tasks extends StatefulWidget {
  @override
  _Tasks createState() => _Tasks();
}


class _Tasks extends State<Tasks> {
  String selectedCategory = 'All';
  
  Set categoriesSet = Set();
  

  final DBService db = DBService();
  dynamic tasks = [];
  dynamic allNotDone = [];
  dynamic allDone = [];
  dynamic toDisplay = [];

  void initState(){
      super.initState();
      
      //add 'All' to display all not done tasks
      categoriesSet.add('All');

      db.getTasks().then((tasksData) {
        setState(() {
          tasks = tasksData;
          
          for(dynamic task in tasks) {
            if(task['done']) {
              allDone.add(task);
            }
            else {
              for(dynamic category in task['categories']) {
                categoriesSet.add(category);
              }
              allNotDone.add(task);
            }
          }
          
          toDisplay = allNotDone;
          selectedCategory = categoriesSet.first.toString();
          //add 'Completed Tasks' to display done tasks
          categoriesSet.add('Completed Tasks');
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
                alignment: Alignment.centerLeft,
                child: Text(
                  'MY TASKS', style: header_text, textAlign: TextAlign.left)
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid, width: 0.5),
                    ),                     
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0, right: 20.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(                            
                          isExpanded: true,
                          elevation: 0,
                          hint: new Text("Pick a cateogry"),
                          value: selectedCategory,
                          style: const TextStyle(color: dark_blue, fontSize: 16),
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
                                toDisplay = allNotDone;
                              }
                              else if(selectedCategory == 'Completed Tasks') {
                                toDisplay = allDone;
                              }
                              else {
                                toDisplay = [];
                                for(dynamic task in tasks) {
                                  if(task['categories'].contains(selectedCategory) && !task['done']) {
                                    toDisplay.add(task);
                                  }
                                }
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ), 
              Divider(
                height: 50,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: toDisplay?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ViewTask(task: tasks[index])) 
                          );
                        },
                        child: DisplayTask(
                          task: toDisplay[index],
                        ),
                      ),
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



