import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String image;
  final Function press;

  const SmallButton({
    Key key,
    this.image,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return InkWell(
      onTap: () {
        print('test');
      }, // Handle your callback.
      splashColor: Colors.white.withOpacity(0.2),
      child: Ink(
        height: 35,
        width: 35,
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
