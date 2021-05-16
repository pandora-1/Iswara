import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'home_page/home_page.dart';
import 'login_page/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid_string;

  void getUid() {
    final User user = auth.currentUser;
    final uid = user.uid;
    uid_string = uid;
    // here you write the codes to input the data into firestore
  }

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

  getDataProfile() async {
    getUid();
    return FirebaseFirestore.instance
        .collection("blogs")
        .where('uid', isEqualTo: uid_string)
        .get();
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
      if (e.code == 'user-not-found') {
        _showDialog3(context);
      }
    }
  }

  Future<String> signUp(BuildContext context,
      {String name, String email, String password}) async {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw _showDialog2(context);
      }
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
      if (e.code == 'email-already-in-use') {
        _showDialog1(context);
      }
      if (e.code == 'weak-password') {
        _showDialog4(context);
      }
    }
  }
}

Future<void> _showDialog1(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: const Text('User Already Exists'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showDialog2(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: const Text('username, email, or password cannot be empty'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showDialog3(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: const Text('Wrong email or password'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showDialog4(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: const Text('Password is too weak'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
