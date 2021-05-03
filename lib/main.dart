import 'package:flutter/material.dart';
import 'package:iswara/login_page/login_page.dart';
import 'package:iswara/register_page/register_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Login Register Page",
    initialRoute: "/",
    routes: {
      "/" : (context) => LoginPage(),
      RegisterPage.routeName : (context) => RegisterPage(),
    },
  ));
}