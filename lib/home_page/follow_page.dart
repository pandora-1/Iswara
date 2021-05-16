import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:iswara/authentication_service.dart';
import 'package:iswara/constants.dart';

/*
class FollowPage extends StatefulWidget {
  @override
  _FollowPage createState() => _FollowPage();
}

class _FollowPage extends State<FollowPage> {
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot blogSnapshot;

  @override
  void initState() {
    super.initState();

    crudMethods.getData().then((result) {
      blogSnapshot = result;
      setState(() {});
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _appBarsTopHomePage(),
      ),
      body: Container(
        color: ColorPalette.primaryColor,
        child: blogSnapshot != null
            ? ListView.builder(
                itemCount: blogSnapshot.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.instance.setHeight(450.0),
                        height: ScreenUtil.instance.setHeight(250.0),
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: ColorPalette.primaryColor,
                            elevation: 10,
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0)),
                                    Expanded(
                                        flex: 6,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  blogSnapshot.docs[index]
                                                      .data()['title'],
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: ScreenUtil
                                                        .instance
                                                        .setWidth(20.0),
                                                  )),
                                              Text(
                                                  blogSnapshot.docs[index]
                                                      ['authorName'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil
                                                          .instance
                                                          .setWidth(15.0))),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil.instance
                                                          .setWidth(10.0),
                                                      bottom: 0.0)),
                                              Text(
                                                  blogSnapshot.docs[index]
                                                      ['desc'],
                                                  textAlign: TextAlign.left,
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil
                                                          .instance
                                                          .setWidth(15.0))),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil.instance
                                                .setWidth(15.0))),
                                    Expanded(
                                        flex: 6,
                                        child: Column(children: <Widget>[
                                          SizedBox(
                                            height: ScreenUtil.instance
                                                .setWidth(161.0),
                                            width: ScreenUtil.instance.setWidth(
                                                161.0), // fixed width and height
                                            child: Image.network(
                                              blogSnapshot.docs[index]
                                                  ['imgUrl'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ])),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil.instance
                                                .setWidth(20.0))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0)),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: RaisedButton(
                                        color: ColorPalette.primaryTextColor,
                                        onPressed: () {
                                          Navigator.push(
                                              context, new MaterialPageRoute());
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                        child: Text(
                                          "Read More",
                                          style: new TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 190.0)),
                                    Icon(
                                      Icons.star_border,
                                      size: 40.0,
                                      color: ColorPalette.primaryTextColor,
                                    ),
                                  ],
                                )
                              ],
                            )),
                      )
                    ],
                  );
                },
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _appBarsTopHomePage() {
    return Column(
      children: <Widget>[
        AppBar(
          leading: Icon(Icons.menu),
          title: Text(
            'DEKAP',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
          ),
          actions: [
            Icon(Icons.star_border_purple500_outlined),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(4.0))),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ), */
            Icon(Icons.chat_outlined),
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

  Widget _contentcard(data, index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(data[index].title),
            subtitle: Text(
              data[index].author,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              data[index].description,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 1'),
              ),
            ],
          ),
          Image.asset('assets/card-sample-image.jpg'),
          Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),
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

class ReusableComponent {
  final String title;
  final String author;
  final String description;
  final String image;
  final String linkToArticle;

  ReusableComponent({
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.image,
    @required this.linkToArticle,
  });
}


 */

class FollowPage extends StatefulWidget {
  @override
  _FollowPage createState() => _FollowPage();
}

class _FollowPage extends State<FollowPage> {
  static const routeName = "/homepage";
  /*var items = [
    ReusableComponent(title: "Jakarta, Kota Paling Rentan Bahaya Lingkungan di Dunia", author: "Safir Makki", description: "Jakarta, CNN Indonesia -- DKI Jakarta menduduki peringkat teratas daftar kota paling rentan bahaya lingkungan di dunia. Menurut sebuah penilaian atau indeks iklim risiko yang diterbitkan Jumat (7/5), Jakarta berisiko tenggelam.", image: "./iswara_logo.png", linkToArticle: "./1"),
    ReusableComponent(title: "Lebaran 2021, Asa dalam Mangkuk Mi dan Terminal Mati", author: "Feybien Ramayanti", description: "Jakarta, CNN Indonesia -- Sepasang mata pria hampir paruh baya di hadapan saya memandang lurus ke ruang lowong di depannya. Hamparan lengang itu lebih mirip lapangan sonder rumput ketimbang terminal.Lobang pada lahan lapang beraspal itu jadi kelihatan karena tak lagi tertutup badan kendaraan. Tak satupun bus terparkir di sana. Apalagi penumpang. Tidak pula orang-orang dengan gembolan kardus-kardus atau tas gendong. Lalu lalang agen perjalanan pun tak ada.", image: "./iswara_logo.png", linkToArticle: "./1"),
    ReusableComponent(title: "Cara Menandai Lokasi di Google Maps untuk Tambah Alamat", author: "Adhi Wicaksono", description: "Jakarta, CNN Indonesia -- Keberadaan teknologi kian hari berguna untuk memudahkan hidup manusia. Salah satunya dengan fitur Maps pada Google Maps atau peta digital yang diakses menggunakan ponsel smartphone.", image: "./iswara_logo.png", linkToArticle: "./1")
  ];*/
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot blogSnapshot;

  @override
  void initState() {
    super.initState();

    crudMethods.getData().then((result) {
      blogSnapshot = result;
      setState(() {});
    });
  }

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _appBarsTopHomePage(),
      ),
      body: Container(
        color: ColorPalette.primaryColor,
        child: blogSnapshot != null
            ? ListView.builder(
                itemCount: blogSnapshot.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.instance.setHeight(450.0),
                        height: ScreenUtil.instance.setHeight(250.0),
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: ColorPalette.primaryColor,
                            elevation: 10,
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0)),
                                    Expanded(
                                        flex: 6,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  blogSnapshot.docs[index]
                                                      .data()['title'],
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: ScreenUtil
                                                        .instance
                                                        .setWidth(20.0),
                                                  )),
                                              Text(
                                                  blogSnapshot.docs[index]
                                                      .data()['authorName'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil
                                                          .instance
                                                          .setWidth(15.0))),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil.instance
                                                          .setWidth(10.0),
                                                      bottom: 0.0)),
                                              Text(
                                                  blogSnapshot.docs[index]
                                                      .data()['desc'],
                                                  textAlign: TextAlign.left,
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil
                                                          .instance
                                                          .setWidth(15.0))),
                                            ])),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil.instance
                                                .setWidth(15.0),
                                            )),
                                    Expanded(
                                        flex: 6,
                                        child: Column(children: <Widget>[
                                          SizedBox(
                                            height: ScreenUtil.instance
                                                .setHeight(150.0),
                                            width: ScreenUtil.instance.setWidth(
                                                140.0), // fixed width and height
                                            child: Image.network(
                                              blogSnapshot.docs[index]
                                                  .data()['imgUrl'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ])),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil.instance
                                                .setWidth(20.0))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 5.0)),
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      child: RaisedButton(
                                        color: ColorPalette.primaryTextColor,
                                        onPressed: () {
                                          Navigator.push(
                                              context, new MaterialPageRoute());
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                        child: Text(
                                          "Read More",
                                          style: new TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: ScreenUtil.instance.setWidth(190.0)), ),
                                    Icon(
                                      Icons.star_border,
                                      size: ScreenUtil.instance.setHeight(40.0),
                                      color: ColorPalette.primaryTextColor,
                                    ),
                                  ],
                                )
                              ],
                            )),
                      )
                    ],
                  );
                },
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget _appBarsTopHomePage() {
    return Column(
      children: <Widget>[
        AppBar(
          leading: Icon(Icons.menu),
          title: Text(
            'DEKAP',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
          ),
          actions: [
            Icon(Icons.star_border_purple500_outlined),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(4.0))),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ), */
            Icon(Icons.chat_outlined),
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

  Widget _contentcard(data, index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(data[index].title),
            subtitle: Text(
              data[index].author,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              data[index].description,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              FlatButton(
                textColor: const Color(0xFF6200EE),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('ACTION 1'),
              ),
            ],
          ),
          Image.asset('assets/card-sample-image.jpg'),
          Image.asset('assets/card-sample-image-2.jpg'),
        ],
      ),
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

class ReusableComponent {
  final String title;
  final String author;
  final String description;
  final String image;
  final String linkToArticle;

  ReusableComponent({
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.image,
    @required this.linkToArticle,
  });
}
