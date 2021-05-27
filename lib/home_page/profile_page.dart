import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iswara/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iswara/home_page/add_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:storage_path/storage_path.dart';
import '../authentication_service.dart';
import 'dart:io';

/* class ProfilePage extends StatefulWidget {
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


 */

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid_string;
  bool _isLoading = false;

  void getUid() {
    final User user = auth.currentUser;
    final uid = user.uid;
    uid_string = uid;
    // here you write the codes to input the data into firestore
  }

  String authorName, title, desc, username, _imagePath;

  Image image1;
  File _image, _profileImage;
  CrudMethods crudMethods = new CrudMethods();

  Future pickImage() async {
    ImagePicker.pickImage(source: ImageSource.gallery).then((onValue) {
      StoragePath.imagesPath.then((dynamic dirPath) {
        final myPath = dirPath;
        File file = new File('$myPath/capture.png');
        file.writeAsBytes(onValue.readAsBytesSync()).then((savedFile) {
          setState(() {
            _imagePath = '$myPath/capture.png';
          });
        });
      });
    });
  }

  Future getImage() async {
    var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    var bytes = pickedFile.readAsBytesSync();
    setState(() {
      if (pickedFile != null) {
        image1 = Image.memory(bytes);
        _image = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getProfileImage() async {
    var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  uploadProfilePicture() async {
    setState(() {
      _isLoading = true;
    });
    String _downloadUrl;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference _ref = storage.ref().child("img").child("$uid_string.jpg");
    UploadTask task = _ref.putFile(_profileImage);
    await task.then((res) async {
      _downloadUrl = await res.ref.getDownloadURL();
    });
    getUid();
    DocumentReference ref =
        FirebaseFirestore.instance.collection("users").doc(uid_string);
    ref.set({'name': snapshot.data()['name'], 'profileUrl': _downloadUrl});
  }

  updateProfileName() async {
    getUid();
    DocumentReference ref =
        FirebaseFirestore.instance.collection("users").doc(uid_string);
    ref.set({'name': username, 'profileUrl': null});
  }

  uploadData() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });
      getUid();
      String downloadUrl;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref()
          .child("img")
          .child("$uid_string${randomAlphaNumeric(9)}.jpg");

      UploadTask task = ref.putFile(_image);
      await task.then((res) async {
        downloadUrl = await res.ref.getDownloadURL();
      });
      print("this is url $downloadUrl");
      authorName = snapshot.data()['name'];

      Map<String, String> blogMap = {
        "uid": uid_string,
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } else {}
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot snapshot;
  QuerySnapshot blogSnapshot;

  @override
  void initState() {
    super.initState();

    users.doc(auth.currentUser.uid).get().then((result) {
      snapshot = result;
      setState(() {});
    });

    crudMethods.getDataProfile().then((result) {
      blogSnapshot = result;
      setState(() {});
    });
  }

  final picker = ImagePicker();

  /* Untuk menghitung jumlah tulisan yang sudah ditulis */
  var _name = "NAME";
  var _nameTemp = "";

  static const routeName = "/homepage";

  @override
  Widget build(BuildContext context) {
    _image = _image;
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
                  _appBarsTopHomePage(context),
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
    return _isLoading
        ? Container(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          )
        : Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.instance.setHeight(15.0))),
              Column(children: <Widget>[
                SizedBox(
                  height: ScreenUtil.instance.setHeight(150.0),
                  width: ScreenUtil.instance
                      .setWidth(140.0), // fixed width and height
                  child: snapshot != null
                      ? snapshot.data()['profileUrl'] != null
                          ? Image.network(
                              snapshot.data()['profileUrl'],
                              fit: BoxFit.cover,
                            )
                          : CircleAvatar(
                              backgroundColor: ColorPalette.hintColor,
                              radius: 48.0,
                            )
                      : CircleAvatar(
                          backgroundColor: ColorPalette.primaryTextColor,
                          radius: 48.0,
                        ),
                ),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    snapshot != null ? snapshot.data()['name'] : "@Username",
                    style: TextStyle(
                      color: ColorPalette.primaryTextColor,
                      fontSize: ScreenUtil.instance.setHeight(20.0),
                    ),
                  ),
                  Text(
                    blogSnapshot != null ? "${blogSnapshot.docs.length}" : "0",
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
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: ColorPalette.primaryTextColor,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPage()));
                  /*showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      content: Builder(
                        builder: (context) {
                          // Get available height and width of the build area of this widget. Make a choice depending on the size.
                          var height = MediaQuery.of(context).size.height;
                          var width = MediaQuery.of(context).size.width;

                          return Container(
                              height: height,
                              width: width,
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(0),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: image1 != null
                                            ? image1
                                            : Text('No image selected.'),
                                      ),
                                      FlatButton(
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () {
                                          getImage();
                                        }, // action if button pressed
                                        color: Colors.white,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          title = val;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Title',
                                          labelStyle: TextStyle(
                                            color:
                                                ColorPalette.primaryTextColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.instance
                                                  .setHeight(15.0))),
                                      TextFormField(
                                        onChanged: (val) {
                                          desc = val;
                                        },
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          labelText: 'Story',
                                          labelStyle: TextStyle(
                                            color:
                                                ColorPalette.primaryTextColor,
                                          ),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 15.0)),
                                      TextButton(
                                        child: Text("Post Story".toUpperCase(),
                                            style: TextStyle(fontSize: 14)),
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                EdgeInsets>(EdgeInsets.all(15)),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(18.0),
                                                    side: BorderSide(color: ColorPalette.primaryTextColor)))),
                                        onPressed: () {
                                          uploadData();
                                        },
                                      ),
                                    ],
                                  )));
                        },
                      ),
                    ));*/
                },
              )
            ],
          );
  }

  Widget _appBarsTopHomePage(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          leading: new Container(),
          title: Text(
            snapshot != null ? snapshot.data()['name'] : "@Username",
            style: TextStyle(
              color: ColorPalette.primaryTextColor,
            ),
          ),
          actions: [
            Icon(Icons.notifications_active_outlined),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(2.0))),
            /* Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ), */
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              color: ColorPalette.primaryColor,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.drive_file_rename_outline),
                    title: Text('Change Name'),
                    onTap: () {
                      AlertDialog alert = AlertDialog(
                        backgroundColor: ColorPalette.primaryColor,
                        contentPadding: const EdgeInsets.all(16.0),
                        content: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new TextField(
                                autofocus: true,
                                onChanged: (text) {
                                  username = text;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                  decorationColor: Colors.white,
                                ),
                                decoration: new InputDecoration(
                                    labelText: 'New Name',
                                    hintText: "Input your name here"),
                              ),
                            )
                          ],
                        ),
                        actions: <Widget>[
                          new FlatButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          new FlatButton(
                              child: const Text('Change'),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                  updateProfileName();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                });
                              })
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.add_a_photo_outlined),
                    title: Text('Profile Picture'),
                    onTap: () async {
                      await getProfileImage();
                      uploadProfilePicture();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem(child: Text('Notifications')),
                PopupMenuItem(child: Text('Privacy')),
                PopupMenuItem(child: Text('Help')),
                PopupMenuItem(child: Text('About')),
                PopupMenuItem(child: Text('Preferences')),
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Log Out'),
                    onTap: () {
                      context.read<AuthenticationService>().signOut(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil.instance.setHeight(2.0))),
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
