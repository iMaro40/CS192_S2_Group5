import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class SettingsTab extends StatelessWidget {
  final IconData? icon;
  final String? name;  

  const SettingsTab({
    this.icon,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: faded_light_blue,
        borderRadius: BorderRadius.all(Radius.circular(20.0)), 
      ),
      child: Row(
        children: [ Icon(
            icon,
            color: dark_blue,
            size: 25.0,
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.02),
          Text(
            name!,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: dark_grey,
            size: 20.0,
          ),
        ],
      ),
    ); 
  }
}
