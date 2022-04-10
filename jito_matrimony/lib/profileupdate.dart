import 'dart:io';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:jito_matrimony/homepage.dart';
import 'package:jito_matrimony/otp.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/registeration.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProviderService.dart';
import 'constants.dart';

class ProfileUpdate extends StatefulWidget {

  final String phone;
  ProfileUpdate({this.phone});

  @override
  Profile createState() => Profile();
}

class Profile extends State<ProfileUpdate>{

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailId = TextEditingController();
  String contact_no, token, userid;
  MySharedPreferences prefs = MySharedPreferences.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String regId;
  String deviceId;
  SharedPreferences myPrefs;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.getToken().then((token) {

      setState(() {
         regId = token.toString();

        print("tokoennnnnnnSssssstterrrrrrr , $regId");
      });

    }

    );

    initPref();
  }

  initPref() async {
    myPrefs = await SharedPreferences.getInstance();
    contact_no = MySharedPreferences.instance.getStringValue("contact_mo", myPrefs);
    token = MySharedPreferences.instance.getStringValue(Verify.token, myPrefs);
    userid = MySharedPreferences.instance.getStringValue(UserID.user_id, myPrefs);
    lastName.text = MySharedPreferences.instance.getStringValue("last_name", myPrefs);
    firstName.text = MySharedPreferences.instance.getStringValue("first_name", myPrefs);
    emailId.text  = MySharedPreferences.instance.getStringValue("email", myPrefs);
  }


  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile Update', style: TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("Assets/login_bg.jpg"),
              fit: BoxFit.cover,
              ),),
              child: Container(
                child :Form(
                key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.all(30.0),

                       child: Container(
                      width: 180,
                      height: 80,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Assets/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  )
              ),
                ),
                    Container(width: 200,
                        height: 50,
                        alignment: Alignment.topCenter,
                        child: Text('Profile Update', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Colors.deepPurple),)),

                    Container(
                        width: 250,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: TextFormField(

                    style: TextStyle(fontSize: 20, color: Colors.black ),
                    textAlign: TextAlign.center,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'FirstName is Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'FirstName',
                      counterText: "",
                    ),
                    maxLength: 10,
                    controller: firstName,

                    // onSaved: (value) =>
                    //     setState(() => value = value),

                  ),
              ),
                  SizedBox(height: 15,),

                  Container(
                    width: 250,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'LastName',
                        counterText: "",
                      ),
                      controller: lastName,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'LastName is Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: 250,
                      height: 56,

                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)

                      ),

                      child :Text('${contact_no}',  style: TextStyle(fontSize: 20 ),)

                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: 250,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, color: Colors.black ),
                      textAlign: TextAlign.center,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email-Id',
                        counterText: "",
                      ),

                        controller: emailId,
                      validator : (String value) {

                        if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please Enter valid Email Id';
                        }
                        if(value.isEmpty){
                          return 'Email is Required';
                        }
                        return null;
                      }

                    ),
                  ),
                  SizedBox(height: 15,),
                  ButtonTheme(
                    minWidth: 300.0,
                    height: 50.0,
                    child: RaisedButton(
                        child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
                        onPressed: () async {
                          if(!_formKey.currentState.validate()){
                            return;
                          }
                          deviceId = await _getId();
                            //_formKey.currentState.save();
                          MySharedPreferences.instance.setStringValue("first_name", firstName.text);
                          MySharedPreferences.instance.setStringValue("last_name", lastName.text );
                          MySharedPreferences.instance.setStringValue("email", emailId.text);
                          MySharedPreferences.instance.setStringValue(Utils.IS_LOGGED_IN, "8");
                          MySharedPreferences.instance.setStringValue("device_token", "${regId}");
                          MySharedPreferences.instance.setStringValue("device_id", "${deviceId}");


                          await Provider.of<ProviderService>(context, listen: false).getRegisteration({"user_id": userid, "token": token,"device_token": "${regId}","device_id": "$deviceId","first_name": "${firstName.text}", "last_name": "${lastName.text}","email" : "${emailId.text}", "contact_mo": "$contact_no"}).then((value) => Navigate(value.body));

                        }
                    ),
                  )
        ]
        ),
            )
      )
    )
                    )
        ),
      );
  }

  Navigate(registeration response){

    MySharedPreferences.instance.setStringValue("token", "${response.datainfo.token.toString()}");
    MySharedPreferences.instance.setStringValue("user_id", "${response.datainfo.userId.toString()}");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
  }
}