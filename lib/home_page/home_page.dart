import 'package:flutter/material.dart';
import 'package:iswara/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            children: [
              Text("HOME"),
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut(context);
                },
                child: Text("Sign out"),
              )
            ],
          ),
        ));
  }
}
