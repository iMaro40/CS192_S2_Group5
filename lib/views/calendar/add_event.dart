import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';


import 'package:super_planner/components/back_button.dart';
class AddEvent extends StatefulWidget {

  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  final TextEditingController _tasktitleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String _reminder = "1 day before";

    _selectTime(BuildContext context) async {
      final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: selectedTime);
      if (picked != null && picked != selectedTime)
        setState(() {
          selectedTime = picked;
          var time =
              "${picked.hour}:${picked.minute}";
          _timeController.text = time;
        });
    }

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
                  TextFormField(
                    controller: _tasktitleController,
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 24
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter event title...',
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
                          labelText: "DATE",
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
                  SizedBox(height: 10.0), 
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _timeController,
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 18
                        ),
                        decoration: InputDecoration(
                          labelText: "TIME",
                          labelStyle: TextStyle(
                            color: dark_blue, 
                            fontWeight: FontWeight.bold, 
                            fontSize: 22
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Pick a time...",
                          hintStyle: TextStyle(height: 2, fontSize: 18),
                          suffixIcon: Icon(
                            Icons.schedule,
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
                    'EVENT CATEGORY',
                    style: TextStyle(
                      color: dark_blue, 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold 
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
                    image: 'assets/icons/save_icon.png'
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