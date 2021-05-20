import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  String _uid = '';
  String? _name = '';
  CustomUser(User user) {
    this._uid = user.uid;
    this._name = user.displayName;
  }

  String getUID() {
    return this._uid;
  }

  String? getName() {
    return this._name;
  }
}