import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:jito_matrimony/homepage.dart';
import 'package:jito_matrimony/otp.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileView extends StatefulWidget {

  final String phone;
  ProfileView({this.phone});

  @override
  Profile createState() => Profile();
}

class Profile extends State<ProfileView>{


  SharedPreferences prefs;
  String first_name;
  String last_name;
  String _phone;
  String _email;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initpref();

    // final User user = auth.currentUser;


  }

  initpref() async{
     prefs = await SharedPreferences.getInstance();

     setState(() {

       first_name = MySharedPreferences.instance.getStringValue("first_name", prefs);
       last_name = MySharedPreferences.instance.getStringValue("last_name", prefs);
       _phone = MySharedPreferences.instance.getStringValue("contact_mo", prefs);
       _email = MySharedPreferences.instance.getStringValue("email", prefs);
     });


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('View Profile', style: TextStyle(color: Colors.white)),
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
                                  child: Text('View Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color:Colors.deepPurple),)),

                              Container(


                                    width: 250,
                                    height: 56,

                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey)

                                    ),

                                    child :Text(first_name,  style: TextStyle(fontSize: 20 ),)
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

                                  child :Text(last_name,  style: TextStyle(fontSize: 20 ),)
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

                                  child :Text(_phone,  style: TextStyle(fontSize: 20 ),)

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

                                  child :Text(_email,  style: TextStyle(fontSize: 20 ),)
                              ),
                              SizedBox(height: 15,),
                            ]
                        ),
                      )
                  )
              )
          )
      ),
    );
  }
}