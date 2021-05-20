import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../views/login.dart';
import 'package:super_planner/screens/display.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomUser?>(
      builder: (context, user, child) {
        final user = Provider.of<CustomUser?>(context);
        if(user == null) {
          return Login();
        }
        else {
          return Display();
        }
      }
    );
  }
}