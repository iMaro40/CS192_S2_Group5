import 'dart:ffi';

import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final double height;
  final double width;
  final String image;
  final Function press;

  const SmallButton({
    Key key,
    this.height,
    this.width,
    this.image,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return InkWell(
      onTap: press, // Handle your callback.
      splashColor: Colors.white.withOpacity(0.2),
      child: Ink(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
