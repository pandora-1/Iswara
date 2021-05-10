import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/constants.dart';



class FollowPage extends StatelessWidget {
  static const routeName = "/homepage";
  var items = [
    ReusableComponent(title: "Makanan Sehat Lezat Berfizi tinggi", author: "ichael", description: "lorem ipsum ", image: "./iswara_logo.png", linkToArticle: "./1"),
    ReusableComponent(title: "Makanan Sehat", author: "Micho", description: "a", image: "./iswara_logo.png", linkToArticle: "./1"),
    ReusableComponent(title: "Makanan ", author: "Mici", description: "b", image: "./iswara_logo.png", linkToArticle: "./1")
  ];
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
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _appBarsTopHomePage(),
      ),
      body: Container(
        color: ColorPalette.primaryColor,
        child: ListView.builder(
          itemCount: items.length,
            itemBuilder: (context, index) {
                return  Column(
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 0.0)),
                               Expanded(
                                   flex: 6,
                                   child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                         children: <Widget>[
                                           Padding(padding: EdgeInsets.only(top: 30.0)),
                                           Text(
                                               "${items[index].title}",
                                               style: TextStyle(fontSize: ScreenUtil.instance.setWidth(20.0))
                                           ),
                                           Text(
                                               "${items[index].author}",
                                               style: TextStyle(fontSize: ScreenUtil.instance.setWidth(15.0))
                                           ),
                                           Padding(padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(20.0))),
                                           Text(
                                               "${items[index].description}",
                                               style: TextStyle(fontSize: ScreenUtil.instance.setWidth(15.0))
                                           ),
                                           ButtonBar(
                                             children: <Widget>[
                                               RaisedButton(
                                                 child: Text('Read More'),
                                                 onPressed: () {/* ... */},
                                               ),
                                             ],
                                           )
                                         ]
                               )),

                              Padding(padding: EdgeInsets.only(right: ScreenUtil.instance.setWidth(15.0))),
                              Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                height: ScreenUtil.instance.setWidth(180.0),
                                width: ScreenUtil.instance.setWidth(180.0), // fixed width and height
                                child: Image.asset("assets/images/iswara_logo.png", fit: BoxFit.cover,),
                              )),

                              Padding(padding: EdgeInsets.only(left: ScreenUtil.instance.setWidth(5.0))),
                            ],
                          ),
                        ),
                      )
                    ],
                  );

            },
        ),
      ),
    );
  }

  Widget _appBarsTopHomePage() {

    return Column(
      children: <Widget>[
        AppBar(
          leading: Icon(Icons.menu),
          title: Text('DEKAP',
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),),
          actions: [
            Icon(Icons.star_border_purple500_outlined),
            Padding(padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setHeight(4.0))),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ), */
            Icon(Icons.chat_outlined),
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

  Widget _contentcard(data, index) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text( data[index].title ),
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
