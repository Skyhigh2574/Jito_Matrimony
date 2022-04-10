import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jito_matrimony/profileupdate.dart';
import 'package:jito_matrimony/service/notificationService.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:jito_matrimony/homepage.dart';

import 'constants.dart';
import 'utils/MySharedPreferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => ProviderService.create(),
        dispose: (_, ProviderService service) => service.client.dispose(),

        child: ScreenUtilInit(
            designSize: Size(360, 690),
            builder: () =>  MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
                home: Builder(
                  builder: (context) => new MyHomePage(),
                ),

                
            )
        )
    );
  }


}


class MyHomePage extends StatefulWidget {


   MyHomePage({Key key}) : super(key: key);



  @override
  splashscreen createState() => splashscreen();
}

class splashscreen extends State<MyHomePage> with SingleTickerProviderStateMixin{

  Future<FirebaseApp> _initialization;
  SharedPreferences  myPrefs;
  String is_logged_in = "";
  int _counter = 0 ,alternator = 0;
  String _image =  'assets/images/splash_thirpur_screen.png';
  Timer timee;



  @override
  void initState() {
   // _initialization = Firebase.initializeApp();
    super.initState();

    _initPreference();


    timer = PausableTimer(Duration(seconds: 4), () => Navigate());

    timer.start();


  }


  _initPreference() async{
    myPrefs = await SharedPreferences.getInstance();
    is_logged_in    = MySharedPreferences.instance.getStringValue(Utils.IS_LOGGED_IN , myPrefs);
  }


  Navigate(){

    if(is_logged_in == "7") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ProfileUpdate()));
    }
    else if(is_logged_in == "8"){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => homepage()));
    }
    else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    }
  }

  PausableTimer timer;
  bool _isVisible = false;


  @override
  Widget build(BuildContext context) {

    // timer = PausableTimer(Duration(seconds: 4), () => Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (BuildContext context) => Login())));

    timer.start();


    return  GestureDetector(
        onTap: (){
            pauseTimer();
            buildWid();
            timer.cancel();
        },
        child: Scaffold(

        body:buildWid(),
        )
    );
  }

  pauseTimer(){

    setState(() {
      timer.pause();
      _isVisible = true;
    });
  }

  Widget buildWid(){

    return Container(

    child: Stack(
    children: [

      Container(
        height: MediaQuery.of(context).size.height*.9,
        width: MediaQuery.of(context).size.width,
        child: PhotoView(
          imageProvider: AssetImage("Assets/splash.jpeg"),
          backgroundDecoration: BoxDecoration(color: Colors.white),
          //: MediaQuery.of(context).size,
          basePosition: Alignment.bottomCenter,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.8,
        ),
      ),

          Positioned(
            right: 10.0,
            top: 40.0,
            child:  Visibility (
              visible: _isVisible,
              child: GestureDetector(
                onTap: (){
                  Navigate();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close, color: Colors.white),
            ),
          ),
        ),
            ),
        )
      ]
    )
    );
  }

}

