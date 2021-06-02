import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/screens/display.dart';
class DisplayTask extends StatefulWidget {
  final dynamic task;
  const DisplayTask({Key? key,required this.task}) : super(key: key);

  @override
  _DisplayTask createState() => _DisplayTask();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DisplayTask extends State<DisplayTask> {
  final DBService db = DBService();
  bool? _isSelected = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0, color: Colors.black),
        borderRadius: new BorderRadius.all(
          Radius.circular(20.0)
        )
      ),
      child: Padding (
        padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.task['title'],
                style: title_tabs_text,
              ),
            ),
            Transform.scale(
              scale: 1.15,
              child: 
                _loading ? CircularProgressIndicator() :
                widget.task['done']? Container() : 
                Checkbox(
                  value: _isSelected,
                  activeColor: Color(0xff40a8c4),
                  onChanged: (bool? newValue) async {
                    setState(() {
                      _loading = true;
                      _isSelected = newValue;  
                    });
                    if (_isSelected == true){
                      try {
                        await db.markTaskDone(widget.task['id']);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Display(tab: 2),
                          ),
                          (route) => false,
                        );
                      }
                      catch(err) {

                      }
                    }

                    setState(() { _loading = false; });
                  }
                )
            )
            
          ],
        )
      )
    );
  }
}