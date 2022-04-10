import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/uploadphoto.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jito_matrimony/EditActivity/Education_edit.dart';
import '../EditClasses/Basic_add.dart';
import '../Edit_Biodata.dart';
import '../homepage.dart';
import 'editPhoto.dart';

class PartnerDetails extends StatefulWidget{

  var Partner, flag;
  PartnerDetails({this.Partner, this.flag});
  @override
  partnerDetail createState() => partnerDetail();
}

class Education {
  final int id;
  final String name;
  final int cat_id;
  final String cat_name;

  Education({
    this.id,
    this.name,
    this.cat_id,
    this.cat_name
  });
}
class Height{
  final int id;
  final String name;
  Height({this.id, this.name});
}



class partnerDetail extends State<PartnerDetails>{

  TextEditingController _aboutme = TextEditingController();
  TextEditingController _aboutpartner = TextEditingController();
  RangeLabels agelabels =RangeLabels('18', "60");
  RangeValues age = RangeValues(18, 60);
  RangeLabels heightlabels =RangeLabels('4', "7");
  RangeValues height = RangeValues(4, 7);
  String agemin;
  String agemax;
  String heightmin = '4ft 0in';
  String heightmax = '7ft 0in';

  String bodydropdownValue;
  String skindropdownValue ;
  String _manglik ;
  String maritaldropdownValue;

  // List<Education> edulist = [ Education(educationId : "1", educationName:'10TH')];
  // List<Education> eduselectlist = [Education(educationId : "0", educationName:'')];
  List<String> educonf = [];
  var _eduitems;
  Education edu;


  var edudropdownValue;
  int count = 0;

  static List<Education> Ages = [];

  SharedPreferences myPrefs;

  String _userid, token, _bioid;

  List<Height> _selectedHeight;

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
            onPressed: () {
              if(widget.flag == "0"){
                Navigator.of(context).popUntil((_) => count++ >= 8);
              }else{
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {
              if(widget.flag == "0") {
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "manglic", _manglik);
                  MySharedPreferences.instance.setStringValue(
                      "about_me", _aboutme.text);
                  MySharedPreferences.instance.setStringValue(
                      "about_partner", _aboutpartner.text);
                  MySharedPreferences.instance.setStringValue(
                      "partner_age_min", agemin);
                  MySharedPreferences.instance.setStringValue(
                      "partner_age_max", agemax);
                  MySharedPreferences.instance.setStringValue(
                      "partner_height_min", heightmin);
                  MySharedPreferences.instance.setStringValue(
                      "partner_height_max", heightmax);
                  MySharedPreferences.instance.setStringValue(
                      "partner_marital_status", maritaldropdownValue);
                  MySharedPreferences.instance.setStringValue(
                      "partner_skin_tone", skindropdownValue);
                  // MySharedPreferences.instance.setStringValue(
                  //     "partner_education", _partneredu);
                  // MySharedPreferences.instance.setStringValue(
                  //     "partner_work_category", _partnerwork);
                  MySharedPreferences.instance.setStringValue(
                      "partner_body_type", bodydropdownValue);
                });
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => Edit_Biodata(flag :"0")));
              }
              else {
                await Provider.of<ProviderService>(context, listen: false)
                    .addPartner({"user_id": _userid,
                  "token": token,
                  "bio_id": _bioid,
                  "about_me": _aboutme.text,
                  "about_partner": _aboutpartner.text,
                  "partner_age_min": agemin,
                  "partner_age_max": agemax,
                  "partner_height_min": heightmin,
                  "partner_height_max": heightmax,
                  "partner_manglic": _manglik,
                  "partner_body_type": bodydropdownValue,
                  "partner_marital_status": maritaldropdownValue,
                  "partner_skin_tone": skindropdownValue,

                }).then((value) => (value.body));

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homepage()));
              }

            },
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes', style: TextStyle(color: Colors.deepPurple),),
          ),

        ],
      ),
    ) ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    if(widget.flag== "1") {
      edudropdownValue = widget.Partner[0].educationTypes;
      _manglik = widget.Partner.partnerNamglic;
      skindropdownValue = widget.Partner.partnerSkintone;
      maritaldropdownValue = widget.Partner.partnerMeritalStatus;
      bodydropdownValue = widget.Partner.partnerBodyType;
      _aboutpartner.text =
      widget.Partner.aboutPartner == null ? "" : widget.Partner.aboutPartner;
      _aboutme.text =
      widget.Partner.aboutMe == null ? "" : widget.Partner.aboutMe;

      initPref();
    }
    //
    // setState(() {
    //   isLoading = true;
    //
    //   if(widget.flag=="1") {
    //     _academic.text = widget.academics;
    //
    //     for (int i = 0; i < (widget.Education_.length); i++) {
    //       eduselectlist.add(Education(
    //           educationId: widget.Education_[i].educationId,
    //           educationName: widget.Education_[i].educationName));
    //     }
    //   }
    //   educall();
    // });
  }

  initPref()
  async {
    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
  }

  // educall() async{
  //   await Provider.of<ProviderService>(context, listen: false).getEducation({}).then((value) => Edulist(value.body));
  // }
  //
  // Edulist(education_list response){
  //
  //   setState(() {
  //     for(int i=1; i<(response.datainfo[0].details.length); i++) {
  //       edulist.add(Education(educationId: response.datainfo[0].details[i].educationId, educationName: response.datainfo[0].details[i].educationName));
  //     }
  //     _eduitems = edulist.map((edu) => MultiSelectItem<Education>(edu, edu.educationName)).toList();
  //     print(edulist);
  //     isLoading = false;
  //   });
  //
  // }

  static List<Height> heights = [
    Height(id: 0 , name: " 4ft 0in " ) ,
    Height(id: 1 , name: " 4ft 1in " ) ,
    Height(id: 2 , name: " 4ft 2in " ) ,
    Height(id: 3 , name: " 4ft 3in " ) ,
    Height(id: 4 , name: " 4ft 4in " ) ,
    Height(id: 5 , name: " 4ft 5in " ) ,
    Height(id: 6 , name: " 4ft 6in " ) ,
    Height(id: 7 , name: " 4ft 7in " ) ,
    Height(id: 8 , name: " 4ft 8in " ) ,
    Height(id: 9 , name: " 4ft 9in " ) ,
    Height(id: 10 , name: " 4ft 10in " ) ,
    Height(id: 11 , name: " 4ft 11in " ) ,
    Height(id: 12 , name: " 5ft 0in " ) ,
    Height(id: 13 , name: " 5ft 1in " ) ,
    Height(id: 14 , name: " 5ft 2in " ) ,
    Height(id: 15 , name: " 5ft 3in " ) ,
    Height(id: 16 , name: " 5ft 4in " ) ,
    Height(id: 17 , name: " 5ft 5in " ) ,
    Height(id: 18 , name: " 5ft 6in " ) ,
    Height(id: 19 , name: " 5ft 7in " ) ,
    Height(id: 20 , name: " 5ft 8in " ) ,
    Height(id: 21 , name: " 5ft 9in " ) ,
    Height(id: 22 , name: " 5ft 10in " ) ,
    Height(id: 23 , name: " 5ft 11in " ) ,
    Height(id: 24 , name: " 6ft 0in " ) ,
    Height(id: 25 , name: " 6ft 1in " ) ,
    Height(id: 26 , name: " 6ft 2in " ) ,
    Height(id: 27 , name: " 6ft 3in " ) ,
    Height(id: 28 , name: " 6ft 4in " ) ,
    Height(id: 29 , name: " 6ft 5in " ) ,
    Height(id: 30 , name: " 6ft 6in " ) ,
    Height(id: 31 , name: " 6ft 7in " ) ,
    Height(id: 32 , name: " 6ft 8in " ) ,
    Height(id: 33 , name: " 6ft 9in " ) ,
    Height(id: 34 , name: " 6ft 10in " ) ,
    Height(id: 35 , name: " 6ft 11in " ) ,
    Height(id: 36 , name: " 7ft 0in ")
  ];

  final _heightitems = heights
      .map((height) => MultiSelectItem<Height>(height, height.name))
      .toList();

  final heightvals = ["4ft 0in","4ft 1in","4ft 2in","4ft 3in","4ft 4in","4ft 5in","4ft 6in","4ft 7in","4ft 8in","4ft 9in","4ft 10in","4ft 11in","5ft 0in","5ft 1in","5ft 2in","5ft 3in","5ft 4in","5ft 5in","5ft 6in","5ft 7in","5ft 8in","5ft 9in","5ft 10in","5ft 11in","6ft 0in","6ft 1in","6ft 2in","6ft 3in","6ft 4in","6ft 5in","6ft 6in","6ft 7in","6ft 8in","6ft 9in","6ft 10in","6ft 11in", "7ft 0in"];


  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
            title: Text('Partner Preferences', style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if(widget.flag == "0") {
                    setState(() {
                      MySharedPreferences.instance.setStringValue(
                          "manglic", _manglik);
                      MySharedPreferences.instance.setStringValue(
                          "about_me", _aboutme.text);
                      MySharedPreferences.instance.setStringValue(
                          "about_partner", _aboutpartner.text);
                      MySharedPreferences.instance.setStringValue(
                          "partner_age_min", agemin);
                      MySharedPreferences.instance.setStringValue(
                          "partner_age_max", agemax);
                      MySharedPreferences.instance.setStringValue(
                          "partner_height_min", heightmin);
                      MySharedPreferences.instance.setStringValue(
                          "partner_height_max", heightmax);
                      MySharedPreferences.instance.setStringValue(
                          "partner_marital_status", maritaldropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "partner_skin_tone", skindropdownValue);
                      // MySharedPreferences.instance.setStringValue(
                      //     "partner_education", _partneredu);
                      // MySharedPreferences.instance.setStringValue(
                      //     "partner_work_category", _partnerwork);
                      MySharedPreferences.instance.setStringValue(
                          "partner_body_type", bodydropdownValue);
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => editPhoto(flag :"0")));
                  }
                  else {
                    await Provider.of<ProviderService>(context, listen: false)
                        .addPartner({"user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "about_me": _aboutme.text,
                      "about_partner": _aboutpartner.text,
                      "partner_age_min": agemin,
                      "partner_age_max": agemax,
                      "partner_height_min": heightmin,
                      "partner_height_max": heightmax,
                      "partner_manglic": _manglik,
                      "partner_body_type": bodydropdownValue,
                      "partner_marital_status": maritaldropdownValue,
                      "partner_skin_tone": skindropdownValue,

                    }).then((value) => (value.body));

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homepage()));
                  }
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
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.96,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  child: Text(' ABOUT ME',
                                            style: TextStyle(fontSize: 15, color: Colors.black),
                                          ),
                                    ),
                                Container(
                                  height: 80,
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width*.96,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: TextFormField(

                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    style: TextStyle(fontSize: 16),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(

                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none
                                    ),
                                    controller: _aboutme,
                                    validator: (String value){
                                      if(value.isEmpty){
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
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
                                  child: Text(' ABOUT PARTNER',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width*.96,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: TextFormField(
                                    maxLines: 5,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(fontSize: 16),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(

                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none
                                    ),
                                    controller: _aboutpartner,
                                    validator: (String value){
                                      if(value.isEmpty){
                                        return '';
                                      }
                                      return null;
                                    },
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
                            child: Text(' SELECT AGE ($agemin yrs to $agemax yrs)',
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          Container(

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: RangeSlider(
                              divisions: 42,
                              activeColor: Colors.red[700],
                              inactiveColor: Colors.red[300],
                              min: 18,
                              max: 60,
                              values: age,
                              labels: agelabels,
                              onChanged: (value){
                                print("START: ${value.start}, End: ${value.end}");
                                setState(() {
                                  age=value;
                                  agemin =value.start.toString();
                                  agemax = value.end.toString();
                                  agelabels =RangeLabels("${agemin}\ yrs", "${agemax}\ yrs");
                                });
                              }
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
                            child: Text(' SELECT HEIGHT ($heightmin  to $heightmax )',
                              style: TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                      Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width*.96,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child:Row(
                            children:[
                              Text("  From: "),
                              Container(
                                  child: DropdownButtonFormField<String>(

                                icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                iconSize: 44,
                                elevation: 16,
                                value: heightmin,
                                hint: Text('Select Height', style: TextStyle(fontSize: 15)),
                                validator: (val){

                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    heightmin = newValue;
                                  });
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
                                      child: Center(
                                    child: Text(val, textAlign: TextAlign.start,),
                                  ));
                                }).toList(),
                              ),
                              ),
                              Text('  To: '),
                              Container(
                                  child: DropdownButton<String>(

                                icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                iconSize: 44,
                                elevation: 16,
                                value: heightmax,
                                hint: Text('Select Height', style: TextStyle(fontSize: 15)),

                                onChanged: (newValue) {
                                  setState(() {
                                    heightmax = newValue;
                                  });
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
                                      child: Center(
                                        child: Text(val, textAlign: TextAlign.start,),
                                      ));
                                }).toList(),
                              ),
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
                                child: Text('   MANGLIK',
                                  style: TextStyle(fontSize: 15, color: Colors.black),),

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
                                            title: const Text('Manglik', style: TextStyle(fontSize: 17),),
                                            leading: Transform.scale(

                                              scale: 1.5,
                                              child: Radio(

                                                value: "manglik",
                                                groupValue: _manglik,
                                                onChanged: (value){
                                                  setState(() {
                                                    _manglik = value;
                                                  });
                                                },
                                              ),
                                            )

                                        ),
                                        ListTile(
                                            visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                            dense: true,
                                            title: const Text('Not Manglik', style: TextStyle(fontSize: 17),),
                                            leading: Transform.scale(

                                              scale: 1.5,
                                              child: Radio(
                                                value: "not manglik",
                                                groupValue: _manglik,
                                                onChanged: (value){
                                                  setState(() {
                                                    _manglik = value;
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
                        height: 35,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .96,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          border: Border.all(color: Colors.grey[400]),
                        ),
                        child: Row(

                                  children:[
                                    InkWell(

                                      // child: Container(
                                      //
                                      //   width: MediaQuery.of(context).size.width*.945,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       border: Border.all(color: Colors.grey)
                                      //
                                      //   ),
                                      //   child: MultiSelectDialogField(
                                      //     initialValue: eduselectlist,
                                      //     items: _eduitems,
                                      //     title: Text(" Education Fields", style: TextStyle(color: Colors.black),),
                                      //     selectedColor: Colors.blueGrey,
                                      //     decoration: BoxDecoration(
                                      //
                                      //     ),
                                      //     buttonIcon: Icon(
                                      //       Icons.arrow_drop_down,
                                      //       color: Colors.deepPurple,
                                      //       size: 50,
                                      //     ),
                                      //     searchable: true,
                                      //     onSelectionChanged: (values){
                                      //       if(eduselectlist.contains(values)){
                                      //         eduselectlist.remove(values);
                                      //       }
                                      //     },
                                      //     onConfirm: ( results) {
                                      //       setState(() {
                                      //         eduselectlist = results; print(results.length);
                                      //         for(int j=0; j<eduselectlist.length;j++){
                                      //           educonf.add(eduselectlist[j].educationId);
                                      //           print("educonf     $educonf");
                                      //         }
                                      //         eduids = educonf.join(',');
                                      //         print(eduids);
                                      //
                                      //       });
                                      //
                                      //     },
                                      //   ),
                                      // ),
                                    ), ]
                              ),),
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
                                    value: null,
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Skin Tone', style: TextStyle(fontSize: 15)),

                                    onChanged: (newValue) {
                                      setState(() {
                                        skindropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['Select', "Very Fair", 'Fair', 'Wheatish', 'Dark']
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
                                    value: null,
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Body Type', style: TextStyle(fontSize: 15)),

                                    onChanged: (newValue) {
                                      setState(() {
                                        bodydropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['Select', 'Slim', "Athletic", 'Average', 'Heavy']
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
                            child: Text(' MARITAL STATUS',
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),),

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
                                    value: null,
                                    icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                                    iconSize: 44,
                                    elevation: 16,
                                    hint: Text('Select Marital Status', style: TextStyle(fontSize: 15)),

                                    onChanged: (newValue) {
                                      setState(() {
                                        maritaldropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['Select', "Single", 'Divorced', 'Widowed']
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

                              // Row(
                              //
                              //     children:[
                              //       SizedBox(width: 12,),
                              //       Container(
                              //
                              //         width: MediaQuery.of(context).size.width*.94,
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             border: Border.all(color: Colors.grey)
                              //
                              //         ),
                              //         child: MultiSelectDialogField(
                              //           items: _heightitems,
                              //           title: Text("Select Heights", style: TextStyle(color: Colors.black),),
                              //           selectedColor: Colors.blueGrey,
                              //           decoration: BoxDecoration(
                              //
                              //           ),
                              //           buttonIcon: Icon(
                              //             Icons.arrow_drop_down,
                              //             color: Colors.deepPurple,
                              //             size: 50,
                              //           ),
                              //           searchable: true,
                              //           buttonText: Text(
                              //             "Select Heights",
                              //             style: TextStyle(
                              //               color: Colors.grey,
                              //               fontSize: 16,
                              //             ),
                              //           ),
                              //           onConfirm: (results) {
                              //             //_selectedAnimals = results;
                              //           },
                              //         ),
                              //       ),]
                              // ),
                        ]
                    )
                )


        )
        )

    );

  }

}