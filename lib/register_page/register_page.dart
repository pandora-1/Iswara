import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iswara/constants.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:iswara/login_page/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../authentication_service.dart';
import '../login_page/login_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  static const routeName = "/registerPage";
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _iconRegister(),
                  _buildButtonRegister(context),
                  _textField(),
                  _buildButtonGo(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconRegister() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
          top: ScreenUtil.instance.setHeight(60.0),
        )),
        Image.asset(
          "assets/images/iswara_logo.png",
          width: ScreenUtil.instance.setHeight(250.0),
          height: ScreenUtil.instance.setHeight(250.0),
        ),
      ],
    );
  }

  Widget _textField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(12.0)),
        ),
        TextFormField(
          controller: nameController,
          maxLength: 20,
          decoration: InputDecoration(
            icon: Icon(Icons.account_circle_outlined),
            labelText: 'Username',
            labelStyle: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.primaryTextColor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(12.0)),
        ),
        TextFormField(
          controller: emailController,
          maxLength: 30,
          decoration: InputDecoration(
            icon: Icon(Icons.email_outlined),
            labelText: 'Email',
            labelStyle: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.primaryTextColor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(12.0)),
        ),
        TextFormField(
          controller: passwordController,
          maxLength: 20,
          decoration: const InputDecoration(
            icon: Icon(Icons.vpn_key_outlined),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.primaryTextColor),
            ),
          ),
          style: TextStyle(color: ColorPalette.primaryTextColor),
          obscureText: true,
          autofocus: false,
        ),
      ],
    );
  }

  Widget _buildButtonRegister(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text(
            'Login',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
              fontSize: ScreenUtil.instance.setHeight(20.0),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(16.0)),
        ),
        Text(
          'or',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil.instance.setHeight(12.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil.instance.setHeight(16.0),
            right: ScreenUtil.instance.setHeight(16.0),
          ),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.instance.setHeight(8.0),
            ),
            width: ScreenUtil.instance.setHeight(100.0),
            child: Text(
              'Register',
              style: TextStyle(
                color: ColorPalette.primaryTextColor,
                fontSize: ScreenUtil.instance.setHeight(20.0),
              ),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonGo(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil.instance.setHeight(16.0),
          ),
        ),
        RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              width: double.infinity,
              height: ScreenUtil.instance.setHeight(50.0),
              child: Text(
                'Create!',
                style: TextStyle(
                  color: ColorPalette.primaryTextColor,
                  fontSize: ScreenUtil.instance.setHeight(20.0),
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                    context,
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            })
      ],
    );
  }
}
