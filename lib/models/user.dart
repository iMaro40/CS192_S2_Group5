import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  String uid = '';

  CustomUser(User user) {
    this.uid = user.uid;
  }
}