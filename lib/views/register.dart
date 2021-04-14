import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/views/login.dart';
import 'package:super_planner/services/auth.dart';
class Register extends StatefulWidget {

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final registerFormKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
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
                key: registerFormKey,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }

                          bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text);
                          if (!emailValid) {
                            return 'Please enter a valid email.';
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }

                          if(value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 25),
                    _loading ? CircularProgressIndicator() :
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        onPressed: () async { 
                          if (registerFormKey.currentState.validate()) { 
                            try {
                              setState(() { _loading = true; });
                              
                              UserCredential result = await _auth.register(emailController.text, passwordController.text);
                              await result.user.updateProfile( displayName: nameController.text );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                builder: (context) => Login()),
                              );

                              setState(() { _loading = false; });
                            }
                            catch(err) {
                              setState(() { _loading = false; });
                              String errorMsg = '';
                              String code = err.code != null ? err.code : err.toString();

                              switch(code) {
                                case 'email-already-in-use': 
                                  errorMsg = 'ERROR: Email is already in use!'; 
                                  break;

                                case 'invalid-email': 
                                  errorMsg = 'ERROR: Invalid email!';
                                  break;
                                
                                case 'too-many-requests':
                                  errorMsg = 'ERROR: Too many attempts. Please try again later';
                                  break;

                                default:
                                  errorMsg = 'ERROR: Some error occurred while trying to register.';
                              }

                              final snackBar = SnackBar(
                                content: Text(errorMsg),
                                action: SnackBarAction(
                                  label: 'CLOSE',
                                  onPressed: () {
                          
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            
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
                        Spacer(),
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