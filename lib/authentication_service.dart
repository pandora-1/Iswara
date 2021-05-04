import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page/home_page.dart';
import 'login_page/login_page.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<String> signIn(BuildContext context,
      {String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(BuildContext context,
      {String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

class AuthenticationGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
