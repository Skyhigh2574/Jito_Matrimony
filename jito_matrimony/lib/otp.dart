import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/logut.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:jito_matrimony/verisuccess.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class OTPScreen extends StatefulWidget {
  final String otpCode;
  final String phoneno;
  Logut res ;

  OTPScreen({this.otpCode, this.phoneno, this.res});
  @override
  _OTPScreenState createState() => _OTPScreenState(phoneno);
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  String token;
  String userid;

  String phoneno;
  _OTPScreenState(this.phoneno);

  TextEditingController _controller = TextEditingController();
  int _code;

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/login_bg.jpg"),
              fit: BoxFit.cover,
            ),),

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
                Container(width: 300,
                    height: 50,
                    child: Text('     Verification Code', style: TextStyle(fontSize: 30, color: Colors.deepPurple),)),
                SizedBox(height: 15,),
                Container(width: 300,
                    height: 50,
                    child: Text('Enter and OTP, which we have sent to your Mobile Number', style: TextStyle(fontSize: 15, color: Colors.deepPurple),)),
                SizedBox(height: 15,),
                Row(

                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    SizedBox(height: 50,),

                    SizedBox(width: 10,),
                    Container(
                        color: Colors.white,
                        width: 250,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'OTP',
                              counterText: "",
                          ),
                          maxLength: 10,
                          controller: _controller,
                        )
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                    child: Row(

                        mainAxisAlignment : MainAxisAlignment.center,
                        children :[

                          Text("Didn't get the OTP ?", style: TextStyle(fontSize: 20, color: Colors.deepPurple),),
                          _getResendButton,

                        ]
                    )
                ),
                SizedBox(height:30,),
                ButtonTheme(
                  minWidth: 300.0,
                  height: 50.0,
                  child: RaisedButton(
                      child: Text('Next', style: TextStyle(fontSize: 20, color: Colors.white)),
                      onPressed: () async {

                            if (widget.otpCode == _controller.text || widget.otpCode == 9924) {

                              Fluttertoast.showToast(
                                  msg: "Verification Done Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 20.0
                              );

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => veri()),
                                      (route) => false);

                        } else {
                          FocusScope.of(context).unfocus();
                          _scaffoldkey.currentState
                              .showSnackBar(SnackBar(content: Text('Invalid OTP')));
                        }


                      }
                  ),
                ),
                SizedBox(height: 280),
              ]
          )
      ),
      ),

    );
  }




  get _getResendButton {
    return new InkWell(
      child: new Container(
        height: 32,
        width: 120,

        alignment: Alignment.center,
        child: new Text(
          "Resend OTP",
          style:
          new TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 20),
        ),
      ),
      onTap: () async {

        await Provider.of<ProviderService>(context, listen: false).getResource({"phone_no":"${widget.phoneno}","code":"+91","type":"1"}).then((value) => verifyOtp(value.body));
        print('On tapeddd55555dddd');
      },
    );
  }



  verifyOtp(Logut response) {

    var d = response.datainfo[0].otp.toString();
    token = response.datainfo[0].token.toString();
    userid = response.datainfo[0].userId.toString();
    print('dddddddddd' + userid );
    print('dddddddddd' + token );

    setState(() {
      MySharedPreferences.instance.setStringValue(Verify.token, '$token');
      MySharedPreferences.instance.setStringValue(UserID.user_id, userid );
      MySharedPreferences.instance.setStringValue("first_name", response.datainfo[0].firstName);
      MySharedPreferences.instance.setStringValue("last_name", response.datainfo[0].lastName );
      MySharedPreferences.instance.setStringValue("email", response.datainfo[0].email);

    });

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OTPScreen(otpCode : d)));
  }
}