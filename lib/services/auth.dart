import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  CustomUser? createUser (User? firebaseuser) {
    return (firebaseuser != null) ? CustomUser(firebaseuser) : null;
  }

  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map(createUser);
  }

  Future register(email, password) async {  
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future login(email, password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future logOut() async {
    return await _auth.signOut();
  }
}