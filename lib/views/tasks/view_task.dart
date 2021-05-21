import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/back_button.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/views/calendar/add_event.dart';
import 'package:super_planner/views/home.dart';
import 'package:super_planner/views/tasks/edit_task.dart';
import 'package:intl/intl.dart';
import 'package:super_planner/screens/display.dart';

class ViewTask extends StatefulWidget {
  final dynamic task;
  const ViewTask({Key? key,required this.task}) : super(key: key);

  @override
  _ViewTask createState() => _ViewTask();
}


class _ViewTask extends State<ViewTask> {
  final TextEditingController _tasktitleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  //List<String> categories = [];
  

  final addTaskFormKey = GlobalKey<FormState>();

  final DBService db = DBService();

  bool _loading = false;
  var formatter = new DateFormat('dd-MM-yyyy');

  DateTime selectedDate = DateTime.now();
  String _reminder = "1 day before";

    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2019, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          var date =
              "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
          _dateController.text = date;
        });
    }
  
  Future<String?> createAlertDialog(BuildContext context){
 
    return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Delete Task?"),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop('Yes');
              },
            ),
            MaterialButton(
              elevation: 5.0,
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop('No');
              },
            )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var rawReminders = [
      "1 hour before", 
      "6 hours before", 
      "1 day before", 
      "2 days before"
    ]; 

    var reminder = rawReminders.map((element) {
      return DropdownMenuItem(
        child: Text(element, style: TextStyle(fontSize: 16)),
        value: element,
      );
    }).toList();


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: addTaskFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Align(
                alignment: FractionalOffset(0.075,0.6),
                child: SmallButton(
                  height: 20, 
                  width: 20,
                  image: 'assets/icons/back_icon.png',
                  press: () async {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Display(), // or maybe pass the new editted task here
                      ),
                      (route) => false,
                    );
                  }
                ),
              ),
              Padding (
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TASK TITLE',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0), 
                  // change
                    Text(
                      widget.task['title'],
                      style: TextStyle(fontSize: 20),
                    ),
              
                    SizedBox(height: 20.0), 
                    Text(
                      'Date',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0), 
                    Text(
                      formatter.format(widget.task['dueDate'].toDate()),
                      style: TextStyle(fontSize: 20),
                    ),
                 
                    SizedBox(height: 20.0), 
                    Text(
                      'REMINDER',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      widget.task['reminder'],
                      style: TextStyle(fontSize: 20),
                    ),
              
                    SizedBox(height: 20.0), 
                    Text(
                      'TASK CATEGORY',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0), 
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      child: widget.task['categories'].length == 0
                          ? SizedBox(height: 0.0)
                          : Wrap(
                              runSpacing: 6,
                              spacing: 6,
                              children: List.from(widget.task['categories'].map((e) => chipBuilder(
                                    onTap: () {
                                      setState(() {
                                        widget.task['categories'].remove(e);
                                      });
                                    },
                                    title: e,
                                  ))),
                            ),
                    ),
                    
                    SizedBox(height: 20.0), 
                    Text(
                      'NOTES',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0), 
                    Text(
                      widget.task['description'],
                      style: TextStyle(fontSize: 20),
                    ),
                
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0, right:50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallButton(
                      height: 50, 
                      width: 50,
                      image: 'assets/icons/trash_icon.png',
                      press: () async {
                        createAlertDialog(context).then((onValue){
                          if (onValue == 'Yes'){
                            // add delete task here
                            // task = widget.task 
                          }
                        });
                      }
                    ), 
                    SizedBox(width: 20),
                    _loading ? CircularProgressIndicator() :
                    SmallButton(
                      height: 50, 
                      width: 50,
                      image: 'assets/icons/save_icon.png',
                      press: () async {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTask(task: widget.task),
                          ),
                          (route) => false,
                        );
                      },
                    ),  
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

// chips helper
Widget chipBuilder({String? title, Function? onTap}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.purple[100],
    ),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          title ?? "data",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        SizedBox(width: 6),
        // GestureDetector(
        //   onTap: onTap,
        //   child: Icon(
        //     Icons.clear,
        //     size: 20,
        //   ),
        // ),
      ],
    ),
  );
}

