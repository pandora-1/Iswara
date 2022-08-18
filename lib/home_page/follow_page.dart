import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:iswara/authentication_service.dart';
import 'package:iswara/constants.dart';
import 'package:iswara/home_page/favorites.dart';

class FollowPage extends StatefulWidget {
  @override
  _FollowPage createState() => _FollowPage();
}

class _FollowPage extends State<FollowPage> {
  static const routeName = "/homepage";
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot blogSnapshot;

  bool isSave = false;

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
      drawer: Drawer(
        child: Container(
          color: ColorPalette.primaryColor,
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(250.0))),
              ListTile(
                title: Text("DEKAP",
                  style: TextStyle(
                    color: ColorPalette.primaryTextColor,
                    fontSize: ScreenUtil.instance.setWidth(25.0),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(30.0))),
              ListTile(
                title: Text("DENGARKAN",
                  style: TextStyle(
                    color: ColorPalette.primaryTextColor,
                    fontSize: ScreenUtil.instance.setWidth(25.0),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context, new MaterialPageRoute(
                      builder: (context) => Dengarkan()
                  ));
                },
              ),
              Padding(padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(30.0))),
              ListTile(
                title: Text("DAMPINGI",
                  style: TextStyle(
                    color: ColorPalette.primaryTextColor,
                    fontSize: ScreenUtil.instance.setWidth(25.0),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context, new MaterialPageRoute(
                      builder: (context) => Dampingi()
                  ));
                },
              ),
            ],
          ),
        )
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
                                                  maxLines: 2,
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
                                              context, new MaterialPageRoute(
                                            builder: (context) => ShowContent(
                                              title:  blogSnapshot.docs[index].data()['title'],
                                              author: blogSnapshot.docs[index].data()['authorName'],
                                              description: blogSnapshot.docs[index].data()['desc'],
                                              images: blogSnapshot.docs[index].data()['imgUrl'],)
                                          ));
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
                                    IconButton(
                                      icon: Icon(isSave? Icons.star : Icons.star_border, size: ScreenUtil.instance.setHeight(40.0),),
                                      color: ColorPalette.primaryTextColor,
                                      onPressed: () {
                                        setState(() {
                                          if(isSave) {
                                            isSave = false;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Success!'),
                                                  content: Text('This post will remove from your favorite'),
                                                  actions: [
                                                    FlatButton(
                                                      textColor: Color(0xFF6200EE),
                                                      onPressed: () {
                                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            // remove data from database favorite
                                          } else {
                                            isSave = true;
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Success!'),
                                                  content: Text('This post will add to your favorite'),
                                                  actions: [
                                                    FlatButton(
                                                      textColor: Color(0xFF6200EE),
                                                      onPressed: () {
                                                        Navigator.of(context, rootNavigator: true).pop('dialog');
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            // add data to database favorite
                                          }
                                        });
                                      },
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

          title: Text(
            'DEKAP',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.star_border_purple500_outlined),
                onPressed: () {
                  Navigator.push(
                      context, new MaterialPageRoute(
                      builder: (context) => FavoritePage()
                  ));
                }),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(4.0))),
            IconButton(
                icon: Icon(Icons.chat_outlined),

            ),
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


class ShowContent extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String images;
  ShowContent({this.title, this.author, this.description, this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author, style: TextStyle(color: ColorPalette.primaryTextColor),),
        backgroundColor: ColorPalette.primaryColor,
      ),
      backgroundColor: ColorPalette.primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
       child: Container(
         color: ColorPalette.primaryColor,
         padding: EdgeInsets.all( ScreenUtil.instance
             .setHeight(20.0),),
         alignment: Alignment.topLeft,


         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Padding(padding: EdgeInsets.only(top: ScreenUtil.instance
                 .setHeight(20.0),)),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SizedBox(
                   height: ScreenUtil.instance
                       .setHeight(190.0),
                   width: ScreenUtil.instance.setWidth(
                       190.0), // fixed width and height
                   child: Image.network(
                     images,
                     fit: BoxFit.cover,
                   ),
                 ),
               ],
             ),
             Padding(padding: EdgeInsets.only(top: ScreenUtil.instance
                 .setHeight(20.0),)),
             Text(
               title,
               style: TextStyle(
                   fontSize: ScreenUtil.instance.setHeight(35.0),
                   color: ColorPalette.primaryTextColor
               ),
             ),
             Padding(padding: EdgeInsets.only(top: ScreenUtil.instance
                 .setHeight(2.0),)),
             Text(
               author,
               style: TextStyle(
                   fontSize: ScreenUtil.instance.setHeight(20.0),
                   color: ColorPalette.primaryTextColor
               ),
             ),
             Padding(padding: EdgeInsets.only(top: ScreenUtil.instance
                 .setHeight(10.0),)),
             Text(
               description,
               style: TextStyle(
                   fontSize: ScreenUtil.instance.setHeight(20.0),
                   color: ColorPalette.primaryTextColor
               ),
             )
           ],
         ),
       ),
      )
    );
  }
}

class Dengarkan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
        appBar: AppBar(
          title: Text(
            "DENGARKAN", style: TextStyle(color: ColorPalette.primaryTextColor),),
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: Center(
          child: Text(
            "Akan segera hadir untuk Perempuan Indonesia",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
              fontSize: 30.0,

            ),
          ),
        )
    );
  }
}

class Dampingi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
        appBar: AppBar(
          title: Text(
            "DAMPINGI", style: TextStyle(color: ColorPalette.primaryTextColor),),
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: Center(
          child: Text(
            "Akan segera hadir untuk Perempuan Indonesia",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
              fontSize: 30.0,
            ),
          ),
        )
    );
  }
}