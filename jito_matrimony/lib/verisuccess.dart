import 'package:jito_matrimony/constants.dart';
import 'package:jito_matrimony/otp.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/profileupdate.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class veri extends StatefulWidget{

  // final String phone;
  // veri( {Key key, this.phone}) : super(key : key);
  @override
  veriPage createState() => veriPage();

}

class veriPage extends State<veri>{

  // final String phone;
  // veriPage(this.phone){}
  SharedPreferences myPrefs;


  @override
  void initState() {

    super.initState();
    _initPefrence();
    MySharedPreferences.instance.setStringValue(Utils.IS_LOGGED_IN , "7");
  }

  _initPefrence() async {
    myPrefs = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text('Log-in'),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/login_bg.jpg"),
                  fit: BoxFit.cover,
                )),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.all(30.0),

                    child: Container(
                        width: 180,
                        height: 120,

                        decoration: BoxDecoration(

                          image: DecorationImage(
                            image: AssetImage('Assets/logo.png'),
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Container(
                        width: 200,
                        height: 200,

                        decoration: BoxDecoration(

                          image: DecorationImage(
                            image: AssetImage('Assets/verified.png'),
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(

                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      SizedBox(width: 10,),
                    ],
                  ),
                  Container(
                      child: Row(

                          mainAxisAlignment : MainAxisAlignment.center,
                          children :[

                            Text('Verification Successful', style: TextStyle(fontSize: 30, color: Colors.deepPurple, fontWeight: FontWeight.bold),),

                          ]
                      )
                  ),
                  SizedBox(height:20,),
                  ButtonTheme(
                    minWidth: 300.0,
                    height: 50.0,
                    child: RaisedButton(
                        child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
                        onPressed: () {


                             Navigator.of(context).pushReplacement(MaterialPageRoute(
                                 builder: (context) => ProfileUpdate()));

                          }
                    ),
                  )
                ]
            )
        )
    );

  }

}