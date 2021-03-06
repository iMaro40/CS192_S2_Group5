import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/db.dart';
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
  final TextEditingController _dateController = TextEditingController();
  //List<String> categories = [];
  

  final addTaskFormKey = GlobalKey<FormState>();

  final DBService db = DBService();

  bool _loading = false;
  var formatter = new DateFormat.yMMMMd('en_US');

  DateTime selectedDate = DateTime.now();
  
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: addTaskFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 70, 
                  width: 90, 
                  decoration: BoxDecoration(
                    color: faded_light_blue, 
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0), 
                      bottomRight: Radius.circular(10.0)
                    ),
                  ),
                  child: IconButton(
                    icon: new Icon(Icons.arrow_back_ios, size: 20.0),
                    onPressed: () async {
                      Navigator.pop(context);
                    }
                  )
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
                      'DATE',
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
                      press: () {
                        createAlertDialog(context).then((onValue) async {
                          if (onValue == 'Yes'){
                            try {
                              await db.deleteTask(widget.task['id']);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Display(tab: 2),
                                ),
                                (route) => false,
                              );
                            }
                            catch(err) {
                              print(err.toString());
                              final snackBar = SnackBar(
                                content: Text(err.toString()),
                                action: SnackBarAction(
                                  label: 'CLOSE',
                                  onPressed: () {
                          
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                        });
                      }
                    ), 
                    SizedBox(width: 20),
                    _loading ? CircularProgressIndicator() :
                    widget.task['done']? Container() :
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

