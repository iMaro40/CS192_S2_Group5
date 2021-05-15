import 'package:flutter/material.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/back_button.dart';
import 'package:super_planner/services/db.dart';
import 'package:super_planner/views/home.dart';
import 'package:super_planner/services/auth.dart';
import 'package:super_planner/views/login.dart';

class EditQuote extends StatefulWidget {
  @override
  _EditQuote createState() => _EditQuote();
}


class _EditQuote extends State<EditQuote> {
  final TextEditingController _quoteController = new TextEditingController(text: "\"All our dreams can come true, if we have the courage to pursue them.\"\n\n-Walt Disney");
  final AuthService _auth = AuthService();
  final DBService db = DBService();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Align(
                alignment: Alignment.topLeft,
                child: ButtonBack(),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QUOTE',
                      style: TextStyle(
                        color: dark_blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold, 
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _quoteController,
                      maxLines: 6,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0, right:50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallButton(
                      height: 50, 
                      width: 50,
                      image: 'assets/icons/trash_icon.png'
                    ), 
                    SizedBox(width: 20),
                    _loading ? CircularProgressIndicator() :
                    SmallButton(
                      height: 50, 
                      width: 50,
                      image: 'assets/icons/save_icon.png',
                    ),  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

