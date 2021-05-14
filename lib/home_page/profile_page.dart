import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iswara/home_page/add_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot snapshot;

  @override
  void initState() {
    super.initState();

    users.doc(auth.currentUser.uid).get().then((result) {
      snapshot = result;
      setState(() {});
    });
  }

  File _image;
  final picker = ImagePicker();

  int _counter = 0; /* Untuk menghitung jumlah tulisan yang sudah ditulis */

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
                child: snapshot != null
                    ? Column(
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
                      )
                    : Text('No Image selected')),
          ],
        ),
      ),
    );
  }

  Widget _contentProfilePage() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(15.0))),
        CircleAvatar(
          backgroundColor: ColorPalette.primaryTextColor,
          radius: 48.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data()['name'],
                  style: TextStyle(
                    color: ColorPalette.primaryTextColor,
                    fontSize: ScreenUtil.instance.setHeight(20.0),
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  color: ColorPalette.primaryColor,
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.drive_file_rename_outline),
                        title: Text('Name'),
                      ),
                    ),
                    const PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.camera_enhance_rounded),
                        title: Text('Profile Picture'),
                      ),
                    )
                  ],
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
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil.instance.setHeight(60.0))),
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPage()));
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: ColorPalette.primaryTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _appBarsTopHomePage() {
    return Column(
      children: <Widget>[
        AppBar(
          leading: new Container(),
          title: Text(
            snapshot.data()['name'],
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
          ),
          actions: [
            Icon(Icons.notifications_active_outlined),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(4.0))),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ), */
            Icon(Icons.more_vert),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(4.0))),
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
