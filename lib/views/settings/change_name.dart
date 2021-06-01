import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/back_button.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/services/auth.dart';
import 'package:super_planner/views/settings.dart';
import 'package:super_planner/screens/display.dart';

class ChangeName extends StatefulWidget {

  @override
  ChangeNameState createState() => ChangeNameState();
}

class ChangeNameState extends State<ChangeName> {
  final AuthService _auth = AuthService();
  final changeNameFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  bool _showPassword = false;
  bool _loading = false;

  void _togglePassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    String? _displayName = 'User';

    if (user != null) {
      _displayName = user.displayName;
      print('DISPLAY NAME: $_displayName');
    }

    var start = 0;

    if (start == 0) {
      nameController.text = _displayName.toString();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
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
                    icon: new Icon(Icons.arrow_back_ios, size: 20.0),
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Display(tab: 3),
                        ),
                        (route) => false,
                      );
                    }
                  )
                ),
              ), 
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Change Name', 
                      style: header_text
                    ),
                  ), 
                  SizedBox(height: 30.0), 
                  Form(
                    key: changeNameFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Name',
                            style: field_title
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(  
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              //hintText: "Enter your name",
                              //hintStyle: TextStyle(fontSize: 16),                                              
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),                        
                            ),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name.';
                              }
                              return null;
                            }
                          ),
                        ), 
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Password',
                            style: field_title
                          ),
                        ),
                        SizedBox(height: 10),                  
                        Container(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !_showPassword,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(   
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: "Enter password",
                              hintStyle: TextStyle(fontSize: 18),                                              
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePassword();
                                },
                                child: Icon(
                                  _showPassword ? Ionicons.eye : Ionicons.eye_off,
                                  color: Color(0xff235784),
                                  size: 28,
                                ),
                              ),                        
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(top:20.0, right:0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //_loading ? CircularProgressIndicator() :
                              SmallButton(
                                height: 50, 
                                width: 50,
                                image: 'assets/icons/save_icon.png',
                                press: () async {
                                  // change name and check if password is correct
                                  //if(.currentState!.validate()) {
                                  //  try {
                                  //    
                                  //  }
                                },
                              ),  
                            ],
                          )
                        ),
                      ],
                    ),
                  ),          
                  ]
                )
              ),
              
            ]         
          ),
      )
    );
  }
}