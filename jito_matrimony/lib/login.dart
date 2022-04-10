import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jito_matrimony/constants.dart';
import 'package:jito_matrimony/logut.dart';
import 'package:jito_matrimony/otp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jito_matrimony/service/notificationService.dart';
import 'package:overlay_support/overlay_support.dart' as noti;
import 'package:provider/provider.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'MenuItems/WhyRegister.dart';
import 'MenuItems/_register.dart';
import 'ProviderService.dart';
import 'package:jito_matrimony/termscondition.dart';
import 'package:jito_matrimony/TermCondition.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;

class Login extends StatefulWidget{

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<Login>{


  final List<String> items = ['+91', 'other'];
  String _chosenValue = '+91';
  bool boolValue =false;
  TextEditingController _controller = TextEditingController();
  String str_mob_mail="Enter Mobile Number";
  String _code="+91";
  var textInput = TextInputType.phone;
  bool isInternetOn = true;
  bool _connbool;
  String _phonevalue;
  FToast fToast;
  bool isOffline = false;
  String toasttext;
  MySharedPreferences pref;
  String userid, token;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    MySharedPreferences.instance.setStringValue(Utils.IS_LOGGED_IN, "");
  }

  @override
  Widget build(BuildContext context) {
    return noti.OverlaySupport.global(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Log-in', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/login_bg.jpg"),
                  fit: BoxFit.cover,
                ),),

              child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB( 30.0, 30.0, 30.0, 30),

                      child: Container(
                          width: 150,
                          height: 80,

                          decoration: BoxDecoration(

                            image: DecorationImage(

                              image: new AssetImage("Assets/logo.png"),
                              fit: BoxFit.fill,


                            ),
                          )
                      ),
                    ),
                    Container(width: 100,
                        height: 50,
                        child: Text(' Log-in', style: TextStyle(fontSize: 25, color: Colors.deepPurple[600], fontWeight: FontWeight.bold),)),
                    Row(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        SizedBox(height: 50,),

                        Container(
                          width: 85,
                          height: 59,

                          padding: EdgeInsets.only(left: 10),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.5, style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          child:DropdownButton<String>(



                            focusColor:Colors.white,
                            value: _chosenValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor:Colors.black,

                            underline: Container(
                              height: 3,
                            ),
                            items: <String>[
                              '+91',
                              'other'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style:TextStyle(color:Colors.black, fontSize: 20),),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              setState(() {
                                _chosenValue = value;
                                phoneMail(_chosenValue);
                              });
                            },
                          ),
                        ),

                        SizedBox(width: 10,),
                        Container(
                            color: Colors.white,
                            width: 250,
                            child: TextFormField(

                              keyboardType: textInput,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: str_mob_mail,
                                counterText: "",
                              ),
                              maxLength: 10,
                              controller: _controller,

                              onChanged : (value){
                                setState(() {
                                  _phonevalue = _controller.text;
                                });

                              }

                            ),


                        )
                      ],
                    ),
                    Container(
                        child: Row(

                            mainAxisAlignment : MainAxisAlignment.start,
                            children :[
                              SizedBox(width: 20,),

                              Checkbox(
                                value: boolValue,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.boolValue= value;
                                  });
                                },
                              ),

                              GestureDetector(
                                onTap: () async {
                                await Provider.of<ProviderService>(context, listen: false).getterms({}).then((value) => goconditions(value.body));
                              },
                                child: Text('Terms & Conditions', style: TextStyle(fontSize: 20, color: Colors.deepPurple, decoration: TextDecoration.underline),
                              
                    )
                    ,)

                            ]
                        )
                    ),
                    SizedBox(height:10,),
                    ButtonTheme(
                      minWidth: 333.0,
                      height: 50.0,
                      child: RaisedButton(
                          child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
                          onPressed: () async {
                            // noti.showSimpleNotification(
                            //   Text("Subscribe to FilledStacks"),
                            //   background: Colors.purple,
                            // );

                            if(boolValue == true  ) {


                              _connbool = await GetConnect();


                              if(_phonevalue.isEmpty){

                                _showToast(str_mob_mail);

                              }
                              else if(!_connbool)
                              {
                                //await _showNotification();
                              }

                                else{

                                await Provider.of<ProviderService>(context, listen: false).getResource({"phone_no":"${_phonevalue}","code":"+91","type":"1"}).then((value) => verifyOtp(value.body));
                                // pref.setStringValue("phoneNo", "${_controller.text}");

                              Fluttertoast.showToast(
                                  msg: "OTP Sent Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 56.0
                              );
                              }

                            }
                            else {
                                    _showToast('Select Terms and Conditions');
                            }

                          }
                      ),
                    ),
                    SizedBox(height:80,),
                    Container(
                        child: InkWell(
                          onTap: () async {
                          //  await Provider.of<ProviderService>(context, listen: false).getRegister({}).then((value) => Register(value.body));
                          },
                          child: Text('Why Register?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple, decoration: TextDecoration.underline),),
                        )
                    ),
                    SizedBox(height:20,),
                    InkWell(
                        onTap:() async{

                          await launch('tel:7698403403');
                        },
                      child: Text('Technical Support 7698403403', style: TextStyle(color: Colors.deepPurple, fontSize: 20),),),
                    SizedBox(

                      height: 250,
                    )
                  ]
              )
          ),
        )
      ),
    );
  }


  Future<bool> GetConnect() async{

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('helloooooooooooooooooooooooooo');
      return false;
    } else {
      print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
      return true;
    }
  }

  phoneMail(_code){

    if(_code == "+91"){

      setState(() {

        str_mob_mail = "Enter Mobile Number";
        textInput = TextInputType.phone;
      });
    }
    else{
      setState(() {
        str_mob_mail = "Enter EmailId";
        textInput = TextInputType.text;
      });
    }
  }

  verifyOtp(Logut response) {

    var d = response.datainfo[0].otp.toString();
    token = response.datainfo[0].token.toString();
    userid = response.datainfo[0].userId.toString();
    print('dddddddddd' + userid );
    print('dddddddddd' + token );

    setState(() {
      MySharedPreferences.instance.setStringValue("contact_mo", '$_phonevalue' );
      MySharedPreferences.instance.setStringValue(Verify.token, '$token');
      MySharedPreferences.instance.setStringValue(UserID.user_id, userid );
      MySharedPreferences.instance.setStringValue("first_name", response.datainfo[0].firstName);
      MySharedPreferences.instance.setStringValue("last_name", response.datainfo[0].lastName );
      MySharedPreferences.instance.setStringValue("email", response.datainfo[0].email);

    });


    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OTPScreen(otpCode : d, phoneno: _phonevalue,)));
  }


  _showToast(String text) {

    Widget toast = Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline),
          SizedBox(
            width: 12.0,
          ),
          Text("Please $text"),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );

  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  goconditions(termscondition response){
    var res = response.datainfo.details.toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => TermCondition(htmlCont: res.toString())));
  }
  // Register(register response){
  //   var res = response.datainfo.details.toString();
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => WhyRegister(htmlCont: res.toString())));
  // }
  }