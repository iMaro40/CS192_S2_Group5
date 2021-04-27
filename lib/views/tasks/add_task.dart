import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/components/back_button.dart';

class AddTask extends StatefulWidget {

  @override
  _AddTask createState() => _AddTask();
}


class _AddTask extends State<AddTask> {
  final TextEditingController _tasktitleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String _reminder = "1 day before";

    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
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

  Future<String> createAlertDialog(BuildContext context){

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

  @override
  Widget build(BuildContext context) {
    final DBService db = DBService();

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
                    'TASK TITLE',
                    style: TextStyle(
                      color: dark_blue, 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold 
                    ),
                  ),
                  TextFormField(
                    controller: _tasktitleController,
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 24
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter task title...',
                      hintStyle: TextStyle(fontSize: 20), 
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                  ),
                  SizedBox(height: 10.0), 
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 18
                        ),
                        decoration: InputDecoration(
                          labelText: "DATE DUE",
                          labelStyle: TextStyle(
                            color: dark_blue, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 22
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Pick a date...",
                          hintStyle: TextStyle(height: 2, fontSize: 18),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: dark_blue,
                            size: 28,
                          ),                                                                           
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter a date for your task";
                          return null;
                        },
                      ),
                    ),
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
                  Container(
                    child: DropdownButton(
                      value: _reminder,
                      style: const TextStyle(fontSize: 18, color: dark_grey),
                      underline: Container(
                        height: 1,
                        color: Colors.grey[500],
                      ),
                      isExpanded: true,
                      items: reminder,
                      onChanged: (value) {
                        setState(() {
                          _reminder = value;
                        });
                      }),
                  ),
                  SizedBox(height: 20.0), 
                  Row (
                    children: [
                      Text(
                        'TASK CATEGORY',
                        style: TextStyle(
                          color: dark_blue, 
                          fontSize: 16, 
                          fontWeight: FontWeight.bold 
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: (){
                          createAlertDialog(context).then((onValue) {
                            categories.add(onValue);
                          });
                        },
                        splashRadius: 15.0,
                        icon: Icon(
                          Icons.add,
                          color: Color(0xff235784),
                        ),
                        iconSize: 20.0,
                        
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black26),
                    //   borderRadius: BorderRadius.circular(14),
                    // ),
                    child: categories.length == 0
                        ? SizedBox(height: 0.0)
                        : Wrap(
                            runSpacing: 6,
                            spacing: 6,
                            children: List.from(categories.map((e) => chipBuilder(
                                  onTap: () {
                                    setState(() {
                                      categories.remove(e);
                                    });
                                  },
                                  title: e,
                                ))),
                          ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'NOTES',
                    style: TextStyle(
                      color: dark_blue, 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold 
                    ),
                  ),
                  TextFormField(
                    controller: _notesController,
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 18
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter notes for your task...',
                      hintStyle: TextStyle(fontSize: 16), 
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
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
                    image: 'assets/icons/trash_icon.png'
                  ), 
                  SizedBox(width: 20),
                  SmallButton(
                    height: 50, 
                    width: 50,
                    image: 'assets/icons/save_icon.png',
                    press: () async {
                      var task = await db.createTask(_tasktitleController.text, _notesController.text);
                      print(task);
                    },
                  ),  
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

//category list
List<String> categories = [];

// chips helper
Widget chipBuilder({String title, Function onTap}) {
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
          ),
        ),
        SizedBox(width: 6),
        GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.clear,
            size: 20,
          ),
        ),
      ],
    ),
  );
}
