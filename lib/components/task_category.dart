import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class TaskCategory extends StatelessWidget {
  final String? category_initial;
  final Function? press;

  const TaskCategory({
    Key? key,
    this.category_initial, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return InkWell(
      onTap: () {}, //Display all tasks under the category
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          color: dark_blue,
          borderRadius: new BorderRadius.all(
            Radius.circular(5.0)
          )
        ),
        alignment: Alignment.center,
        child: Text(category_initial!,style: task_category_btn)
      ),
  );
  }
}
