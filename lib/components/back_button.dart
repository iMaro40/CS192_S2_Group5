import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:super_planner/constants.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
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
        onPressed: () => Navigator.of(context).pop(), 
        icon: new Icon(Icons.arrow_back_ios, size: 20.0)
      )
    );
  }
}
