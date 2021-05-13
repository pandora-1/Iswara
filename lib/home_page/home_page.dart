import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/authentication_service.dart';
import 'package:iswara/constants.dart';
import 'package:iswara/home_page/follow_page.dart';
import 'package:iswara/home_page/profile_page.dart';
import 'package:iswara/home_page/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State {
  int _selectedIndex = 0;

  final _widgetOptions = [
    FollowPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorPalette.primaryColor,
          unselectedItemColor: ColorPalette.primaryTextColor,
          iconSize: ScreenUtil.instance.setHeight(35.0),
          selectedFontSize: 0,
          unselectedFontSize: 0,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
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
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
