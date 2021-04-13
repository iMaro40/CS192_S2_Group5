import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class DisplayTabs extends StatelessWidget {
  final String image;
  final Function press;

  const DisplayTabs({
    Key key,
    this.image,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
      ),
      padding: const EdgeInsets.all(8.0),
      color: Colors.blue[600],
      alignment: Alignment.center,
      child: Text(
        'Hello World',
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(color: Colors.white)),
      transform: Matrix4.rotationZ(0.1),
    );
  }
}
