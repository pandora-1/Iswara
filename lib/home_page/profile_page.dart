import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  File _image;
  final picker = ImagePicker();
  int _counter = 0;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  static const routeName = "/homepage";

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
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  _appBarsTopHomePage(),
                  /* Center(
                    child: _image == null ? Text('No image selected.') : Image.file(_image),
                  ),
                  FloatingActionButton(
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ), */
                  _contentProfilePage(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _contentProfilePage() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(15.0))),
        CircleAvatar(
          backgroundColor: ColorPalette.primaryTextColor,
          radius: 48.0,

        ),
        Column(
          children: [
            Text(
              "NAME",
              style: TextStyle(
                color: ColorPalette.primaryTextColor,
                fontSize: ScreenUtil.instance.setHeight(20.0),
              ),
            ),
            Text(
              "$_counter",
              style: TextStyle(
                color: ColorPalette.primaryTextColor,
                fontSize: ScreenUtil.instance.setHeight(20.0),
              ),
            ),
            Text(
              "Writings",
              style: TextStyle(
                color: ColorPalette.primaryTextColor,
                fontSize: ScreenUtil.instance.setHeight(20.0),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: ScreenUtil.instance.setHeight(60.0))),
        Center(
          child: Text(
            "WRITINGS",
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
              fontSize: ScreenUtil.instance.setHeight(30.0),
            ),
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: ColorPalette.primaryTextColor,),
        )
      ],
    );
  }

  Widget _appBarsTopHomePage() {
    return Column(
      children: <Widget>[
        AppBar(
          leading: new Container(),
          title: Text('@Username',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),),
          actions: [
            Icon(Icons.notifications_active_outlined),
            Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setHeight(4.0))),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ), */
            Icon(Icons.more_vert),
            Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setHeight(4.0))),
          ],
          backgroundColor: ColorPalette.primaryColor,
          iconTheme: IconThemeData(
            color: ColorPalette.primaryTextColor,
            size: ScreenUtil.instance.setHeight(35.0),
          ),
        ),
      ],
    );
  }



  Widget _navbarBottom() {
    return Column(
      children: <Widget>[
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorPalette.primaryColor,
          unselectedItemColor: ColorPalette.primaryTextColor,
          iconSize: ScreenUtil.instance.setHeight(35.0),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          onTap: (value) {
            // Respond to item press.
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(''),
            ),
          ],
        )
      ],
    );
  }
}
