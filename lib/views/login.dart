import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Login extends StatefulWidget {

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
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
          Container(
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password.';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan.shade700),
            ),
            onPressed: () {
              if (loginFormKey.currentState!.validate()) { //valid login, do submit
                print(emailController.text);
                print(passwordController.text);
              }
            },
            child: Text('LOGIN')
            ,
          ),
        ],
      ),
    );
  }
}