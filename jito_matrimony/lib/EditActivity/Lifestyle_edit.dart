import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/Contact_edit.dart';
import 'package:jito_matrimony/EditActivity/Professional_edit.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditClasses/Basic_add.dart';
import '../homepage.dart';

class LifeStyleDetails extends StatefulWidget{

  var Lifestyle;
  String flag;
  LifeStyleDetails({this.Lifestyle, this.flag});
  @override
  LifeStyleDetail createState() => LifeStyleDetail();
}


class LifeStyleDetail extends State<LifeStyleDetails>{

  TextEditingController _disease = TextEditingController();
  TextEditingController _facebook = TextEditingController();
  TextEditingController _instagram = TextEditingController();
  TextEditingController _linkedin = TextEditingController();

  String _spects = "No";

  String blooddropdownValue ;
  String dietdropdownValue ;
  String skindropdownValue;
  String bodydropdownValue;
  String heightdropdownValue;
  String weightdropdownValue;
  int count=1;

  String token, _bioid, _userid;

  final GlobalKey<FormState> _lifekey = GlobalKey<FormState>();

  SharedPreferences myPrefs;

  @override
  void initState() {

    super.initState();

    if(widget.flag=="1"){
    setState(() {


    _disease.text = widget.Lifestyle.disease == null? "": widget.Lifestyle.disease;
    _facebook.text = widget.Lifestyle.socialFacebook == null? "": widget.Lifestyle.socialFacebook;
    _instagram.text = widget.Lifestyle.socialInstagram == null? "": widget.Lifestyle.socialInstagram;
    _linkedin.text = widget.Lifestyle.socialLinkedin == null? "": widget.Lifestyle.socialLinkedin;

    blooddropdownValue = widget.Lifestyle.bloodGroup == null ?"Select": widget.Lifestyle.bloodGroup;
    dietdropdownValue =  widget.Lifestyle.dietType == null ?"Select": widget.Lifestyle.dietType;
    skindropdownValue = widget.Lifestyle.skinTone == null ?"Select": widget.Lifestyle.skinTone;
    bodydropdownValue =  widget.Lifestyle.bodyType == "" ?"Select": widget.Lifestyle.bodyType;
    print("bodydropdown $bodydropdownValue");
    print("life ${widget.Lifestyle.bodyType}");
    weightdropdownValue = widget.Lifestyle.weight;
    heightdropdownValue = widget.Lifestyle.height;
    _spects = widget.Lifestyle.spects == null? "": widget.Lifestyle.spects;

    print("drop down valuess  =$_spects=");

    });}

    initPref();
  }

  initPref()
  async {
    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
    print("bioid = $_bioid");
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Save Changes?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel', style: TextStyle(color: Colors.deepPurple),),
          ),
          SizedBox(
            width: 50,
          ),
          FlatButton(
            onPressed: () => {
              // Navigator.pop(context),
              // Navigator.pop(context),
              if(widget.flag == "0"){
                Navigator.of(context).popUntil((_) => count++ >= 4),
              }else{
                Navigator.pop(context),
                Navigator.pop(context),
              }
            },

            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {
              if (!_lifekey.currentState.validate()) {
                return;
              }
              if(widget.flag == "0"){
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "height", heightdropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "weight", weightdropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "blood_group", blooddropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "spects",_spects);
                  MySharedPreferences.instance.setStringValue(
                      "skin",skindropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "body", bodydropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "diet", dietdropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "disease", _disease.text);
                  MySharedPreferences.instance.setStringValue(
                      "facebook", _facebook.text);
                  MySharedPreferences.instance.setStringValue(
                      "instagram", _instagram.text);
                  MySharedPreferences.instance.setStringValue(
                      "linkedin", _linkedin.text);

                });
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetails(flag: "0",)));
              }
              else {
                await Provider.of<ProviderService>(context, listen: false)
                    .addLifestyle({"user_id": _userid,
                  "token": token,
                  "bio_id": _bioid,
                  "height": heightdropdownValue,
                  "weight": weightdropdownValue,
                  "blood_group": blooddropdownValue,
                  "spects": _spects,
                  "skin_tone": skindropdownValue,
                  "body_type": bodydropdownValue,
                  "diet": dietdropdownValue,
                  "facebook_profile_url": _facebook.text,
                  "instagram_profile_url": _instagram.text,
                  "linkedin_profile_url": _linkedin.text,
                  "disease": _disease.text,
                  "social_facebook": _facebook.text,
                  "social_instagram": _instagram.text,
                  "social_linkedin": _linkedin.text
                })
                    .then((value) => (value.body));

                Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
              }

            },
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes', style: TextStyle(color: Colors.deepPurple),),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context){

    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
            title: Text('LifeStyle Details', style: TextStyle(color: Colors.white,fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if (!_lifekey.currentState.validate()) {
                    return;
                  }
                  else{

                  }

                  if(widget.flag == "0"){
                    setState(() {
                      MySharedPreferences.instance.setStringValue(
                          "height", heightdropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "weight", weightdropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "blood_group", blooddropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "spects",_spects);
                      MySharedPreferences.instance.setStringValue(
                          "skin",skindropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "body", bodydropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "diet", dietdropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "disease", _disease.text);
                      MySharedPreferences.instance.setStringValue(
                          "facebook", _facebook.text);
                      MySharedPreferences.instance.setStringValue(
                          "instagram", _instagram.text);
                      MySharedPreferences.instance.setStringValue(
                          "linkedin", _linkedin.text);

                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetails(flag: "0",)));
                  }
                  else {
                    await Provider.of<ProviderService>(context, listen: false)
                        .addLifestyle({"user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "height": heightdropdownValue,
                      "weight": weightdropdownValue,
                      "blood_group": blooddropdownValue,
                      "spects": _spects,
                      "skin_tone": skindropdownValue,
                      "body_type": bodydropdownValue,
                      "diet": dietdropdownValue,
                      "facebook_profile_url": _facebook.text,
                      "instagram_profile_url": _instagram.text,
                      "linkedin_profile_url": _linkedin.text,
                      "disease": _disease.text,
                      "social_facebook": _facebook.text,
                      "social_instagram": _instagram.text,
                      "social_linkedin": _linkedin.text
                    })
                        .then((value) => (value.body));

                    Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
                  }

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(thickness: 1.0, color: Colors.white,),
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 5,),
                    Text('SAVE  ', style: TextStyle(color: Colors.white,fontSize: 15))
                  ],
                ),
              ),

            ]
        ),
        body: SingleChildScrollView(
            child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Form(
                    key: _lifekey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [


                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: RichText(
                              text: TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red,fontSize: 18),
                                  children:[
                                    TextSpan(
                                      text: '   HEIGHT',
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),]
                              ),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(

                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width*.948,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),

                                  child: IgnorePointer(

                                    ignoring: widget.flag == "0" ? false: true,

                                    child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                    ),
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    value: heightdropdownValue == "" ? 'Select': heightdropdownValue,
                                    hint: Text('Select Height', style: TextStyle(fontSize: 15)),

                                    onChanged: (newValue) {
                                      setState(() {
                                        heightdropdownValue = newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Height is required';
                                      }
                                    },
                                    items: <String>["4ft 0in" ,
                                      "4ft 1in" ,
                                      "4ft 2in" ,
                                      "4ft 3in" ,
                                      "4ft 4in" ,
                                      "4ft 5in" ,
                                      "4ft 6in" ,
                                      "4ft 7in" ,
                                      "4ft 8in" ,
                                      "4ft 9in" ,
                                      "4ft 10in" ,
                                      "4ft 11in" ,
                                      "5ft 0in" ,
                                      "5ft 1in" ,
                                      "5ft 2in" ,
                                      "5ft 3in" ,
                                      "5ft 4in" ,
                                      "5ft 5in" ,
                                      "5ft 6in" ,
                                      "5ft 7in" ,
                                      "5ft 8in" ,
                                      "5ft 9in" ,
                                      "5ft 10in" ,
                                      "5ft 11in" ,
                                      "6ft 0in" ,
                                      "6ft 1in" ,
                                      "6ft 2in" ,
                                      "6ft 3in" ,
                                      "6ft 4in" ,
                                      "6ft 5in" ,
                                      "6ft 6in" ,
                                      "6ft 7in" ,
                                      "6ft 8in" ,
                                      "6ft 9in" ,
                                      "6ft 10in" ,
                                      "6ft 11in" ,
                                      "7ft 0in"
                                    ]
                                        .map<DropdownMenuItem<String>>((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, textAlign: TextAlign.start,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                )
                              ]
                          ),

                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: RichText(
                              text: TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red,fontSize: 18),
                                  children:[
                                    TextSpan(
                                      text: '   WEIGHT',
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),]
                              ),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(

                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width*.948,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),

                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                    ),
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Weight', style: TextStyle(fontSize: 15)),
                                      value: weightdropdownValue == "" ? 'Select': weightdropdownValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        weightdropdownValue = newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Weight is required';
                                      }
                                    },
                                    items: <String>["35 Kgs",
                                      "36 Kgs",
                                      "37 Kgs",
                                      "38 Kgs",
                                      "39 Kgs",
                                      "40 Kgs",
                                      "41 Kgs",
                                      "42 Kgs",
                                      "43 Kgs",
                                      "44 Kgs",
                                      "45 Kgs",
                                      "46 Kgs",
                                      "47 Kgs",
                                      "48 Kgs",
                                      "49 Kgs",
                                      "50 Kgs",
                                      "51 Kgs",
                                      "52 Kgs",
                                      "53 Kgs",
                                      "54 Kgs",
                                      "55 Kgs",
                                      "56 Kgs",
                                      "57 Kgs",
                                      "58 Kgs",
                                      "59 Kgs",
                                      "60 Kgs",
                                      "61 Kgs",
                                      "62 Kgs",
                                      "63 Kgs",
                                      "64 Kgs",
                                      "65 Kgs",
                                      "66 Kgs",
                                      "67 Kgs",
                                      "68 Kgs",
                                      "69 Kgs",
                                      "70 Kgs",
                                      "71 Kgs",
                                      "72 Kgs",
                                      "73 Kgs",
                                      "74 Kgs",
                                      "75 Kgs",
                                      "76 Kgs",
                                      "77 Kgs",
                                      "78 Kgs",
                                      "79 Kgs",
                                      "80 Kgs",
                                      "81 Kgs",
                                      "82 Kgs",
                                      "83 Kgs",
                                      "84 Kgs",
                                      "85 Kgs",
                                      "86 Kgs",
                                      "87 Kgs",
                                      "88 Kgs",
                                      "89 Kgs",
                                      "90 Kgs",
                                      "91 Kgs",
                                      "92 Kgs",
                                      "93 Kgs",
                                      "94 Kgs",
                                      "95 Kgs",
                                      "96 Kgs",
                                      "97 Kgs",
                                      "98 Kgs",
                                      "99 Kgs",
                                      "100 Kgs",
                                      "101 Kgs",
                                      "102 Kgs",
                                      "103 Kgs",
                                      "104 Kgs",
                                      "105 Kgs",
                                      "106 Kgs",
                                      "107 Kgs",
                                      "108 Kgs",
                                      "109 Kgs",
                                      "110 Kgs",
                                      "111 Kgs",
                                      "112 Kgs",
                                      "113 Kgs",
                                      "114 Kgs",
                                      "115 Kgs",
                                      "116 Kgs",
                                      "117 Kgs",
                                      "118 Kgs",
                                      "119 Kgs",
                                      "120 Kgs",
                                      "121 Kgs",
                                      "122 Kgs",
                                      "123 Kgs",
                                      "124 Kgs",
                                      "125 Kgs",
                                      "126 Kgs",
                                      "127 Kgs",
                                      "128 Kgs",
                                      "129 Kgs",
                                      "130 Kgs",
                                      "131 Kgs",
                                      "132 Kgs",
                                      "133 Kgs",
                                      "134 Kgs",
                                      "135 Kgs",
                                      "136 Kgs",
                                      "137 Kgs",
                                      "138 Kgs",
                                      "139 Kgs",
                                      "140 Kgs",
                                      "141 Kgs",
                                      "142 Kgs",
                                      "143 Kgs",
                                      "144 Kgs",
                                      "145 Kgs",
                                      "146 Kgs",
                                      "147 Kgs",
                                      "148 Kgs",
                                      "149 Kgs",
                                      "150 Kgs",
                                    ]
                                        .map<DropdownMenuItem<String>>((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, textAlign: TextAlign.start,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text('   BLODD GROUP',
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(
                                  height: 45,
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width*.948,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),

                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                    ),
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Blood Group', style: TextStyle(fontSize: 15)),
                                      value: blooddropdownValue == "" ? 'Select': blooddropdownValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        blooddropdownValue = newValue;
                                      });
                                    },
                                    items: <String>["A+", 'A-', 'B+', 'B-', 'O+', 'O-','AB+', 'AB-']
                                        .map<DropdownMenuItem<String>>((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, textAlign: TextAlign.start,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 40,),
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: RichText(
                              text: TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red,fontSize: 18),
                                  children:[
                                    TextSpan(
                                      text: '   SPECTS',
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),]
                              ),
                            ),
                           ),
                          Container(
                              height: 90,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400])
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  <Widget> [

                                    ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('Yes', style: TextStyle(fontSize: 17),),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(

                                            value: "Yes",
                                            groupValue: _spects,
                                            onChanged: (value){
                                              setState(() {
                                                _spects = value;
                                              });
                                            },
                                          ),
                                        )

                                    ),
                                    ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('No', style: TextStyle(fontSize: 17),),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "No",
                                            groupValue: _spects,
                                            onChanged: (value){
                                              setState(() {
                                                _spects = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                  ]
                              )
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text('   SKIN TONE',
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(
                                  height: 45,
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width*.948,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),

                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                    ),
                                    value: skindropdownValue == "" ? 'Select': skindropdownValue,
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Skin Tone', style: TextStyle(fontSize: 15)),

                                    onChanged: (newValue) {
                                      setState(() {
                                        skindropdownValue = newValue;
                                      });
                                    },
                                    items: <String>["Very Fair", 'Fair', 'Wheatish', 'Dark']
                                        .map<DropdownMenuItem<String>>((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, textAlign: TextAlign.start,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]
                          ),

                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text('   BODY TYPE',
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(
                                  height: 45,
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width*.948,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),

                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                    ),

                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Body Type', style: TextStyle(fontSize: 15)),
                                      value:bodydropdownValue ,
                                    onChanged: (newValue) {
                                      setState(() {
                                        bodydropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['Select','Slim', "Athletic", 'Average', 'Heavy']
                                        .map<DropdownMenuItem<String>>((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, textAlign: TextAlign.start,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]
                          ),

                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text('   DIET',
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Container(
                                  height: 45,
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width*.948,
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                  ),

                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                    ),

                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                      value: "Vegeterian",
                                    hint: Text('Select Diet', style: TextStyle(fontSize: 15)),

                                    onChanged: (newValue) {
                                      setState(() {
                                        dietdropdownValue = newValue;
                                      });
                                    },
                                    items: <String>["Jain", 'Vegeterian']
                                        .map<DropdownMenuItem<String>>((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val, textAlign: TextAlign.start,),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text(' PERMENENT DISEASE', style: TextStyle(),
                            ),
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              textCapitalization: TextCapitalization.characters,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                 focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _disease,
                            ),
                          ),

                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                              child: Text(' FACEBOOK PROFILE URL', style: TextStyle(),
                            ),
                          ),
                          Container(

                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width*.96,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(fontSize: 16),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    hintText: 'Facebook Profile Url',
                                   focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none
                                ),
                                controller: _facebook,

                              )
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text(' INSTAGRAM PROFILE URL', style: TextStyle(),
                            ),
                          ),
                          Container(

                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width*.96,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(fontSize: 16),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    hintText: 'Instagram Profile Url',
                                   focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none
                                ),
                                controller: _instagram,

                              )
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,

                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text(' LINKEDIN PROFILE URL', style: TextStyle(),
                            ),
                          ),
                          Container(
                              height: 40,
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                              alignment: Alignment.topCenter,
                              width: MediaQuery.of(context).size.width*.96,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(fontSize: 16),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    hintText: 'Linkedin Profile Url',
                                   focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none
                                ),
                                controller: _linkedin,

                              )
                          ),
                          SizedBox(height: 20,),

                        ]
                    )
                    ),
                )
            )
        )
    )
    );

  }

}