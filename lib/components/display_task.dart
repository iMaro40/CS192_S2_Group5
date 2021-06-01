import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class DisplayTask extends StatefulWidget {
  final String taskName;
  const DisplayTask({Key? key,required this.taskName}) : super(key: key);

  @override
  _DisplayTask createState() => _DisplayTask();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DisplayTask extends State<DisplayTask> {
  bool? _isSelected = false;

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
            Text(
              widget.taskName,
              style: title_tabs_text,
            ),
            Spacer(),
            Transform.scale(
              scale: 1.15,
              child: 
                Checkbox(
                  value: _isSelected,
                  activeColor: Color(0xff40a8c4),
                  onChanged: (bool? NewValue){
                    setState(() {
                      _isSelected = NewValue;  
                      if (_isSelected == true){
                        //Mark Task as done in backend
                      }
                    });
                  }
                )
            )
            
          ],
        )
      )
    );
  }
}