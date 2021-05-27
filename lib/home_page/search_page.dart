import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/authentication_service.dart';
import 'package:iswara/constants.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:core';

// data dummy untuk list, disini aku pakai list
List<ListWords> listWords =
    [] /*= [
  ListWords(
      'Makanan Lezat',
      'Michael',
      'deskripsi adalah pemaparan atau penggambaran dengan kata-kata secara jelas dan terperinci. ',
      'assets/images/iswara_logo.png',
      '1'),
  ListWords(
      'Minuman',
      'Lil',
      'deskripsi adalah pemaparan atau penggambaran dengan kata-kata secara jelas dan terperinci. ',
      'assets/images/iswara_logo.png',
      '2'),
  ListWords(
      'Hadiah',
      'Lala',
      'deskripsi adalah pemaparan atau penggambaran dengan kata-kata secara jelas dan terperinci. ',
      'assets/images/iswara_logo.png',
      '3'),
]*/
    ;

// urutannya ada title, author, desc, image, sama favorite list

// ada yg ak ubah, dari id list -> favorite list, type bool
class ListWords {
  String titlelist;
  String authorlist;
  String descriptionlist;
  String imagelist;
  bool favoritelist;

  ListWords(String titlelist, String authorlist, String descriptionlist,
      String imagelist, bool favoritelist) {
    this.titlelist = titlelist;
    this.authorlist = authorlist;
    this.descriptionlist = descriptionlist;
    this.imagelist = imagelist;
    this.favoritelist = favoritelist;
  }
}

class Detail extends StatelessWidget {
  final ListWords listWordsDetail;

  Detail({Key key, @required this.listWordsDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(listWordsDetail.titlelist,
              style: TextStyle(color: ColorPalette.primaryTextColor)),
          iconTheme: IconThemeData(color: ColorPalette.primaryTextColor),
          backgroundColor: ColorPalette.primaryColor,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(listWordsDetail.titlelist + ' (on detail page)'),
              Text(listWordsDetail.authorlist),
            ],
          ),
        ));
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        iconTheme: IconThemeData(color: ColorPalette.primaryTextColor),
        title: Text(
          'Search Stories',
          style: TextStyle(
            color: ColorPalette.primaryTextColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: ColorPalette.primaryTextColor,
              onPressed: () {
                blogSnapshot != null
                    ? blogSnapshot.docs.forEach((el) {
                        listWords.add(ListWords(el['title'], el['authorName'],
                            el['desc'], el['imgUrl'], false));
                      })
                    : print("ok");
                showSearch(context: context, delegate: DataSearch(listWords));
              })
        ],
      ),
      body: Scaffold(
        backgroundColor: ColorPalette.primaryColor,
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<ListWords> listWords;

  DataSearch(this.listWords);
  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Ini nampilin hasil setelah tekan search
    // pakai suggestionList untuk menampilkan data yang difilter
    final suggestionList = query.isEmpty
        ? listWords
        : listWords
            .where((p) =>
                p.titlelist.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => Container(
          // color: ColorPalette.primaryColor,
          decoration: new BoxDecoration(
            color: ColorPalette.primaryColor,
          ),
          child: Container(
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
                        Padding(padding: EdgeInsets.only(left: 10.0)),
                        Expanded(
                            flex: 6,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      suggestionList[index]
                                          .titlelist, // Untuk judul
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenUtil.instance.setWidth(20.0),
                                      )),
                                  Text(
                                      suggestionList[index]
                                          .authorlist, // untuk author
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: ScreenUtil.instance
                                              .setWidth(15.0))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.instance
                                              .setWidth(10.0),
                                          bottom: 0.0)),
                                  Text(suggestionList[index].descriptionlist,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: ScreenUtil.instance
                                              .setWidth(15.0))),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil.instance.setWidth(15.0))),
                        Expanded(
                            flex: 6,
                            child: Column(children: <Widget>[
                              SizedBox(
                                height: ScreenUtil.instance.setHeight(150.0),
                                width: ScreenUtil.instance
                                    .setWidth(140.0), // fixed width and height
                                child: Image.network(
                                  suggestionList[index].imagelist,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ])),
                        Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil.instance.setWidth(20.0))),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(5.0),
                        )),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: RaisedButton(
                            color: ColorPalette.primaryTextColor,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ShowContent(
                                            title: suggestionList[index].titlelist,
                                            author: suggestionList[index].authorlist,
                                            description: suggestionList[index]
                                                .descriptionlist,
                                            images: suggestionList[index].imagelist,
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.transparent)),
                            child: Text(
                              "Read More", // Ini untuk button, udah ada ID kalau misal untuk ngehubungin ke tiap2 tulisan
                              style: new TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(190.0),
                        )),
                        IconButton(
                          icon: Icon(suggestionList[index].favoritelist? Icons.star : Icons.star_border, size: ScreenUtil.instance.setHeight(40.0),),
                          color: ColorPalette.primaryTextColor,
                              onPressed: () {

                                if(suggestionList[index].favoritelist) {
                                  suggestionList[index].favoritelist = false;
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
                                  // remove data from database
                                } else {
                                  suggestionList[index].favoritelist = true;
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
                                  // add data to database
                                }
                              }),
                      ],
                    )
                  ],
                )),
          )),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Ini pas seseorang lagi search judul, bukan pas udah neken tombol search

    final suggestionList = query.isEmpty
        ? listWords
        : listWords
            .where((p) =>
                p.titlelist.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => Container(
          // color: ColorPalette.primaryColor,
          decoration: new BoxDecoration(
            color: ColorPalette.primaryColor,
          ),
          child: Container(
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
                            padding: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(10.0),
                        )),
                        Expanded(
                            flex: 6,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      suggestionList[index]
                                          .titlelist, // ini untuk judul
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenUtil.instance.setWidth(20.0),
                                      )),
                                  Text(suggestionList[index].authorlist,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: ScreenUtil.instance
                                              .setWidth(15.0))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.instance
                                              .setWidth(10.0),
                                          bottom: 0.0)),
                                  Text(suggestionList[index].descriptionlist,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: ScreenUtil.instance
                                              .setWidth(15.0))),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil.instance.setWidth(15.0))),
                        Expanded(
                            flex: 6,
                            child: Column(children: <Widget>[
                              SizedBox(
                                height: ScreenUtil.instance.setHeight(150.0),
                                width: ScreenUtil.instance
                                    .setWidth(140.0), // fixed width and height
                                child: Image.network(
                                  suggestionList[index].imagelist,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ])),
                        Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil.instance.setWidth(20.0))),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(5.0),
                        )),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: RaisedButton(
                            color: ColorPalette.primaryTextColor,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => ShowContent(
                                            title: suggestionList[index].titlelist,
                                            author: suggestionList[index].authorlist,
                                            description: suggestionList[index]
                                                .descriptionlist,
                                            images: suggestionList[index].imagelist,
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.transparent)),
                            child: Text(
                              "Read More", // Tombol untuk read more, bisa pakai ID yg udah ak buat di state awal
                              style: new TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(190.0),
                        )),
                        IconButton(
                          icon: Icon(suggestionList[index].favoritelist? Icons.star : Icons.star_border, size: ScreenUtil.instance.setHeight(40.0),),
                          color: ColorPalette.primaryTextColor,
                          onPressed: () {
                              if(suggestionList[index].favoritelist) {
                                suggestionList[index].favoritelist = false;
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
                                // remove data from database
                              } else {
                                suggestionList[index].favoritelist = true;
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
                                // add data to database
                              }
                          },
                        ),
                      ],
                    )
                  ],
                )),
          )),
      itemCount: suggestionList.length,
    );
  }
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
      backgroundColor: ColorPalette.primaryColor,
      appBar: AppBar(
        title: Text(
          author,
          style: TextStyle(color: ColorPalette.primaryTextColor),
        ),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: ColorPalette.primaryColor,
          padding: EdgeInsets.all(
            ScreenUtil.instance.setHeight(20.0),
          ),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.instance.setHeight(20.0),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenUtil.instance.setHeight(190.0),
                    width: ScreenUtil.instance
                        .setWidth(190.0), // fixed width and height
                    child: Image.network(
                      images,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.instance.setHeight(20.0),
                  )),
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil.instance.setHeight(35.0),
                    color: ColorPalette.primaryTextColor),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.instance.setHeight(2.0),
                  )),
              Text(
                author,
                style: TextStyle(
                    fontSize: ScreenUtil.instance.setHeight(20.0),
                    color: ColorPalette.primaryTextColor),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.instance.setHeight(10.0),
                  )),
              Text(
                description,
                style: TextStyle(
                    fontSize: ScreenUtil.instance.setHeight(20.0),
                    color: ColorPalette.primaryTextColor),
              )
            ],
          ),
        ),
      )

    );
  }
}
