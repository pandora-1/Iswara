import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page/home_page.dart';
import 'login_page/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("blogs").get();
  }
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  String getUid() {
    return _firebaseAuth.currentUser.uid;
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
      {String name, String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      DocumentReference ref = FirebaseFirestore.instance
          .collection("users")
          .doc(_firebaseAuth.currentUser.uid);
      ref.set({'name': name, 'profileUrl': null});
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
