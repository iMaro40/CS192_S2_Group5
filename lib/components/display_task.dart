import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key key,
    this.label,
    this.padding,
    this.value,
    //this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  //final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   //onChanged(!value);
      // },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label, style: title_tabs_text)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                //onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayTask extends StatefulWidget {
  final String taskName;
  const DisplayTask({Key key,@required this.taskName}) : super(key: key);

  @override
  _DisplayTask createState() => _DisplayTask();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DisplayTask extends State<DisplayTask> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0, color: Colors.black),
        borderRadius: new BorderRadius.all(
          Radius.circular(20.0)
        )
      ),
      child: LabeledCheckbox(
        label: widget.taskName,
        padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 10.0),
        value: _isSelected,
        // onChanged: (bool newValue) {
        //   setState(() {
        //     _isSelected = newValue;
        //   });
        // },
      ),  
    );
  }
}