import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:super_planner/constants.dart';
import 'package:super_planner/views/home.dart';
import 'package:super_planner/views/login.dart';

class Register extends StatefulWidget {

  @override
  RegisterState createState() => RegisterState();
}



class RegisterState extends State<Register> {
  final loginFormKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  String error = '';
  String _email = '';
  String _password = '';

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  bool _showPassword = false;

  void _togglePassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/logos/logo-small.png')
              ), 
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Create an Account', 
                  style: header_text
                ),
              ), 
              SizedBox(height: 30.0), 
              Form(
                key: loginFormKey,
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
                          hintText: "Enter your name",
                          hintStyle: TextStyle(fontSize: 16),                                              
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),                        
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
                      child: Text('Email',
                        style: field_title
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(  
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Enter your email address",
                          hintStyle: TextStyle(fontSize: 16),                                              
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),                        
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        decoration: InputDecoration(   
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Enter password",
                          hintStyle: TextStyle(fontSize: 16),                                              
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
                        onChanged: (value) {
                          setState(() {
                            _password = value.trim();
                          });
                        },
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        onPressed: () async {
                          if (loginFormKey.currentState!.validate()) { //valid login, do submit
                            try {
                              await auth.createUserWithEmailAndPassword(email: _email, password: _password);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                                (route) => false,
                              );

                            } on FirebaseAuthException catch (e) {
                                setState(() {
                                  error = e.message!;
                                });                              
                                print('Error: ' + error);
                            } catch (e) {
                                setState(() {
                                  error = e.toString();
                                });                              
                              print('Error: ' + error);
                            }
                          } else {
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => Home(),
                            //   ),
                            //   (route) => false,
                            // );
                          }
                        },    
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(light_blue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                        )
                        ),             
                        child: Ink(
                          decoration: BoxDecoration(
                              color: light_blue),
                          child: Container(
                            constraints: BoxConstraints.expand(),
                            alignment: Alignment.center,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      children: [
                        Text(
                          'Already have an account?', 
                          style: link_text
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.26),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            'Log In', 
                            style: link_text
                          )
                        ),
                      ],
                    )               
                  ],
                ),
              ),            

            ]         
          ),
        ),
      )
    );
  }
}
