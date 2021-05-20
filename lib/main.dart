import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:super_planner/screens/wrapper.dart';
import 'package:super_planner/services/auth.dart';
import 'package:super_planner/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>(
      initialData: null,
      create: (context) => AuthService().user,
      child: MaterialApp(
        title: 'Super Planner',
       theme: ThemeData(fontFamily: 'Source Sans Pro'),
        home: Wrapper()
      ),
    );

    // return StreamProvider<CustomUser?>(
    //   initialData: null,
    //   create: (context) => AuthService().user,
    //   child: Consumer<CustomUser?>(
    //     builder: (context, user, child) {
    //       return MaterialApp(
    //         title: 'Super Planner',
    //         theme: ThemeData(fontFamily: 'Source Sans Pro'),
    //         home: Display(),
    //       );
    //   }),
    // );
  }
}
