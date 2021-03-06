import 'package:flutter/material.dart';
import 'package:super_planner/constants.dart';

 class DisplayTabs extends StatefulWidget {
  final Color? color;
  final Color? icon_color;
  final String? time;
  final String? event; 
  final String? tags; 
  final String? notes;  
  final String? image;
  final Function? press;

  const DisplayTabs({
    Key? key,
    this.color, 
    this.icon_color, 
    this.time,
    this.event, 
    this.tags,
    this.notes,
    this.image,
    this.press,
  }) : super(key: key);

    @override
    _DisplayTabs createState() {
      return _DisplayTabs();
    }
  }

class _DisplayTabs extends State<DisplayTabs> {

  bool _isVisible = false;

  void initState() {
    super.initState();

    setState(() {
      if (widget.notes != null)
       _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      padding: const EdgeInsets.all(30.0),
      decoration: new BoxDecoration(
        color: widget.color,
        borderRadius: new BorderRadius.all(
          Radius.circular(20.0)
        )
      ),                
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                color: widget.icon_color,
                size: 20.0,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              Text( 
                widget.time!, 
                style: time_tabs_text
              ),                      
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( 
                widget.event!, 
                style: title_tabs_text
              ),    
              Container(
                height: 30,
                padding: const EdgeInsets.only(top:5, left:10.0, right: 10.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0)
                  )
                ),
                child: Text(widget.tags!)  
              ),                                         
            ],
          ),  
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Visibility(
            visible: _isVisible,
            child: Row(
              children: [
                Text( 
                  widget.notes!, 
                  style: notes_tabs_text
                ) 
              ],
            ),
          )
        ],
      )
    );
  }
}
