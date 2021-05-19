import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function press;
  const ScreenHeader({Key key, this.title, this.subtitle, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.45,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.04),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.only(bottomLeft:Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
        color: light_blue,
      ), 
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: press
              ), 
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontSize: 28)), 
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150),
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                )
              ),
          )
        ],
      )
    );
  }
}
