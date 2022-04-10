import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:jito_matrimony/EditActivity/addbiodata.dart';
import 'package:jito_matrimony/EditActivity/uploaddoc.dart';
import 'package:jito_matrimony/EditActivity/uploadphoto.dart';
import 'package:jito_matrimony/manage_bio.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage.dart';

class editdoc extends StatefulWidget{

  @override
  edoc createState() => edoc();
}


class edoc extends State<editdoc> {

  File _image;
  String res1;
  String res2;
  String res3;
  String img1= "";
  String img2 ="";
  String img3 = "";
  String imag1, imag2, imag3;
  String image1, image2, image3;
  SharedPreferences myPrefs;
  String _userid, _token, _bioid;

  bool isfirst = false;




  Future cropImage(filePath) async{

    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    return croppedImage;
  }

  Future getImage(String no) async {

    print("no = $no");

    PickedFile pickedimage = await ImagePicker().getImage(
        source: ImageSource.gallery);

    File image = await cropImage(pickedimage.path);

    final String fileName = basename(image.path);
    Directory directory = await getApplicationDocumentsDirectory();
    final myImagePath = '${directory.path}/MyImagesdoc';
    final myImgDir = await new Directory(myImagePath).create();

    File newImage = await File(image.path);
    newImage = await newImage.copy('$myImagePath/$fileName');

    if (image != null) {
      setState(() {
        _image = File(image.path);
        if(no=="1"){
          res1 = newImage.path;
        }else if(no=="2"){
          res2 = newImage.path;
        }
      });

      final bytes = File(_image.path).readAsBytesSync();

      if(no=="1"){
        setState(() {
          img1 = base64Encode(bytes);
        });

      }
      if(no=="2"){
        setState(() {
          img2 = base64Encode(bytes);
        });
      }

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPref();
  }

  initPref() async {
    myPrefs = await SharedPreferences.getInstance();

    setState(() {
      _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
      _token = MySharedPreferences.instance.getStringValue("token", myPrefs);
      _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
      image1 = MySharedPreferences.instance.getStringValue("imagedoc1", myPrefs);
      image2 = MySharedPreferences.instance.getStringValue("imagedoc2", myPrefs);
    });
  }

  uploaddocument(context, uploaddoc response ){
    print("done");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage()));
  }

  getbioid(addbiodata resp){
 //   MySharedPreferences.instance.setStringValue("bio_id", resp.datainfo.bioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(actions: <Widget>[
          TextButton(
            onPressed: () async {


              setState(() {

                imag1 ="data:image/jpeg;base64,"+"$img1";
                imag2 ="data:image/jpeg;base64,$img2";

              });

              await Provider.of<ProviderService>(context, listen: false).getuploaddoc({"user_id": "$_userid", "token": "$_token", "image": "$imag1", "image_1" : "$imag2", "image_2" : "data:image/jpeg;base64,", "image_3" : "data:image/jpeg;base64,", "bio_id": _bioid }).then((value) => uploaddocument(context, value.body));


            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                VerticalDivider(thickness: 1.0, color: Colors.white,),
                Icon(Icons.check, color: Colors.white),
                SizedBox(width: 5,),
                Text('SAVE  ', style: TextStyle(color: Colors.white, fontSize: 15))
              ],
            ),
          ),

        ]),
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.all(20.0),
            child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    getImage("1");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    height: MediaQuery.of(context).size.height * .18,
                                    width: MediaQuery.of(context).size.width * .35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: res1== null ? image1 == null ?  AssetImage(
                                                'Assets/ic_add_familymember.png'): NetworkImage(image1) : FileImage(File(res1)),
                                            fit: BoxFit.fill
                                        )
                                    ),

                                  ),),

                                Positioned(
                                    right: 0.0,
                                    top: 0.0,
                                    child: GestureDetector(
                                        onTap:(){
                                          _image = null;
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: 43,
                                          width: 40,

                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'Assets/delete.png'),
                                              fit: BoxFit.fill,

                                            ),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    25.0)),
                                          ),
                                        ))
                                ),
                              ]
                          ),
                          Container(
                            height: 25,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .35,
                            alignment: Alignment.center,
                            color: Colors.grey,
                            child: Text('Education Proof',),
                          )
                        ]
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    getImage("2");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    height: MediaQuery.of(context).size.height * .18,
                                    width: MediaQuery.of(context).size.width * .35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: res2== null ? image2 == null ?  AssetImage(
                                                'Assets/ic_add_familymember.png'): NetworkImage(image2) : FileImage(File(res2)),
                                            fit: BoxFit.contain
                                        )
                                    ),

                                  ),),

                                Positioned(
                                    right: 0.0,
                                    top: 0.0,
                                    child: GestureDetector(
                                        onTap:(){

                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          height: 43,
                                          width: 40,

                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'Assets/delete.png'),
                                              fit: BoxFit.fill,

                                            ),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    25.0)),
                                          ),
                                        ))
                                ),
                              ]
                          ),
                          Container(
                            height: 25,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .35,
                            alignment: Alignment.center,
                            color: Colors.grey,
                            child: Text('Photo Proof',),
                          )
                        ]
                    ),
                  ),

                ])
        )
    );
  }

}