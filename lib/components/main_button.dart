import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class MainButton extends StatelessWidget {
  final String? text;
  final Function? press;
  final Color? color;

  const MainButton({
    Key? key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.08,
    width: MediaQuery.of(context).size.width,
    // ignore: deprecated_member_use
    child: ElevatedButton(
      onPressed: press as void Function()?,   
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(light_blue),
      ),             
      child: Ink(
        decoration: BoxDecoration(
            color: color),
        child: Container(
          constraints: BoxConstraints.expand(),
          alignment: Alignment.center,
          child: Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ),
  ); 
  }
}
