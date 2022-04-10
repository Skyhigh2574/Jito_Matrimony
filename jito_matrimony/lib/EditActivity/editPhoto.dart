import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:jito_matrimony/EditActivity/addbiodata.dart';
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

class editPhoto extends StatefulWidget{

  String flag;
  editPhoto({this.flag});
  @override
  ephoto createState() => ephoto();
}


class ephoto extends State<editPhoto> {

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

   getImage(String no) async {

    print("no = $no");

    PickedFile pickedimage = await ImagePicker().getImage(
        source: ImageSource.gallery);

    File image = await cropImage(pickedimage.path);

    final String fileName = basename(image.path);
    Directory directory = await getApplicationDocumentsDirectory();
    final myImagePath = '${directory.path}/MyImages';
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
        }else{
          res3 = newImage.path;
        }
      });

      final bytes = File(_image.path).readAsBytesSync();

      if(no=="1"){
        setState(() {
          img1 = base64Encode(bytes);
        });

      }
      else if(no=="2"){
        setState(() {
          img2 = base64Encode(bytes);
        });
      }
      else{
        setState(() {
          img3 = base64Encode(bytes);
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
      image1 = MySharedPreferences.instance.getStringValue("image1", myPrefs);
      image2 = MySharedPreferences.instance.getStringValue("image2", myPrefs);
      image3 = MySharedPreferences.instance.getStringValue("image3", myPrefs);
    });
  }

  uploadimage(context, uploadphoto response ){
    print("done");
    print(response.message);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        homepage()), (Route<dynamic> route) => false);
  }

  getbioid(addbiodata resp){
    MySharedPreferences.instance.setStringValue("bio_id", resp.datainfo.bioId);
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

          appBar: AppBar(actions: <Widget>[
            TextButton(
              onPressed: () async {


                setState(() {

                  imag1 ="data:image/jpeg;base64,$img1";
                  imag2 ="data:image/jpeg;base64,$img2";
                  imag3 ="data:image/jpeg;base64,$img3";

                  print(imag1);
                  print(imag2);
                  print(imag3);

                });

                await Provider.of<ProviderService>(context, listen: false).getuploadphoto({"user_id": "$_userid", "token": "$_token", "image": "$imag1", "image_1" : "$imag2", "image_2" : "$imag3", "bio_id": _bioid }).then((value) => uploadimage(context, value.body));

                // if(widget.flag == "0"){
                // if(img1 != null || img2 !=null || img3!=null){
                //   await Provider.of<ProviderService>(context, listen: false).addBiodata({"user_id": "$_userid", "token": "$_token", "biodata_person": "self" }).then((value) => getbioid(value.body));
                // }
                // }
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
                                      width: MediaQuery.of(context).size.width * .26,
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
                                          setState(() {
                                            img1 = "";
                                            image1 = null;
                                            res1 = null;
                                          });

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
                                  .width * .25,
                              alignment: Alignment.center,
                              color: Colors.grey,
                              child: Text('Profile Picture',),
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
                                      width: MediaQuery.of(context).size.width * .26,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: res2== null ? image2 == null ?  AssetImage(
                                                  'Assets/ic_add_familymember.png'): NetworkImage(image2) : FileImage(File(res2)),
                                              fit: BoxFit.fill,
                                          )
                                      ),

                                    ),),

                                  Positioned(
                                      right: 0.0,
                                      top: 0.0,
                                      child: GestureDetector(
                                          onTap:(){
                                           setState(() {
                                             img2 = "";
                                             image2 = null;
                                             res2 = null;
                                           });

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
                                  .width * .25,
                              alignment: Alignment.center,
                              color: Colors.grey,
                              child: Text('Profile Picture',),
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
                                      getImage("3");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5.0),
                                      height: MediaQuery.of(context).size.height * .18,
                                      width: MediaQuery.of(context).size.width * .26,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: res3== null ? image3 == null ?  AssetImage(
                                                  'Assets/ic_add_familymember.png'): NetworkImage(image3) : FileImage(File(res3)),
                                              fit: BoxFit.fill
                                          )
                                      ),

                                    ),),

                                  Positioned(
                                      right: 0.0,
                                      top: 0.0,
                                      child: GestureDetector(
                                          onTap:(){
                                            setState(() {
                                              img3 = "";
                                              res3 = null;
                                              image3 = null;
                                            });

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
                                  .width * .25,
                              alignment: Alignment.center,
                              color: Colors.grey,
                              child: Text('Profile Picture',),
                            )
                          ]
                      ),
                    ),
                  ])
          )
      );
    }

}