import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/components/back_button.dart';
import 'package:super_planner/components/small_button.dart';
import 'package:super_planner/services/auth.dart';
import 'package:super_planner/views/settings.dart';
import 'package:super_planner/screens/display.dart';

class ChangePassword extends StatefulWidget {

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final AuthService _auth = AuthService();
  final registerFormKey = GlobalKey<FormState>();  // i didn't change yet coz i wasn't sure what to do


  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController1 = new TextEditingController();
  TextEditingController newPasswordController2 = new TextEditingController();

  bool _showOldPassword = false;
  bool _showNewPassword1 = false;
  bool _showNewPassword2 = false;
  bool _loading = false;

  void _toggleOldPassword() {
    setState(() {
      _showOldPassword = !_showOldPassword;
    });
  }

  void _toggleNewPassword1() {
    setState(() {
      _showNewPassword1 = !_showNewPassword1;
    });
  }
  
  void _toggleNewPassword2() {
    setState(() {
      _showNewPassword2 = !_showNewPassword2;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

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
                        'Change Password', 
                        style: header_text
                      ),
                    ), 
                    SizedBox(height: 20.0), 
                    Form(
                      key: registerFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Current Password',
                              style: field_title
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: TextFormField(
                              controller: oldPasswordController,
                              obscureText: !_showOldPassword,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(   
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Enter current password",
                                hintStyle: TextStyle(fontSize: 16),       
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _toggleOldPassword();
                                  },
                                  child: Icon(
                                    _showOldPassword ? Ionicons.eye : Ionicons.eye_off,
                                    color: Color(0xff235784),
                                    size: 28,
                                  ),
                                ),                        
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your old password.';
                                }
                                return null;
                              },
                            ),
                          ), 
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('New Password',
                              style: field_title
                            ),
                          ),
                          SizedBox(height: 10),                  
                          Container(
                            child: TextFormField(
                              controller: newPasswordController1,
                              obscureText: !_showNewPassword1,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(   
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Enter new password",
                                hintStyle: TextStyle(fontSize: 16),                                              
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _toggleNewPassword1();
                                  },
                                  child: Icon(
                                    _showNewPassword1 ? Ionicons.eye : Ionicons.eye_off,
                                    color: Color(0xff235784),
                                    size: 28,
                                  ),
                                ),                        
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your new password.';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text('Re-enter New Password',
                              style: field_title
                            ),
                          ),
                          SizedBox(height: 10),                  
                          Container(
                            child: TextFormField(
                              controller: newPasswordController2,
                              obscureText: !_showNewPassword2,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(   
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Re-enter new password",
                                hintStyle: TextStyle(fontSize: 16),                                              
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _toggleNewPassword2();
                                  },
                                  child: Icon(
                                    _showNewPassword2 ? Ionicons.eye : Ionicons.eye_off,
                                    color: Color(0xff235784),
                                    size: 28,
                                  ),
                                ),                        
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please re-enter your new password.';
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
                                    var email = user!.email;
                                    AuthCredential credential = EmailAuthProvider.credential(email: email!, password: oldPasswordController.text);
                                    String displayMsg = '';

                                    try {
                                      await user.reauthenticateWithCredential(credential);

                                      if (newPasswordController1.text == newPasswordController2.text) {
                                        await user.updatePassword(newPasswordController1.text);
                                        displayMsg = 'You have successfully changed your password.';
                                      }
                                      else
                                        displayMsg = 'ERROR: New passwords do not match.';
                                    }
                                    catch(err) {
                                      // setState(() { _loading = false; });
                                      dynamic error = err;
                                      dynamic code = error.code != null? error.code : null;
                                      switch(code) {
                                        case 'wrong-password': 
                                          displayMsg = 'ERROR: Wrong password!'; 
                                          break;
                                        
                                        case 'weak-password': 
                                          displayMsg = 'ERROR: Weak password. Choose a stronger password.'; 
                                          break;
                                        
                                        case 'too-many-requests':
                                          displayMsg = 'ERROR: Too many attempts. Please try again later';
                                          break;

                                        default:
                                          // errorMsg = err.code;
                                          displayMsg = 'ERROR: Some error occured while trying to change password.';
                                      }
                                    }
                                      final snackBar = SnackBar(
                                        content: Text(displayMsg),
                                        action: SnackBarAction(
                                          label: 'CLOSE',
                                          onPressed: () {
                                  
                                          },
                                        ),
                                      );

                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  },
                                ),  
                              ],
                            )
                          ),
                        ],
                      ),
                    ),            

                  ],
                )
              ),
              
            ]         
          ),
        
      )
    );
  }
}