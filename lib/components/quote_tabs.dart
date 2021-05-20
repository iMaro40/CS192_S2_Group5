import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

class QuoteTab extends StatelessWidget {
  final Color? color; 
  final String? quote;  
  final Function? press;

  const QuoteTab({
    Key? key,
    this.color, 
    this.quote,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: new BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.all(
          Radius.circular(20.0)
        )
      ),                
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text(
            quote!, 
            style: quote_tab_text 
          )
        ],
      )
    ); 
  }
}
