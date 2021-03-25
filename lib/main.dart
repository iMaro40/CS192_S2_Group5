import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import './views/home.dart';
import './views/login.dart';


void main() {
  runApp(MaterialApp(
    title: 'Super Planner',
    theme: ThemeData(fontFamily: 'Source Sans Pro'),
    home: Login()),
  );
}

