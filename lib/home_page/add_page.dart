import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iswara/authentication_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iswara/constants.dart';
import 'package:random_string/random_string.dart';
import 'package:iswara/home_page/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid_string;
  bool _isLoading = false;

  void getUid() {
    final User user = auth.currentUser;
    final uid = user.uid;
    uid_string = uid;
    // here you write the codes to input the data into firestore
  }

  String authorName, title, desc;

  File _image;
  CrudMethods crudMethods = new CrudMethods();
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
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
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Upload",
                style: TextStyle(fontSize: 22,
                color: ColorPalette.primaryTextColor),
              ),
              Text(
                " Story ",
                style: TextStyle(fontSize: 22, color: ColorPalette.primaryTextColor),
              )
            ],
          ),
          backgroundColor: ColorPalette.primaryColor,
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                uploadData();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(16.0)),
                  child: Icon(Icons.file_upload), color: ColorPalette.primaryTextColor,),
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _isLoading
              ? Container(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          )
              : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: _image != null
                        ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: ScreenUtil.instance.setHeight(190.0),
                      // width: MediaQuery.of(context).size.width,
                      width: ScreenUtil.instance.setHeight(190.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.setWidth(16.0)),
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      width: MediaQuery.of(context).size.width,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.instance.setHeight(8.0),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onChanged: (val) {
                            title = val;
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              color: ColorPalette.primaryTextColor,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.instance.setHeight(15.0))),
                        TextFormField(
                          onChanged: (val) {
                            desc = val;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Story',
                            labelStyle: TextStyle(
                              color: ColorPalette.primaryTextColor,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        )

        );
  }
}
