import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:super_planner/constants.dart';
import 'package:super_planner/views/home.dart';
import 'package:super_planner/views/register.dart';
import 'package:super_planner/services/auth.dart';
class Login extends StatefulWidget {

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  final loginFormKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 60.0),
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/logos/logo-small.png')
            ), 
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome Back', 
                style: header_text
              ),
            ), 
            SizedBox(height: 50.0), 
            Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        if (loginFormKey.currentState.validate()) { //valid login, do submit
                          try {
                            setState(() { _loading = true; });

                            await _auth.login(emailController.text, passwordController.text);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                              (route) => false,
                            );

                            setState(() { _loading = false; });
                          }
                          catch(err) {
                            String errorMsg = '';
                            switch(err.code) {
                              case 'wrong-password': 
                                errorMsg = 'ERROR: Wrong password!'; 
                                break;

                              case 'user-not-found': 
                                errorMsg = 'ERROR: User not found!';
                                break;
                              
                              case 'too-many-requests':
                                errorMsg = 'ERROR: Too many attempts. Please try again later';
                                break;
                                
                              default:
                                // errorMsg = err.code;
                                errorMsg = 'ERROR: Some error occured while trying to log in.';
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
                            'Log In',
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
                        'Not registered yet?', 
                        style: link_text                      
                      ),
                      //SizedBox(width: MediaQuery.of(context).size.width * 0.33),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          'Sign Up', 
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
      )
    );
  }
}