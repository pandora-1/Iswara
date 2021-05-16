import 'package:flutter/material.dart';
import 'package:iswara/constants.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:iswara/register_page/register_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../authentication_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const routeName = "/loginPage";
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
        padding: EdgeInsets.all(ScreenUtil.instance.setHeight(20.0)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _iconLogin(),
                  _buildButtonLogin(context),
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

  Widget _iconLogin() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
          top: ScreenUtil.instance.setHeight(120.0),
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
          controller: emailController,
          maxLength: 20,
          decoration: InputDecoration(
            icon: Icon(Icons.account_circle_outlined),
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

  Widget _buildButtonLogin(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
              'Login',
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
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil.instance.setHeight(16.0),
            left: ScreenUtil.instance.setHeight(16.0),
          ),
        ),
        Text(
          'or',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil.instance.setHeight(12.0),
          ),
        ),
        FlatButton(
          child: Text(
            'Register',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
              fontSize: ScreenUtil.instance.setHeight(20.0),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
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
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              width: double.infinity,
              height: ScreenUtil.instance.setHeight(40.0),
              child: Text(
                'Go!',
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
              context.read<AuthenticationService>().signIn(
                    context,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            }),
      ],
    );
  }
}
