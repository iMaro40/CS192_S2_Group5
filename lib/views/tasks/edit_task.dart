import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/back_button.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/screens/display.dart';
import 'package:super_planner/views/tasks/view_task.dart';


class EditTask extends StatefulWidget {
  final dynamic task;
  const EditTask({Key? key,required this.task}) : super(key: key);

  @override
  _EditTask createState() => _EditTask();
}


class _EditTask extends State<EditTask> {
  TextEditingController _tasktitleController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  List<String?> categories = [];

  final editTaskFormKey = GlobalKey<FormState>();

  final DBService db = DBService();

  bool _loading = false;

  DateTime selectedDate = DateTime.now();
  String? _reminder = "1 day before";

    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: widget.task['dueDate'].toDate(),
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

  var start = 0;

  @override
  Widget build(BuildContext context) {
    var rawReminders = [
      "1 hour before", 
      "6 hours before", 
      "1 day before", 
      "2 days before"
    ]; 
    if (start == 0){
      _tasktitleController.text =  widget.task['title'];
      _notesController.text =  widget.task['description'];
      DateTime picked = widget.task['startDate'].toDate();
      var date = "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
      _dateController.text = date;
      _reminder = widget.task['reminder'];

      categories = (widget.task['categories'] as List).map((item) => item as String?).toList();
      start = 1;
    }

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
          key: editTaskFormKey,
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewTask(task: widget.task),
                        ),
                        (route) => false,
                      );
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
                    TextFormField(
                      controller: _tasktitleController,
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 18
                      ),
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title.';
                          }
                          return null;
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
                            suffixIcon: Icon(
                              Icons.calendar_today,
                              color: dark_blue,
                              size: 28,
                            ),                                                                           
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Please enter a date.";
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
                        onChanged: (dynamic value) {
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
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0, right:50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //SmallButton(
                    //  height: 50, 
                    //  width: 50,
                    //  image: 'assets/icons/trash_icon.png'
                    //), 
                    //SizedBox(width: 20),
                    //_loading ? CircularProgressIndicator() :
                    SmallButton(
                      height: 50, 
                      width: 50,
                      image: 'assets/icons/save_icon.png',
                      press: () async {
                        if(editTaskFormKey.currentState!.validate()) {
                          try {
                            String title = _tasktitleController.text;
                            String description = _notesController.text;
                            DateTime startDate = DateTime.now();
                            DateTime dueDate = selectedDate;
                            var reminder = _reminder;

                            setState(() { _loading = true; });

                            // change to edit task instead. 
                            // task = widget.task
                            await db.editTask(widget.task['id'], title, description, startDate, dueDate, categories, reminder);

                            setState(() { _loading = false; });

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Display(tab: 0), 
                              ),
                              (route) => false,
                            );
                          }
                          catch(err) {
                            final snackBar = SnackBar(
                                content: Text('Some error occured.'),
                                action: SnackBarAction(
                                  label: 'CLOSE',
                                  onPressed: () {
                          
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                    ),  
                  ],
                )
              ),
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
