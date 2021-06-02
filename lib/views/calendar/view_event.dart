import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/back_button.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/views/home.dart';
import 'package:super_planner/screens/display.dart';
import 'package:intl/intl.dart';

class ViewEvent extends StatefulWidget {
  final dynamic event;
  const ViewEvent({Key? key,required this.event}) : super(key: key);

  @override
  _ViewEvent createState() => _ViewEvent();
}

class _ViewEvent extends State<ViewEvent> {
  final TextEditingController _tasktitleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _starttimeController = TextEditingController();
  final TextEditingController _endtimeController = TextEditingController();
  List<String?> categories = [];

  final addEventFormKey = GlobalKey<FormState>();

  final DBService db = DBService();

  bool _loading = false;
  var dateFormatter = new DateFormat.yMMMd('en_US');
  var timeFormatter = new DateFormat('HH:mm');

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String _reminder = "1 day before";
  DateTime? date;
  TimeOfDay? starttime, endtime;

  Future<String?> createAlertDialog(BuildContext context){
    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Enter Category"),
          content: TextField(
            controller: customController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {
                Navigator.of(context).pop(customController.text.toString());
              },
            )
          ]
        );
      }
    );
  }

  Future<String?> createAlertDialogForDelete(BuildContext context){
 
    return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Delete Event?"),
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
        child: Form (
          key: addEventFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Align(
                alignment: Alignment.topLeft,
                child: ButtonBack(),
              ),
              Padding (
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EVENT TITLE',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    Text(
                      widget.event['title'],
                      style: TextStyle(fontSize: 16),
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
                      dateFormatter.format(widget.event['startTime'].toDate()),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'START TIME',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0), 
                    Text(
                      timeFormatter.format(widget.event['startTime'].toDate()),
                      style: TextStyle(fontSize: 16),
                    ),                    
                    SizedBox(height: 20.0), 
                    Text(
                      'END TIME',
                      style: TextStyle(
                        color: dark_blue, 
                        fontSize: 16, 
                        fontWeight: FontWeight.bold 
                      ),
                    ),
                    SizedBox(height: 10.0), 
                    Text(
                      timeFormatter.format(widget.event['endTime'].toDate()),
                      style: TextStyle(fontSize: 16),
                    ),         
                    SizedBox(height: 20.0), 
                    Text(
                      'EVENT CATEGORY',
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
                      child: widget.event['categories'].length == 0
                          ? SizedBox(height: 0.0)
                          : Wrap(
                              runSpacing: 6,
                              spacing: 6,
                              children: List.from(widget.event['categories'].map((e) => chipBuilder(
                                    onTap: () {
                                      setState(() {
                                        widget.event['categories'].remove(e);
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
                      widget.event['notes'],
                      style: TextStyle(fontSize: 16),
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
                        createAlertDialogForDelete(context).then((onValue) async {
                          if (onValue == 'Yes'){
                            try {
                              await db.deleteEvent(widget.event['id']);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Display(tab: 0),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    // SizedBox(width: 20),
                    // _loading ? CircularProgressIndicator() :
                    // SmallButton(
                    //   height: 50, 
                    //   width: 50,
                    //   image: 'assets/icons/save_icon.png',
                    //   press: () async {
                    //     if(addEventFormKey.currentState!.validate()) {
                    //       try {
                    //         String title = _tasktitleController.text;
                    //         String description = _notesController.text;
                    //         // DateTime startDate = DateTime.now();
                    //         // DateTime dueDate = selectedDate;
                    //         var reminder = _reminder;

                    //         setState(() { _loading = true; });

                    //         await db.createEvent(title, description, starttime!, endtime!, date!, categories, reminder);

                    //         setState(() { _loading = false; });

                    //         Navigator.pushAndRemoveUntil(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => Home(),
                    //           ),
                    //           (route) => false,
                    //         );
                    //       }
                    //       catch(err) {
                    //         final snackBar = SnackBar(
                    //             content: Text(err.toString()),
                    //             action: SnackBarAction(
                    //               label: 'CLOSE',
                    //               onPressed: () {
                          
                    //               },
                    //             ),
                    //           );

                    //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //       }
                    //     }
                    //   },
                    // ),  
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}

// chips helper
Widget chipBuilder({String? title, Function? onTap}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.orange[100],
    ),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          title ?? "data",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(width: 6),
        GestureDetector(
          onTap: onTap as void Function()?,
          child: Icon(
            Icons.clear,
            size: 20,
          ),
        ),
      ],
    ),
  );
}
