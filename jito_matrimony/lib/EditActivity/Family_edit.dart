import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/Partner_edit.dart';
import 'package:jito_matrimony/EditClasses/familyadd.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/homepage.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditClasses/Basic_add.dart';
import 'Contact_edit.dart';

class FamilyDetails extends StatefulWidget{

  var Family, flag;
  FamilyDetails({this.Family, this.flag});

  @override
  FamilyDetail createState() => FamilyDetail();
}


class FamilyDetail extends State<FamilyDetails>{

  SharedPreferences myPrefs;
  String token, _userid, _bioid;
  int count = 0;

  TextEditingController _fathername = TextEditingController();
  TextEditingController _mothername = TextEditingController();
  TextEditingController _officeadd = TextEditingController();
  TextEditingController _fathermob = TextEditingController();
  TextEditingController _officeno = TextEditingController();
  TextEditingController _mothermob = TextEditingController();
  TextEditingController _motherwp = TextEditingController();
  TextEditingController _fatherwp = TextEditingController();
  TextEditingController _occupation = TextEditingController();
  TextEditingController _bro = TextEditingController();
  TextEditingController _bromarr = TextEditingController();
  TextEditingController _sis = TextEditingController();
  TextEditingController _sismarr = TextEditingController();

  final GlobalKey<FormState> _famKey = GlobalKey<FormState>();


  String _familytype;
  String _housetype;
  String _officetype;

  @override
  void initState() {

    super.initState();

    if(widget.flag == "1"){

      _familytype = widget.Family.familyType;
      _housetype = widget.Family.houseType;
      _officetype = widget.Family.officeType;
      _fathermob.text = widget.Family.fatherMobileNo==null? "": widget.Family.fatherMobileNo;
      _fatherwp.text = widget.Family.fatherWhatsapp==null? "": widget.Family.fatherWhatsapp;
      _mothermob.text  = widget.Family.motherMob==null? "": widget.Family.motherMob;
      _officeadd.text = widget.Family.fatherOfficeAddress==null? "": widget.Family.fatherOfficeAddress;
      _officeno.text = widget.Family.fatherOfficeNo==null? "": widget.Family.fatherOfficeNo;
      _fathername.text = widget.Family.fatherName;
      _mothername.text = widget.Family.motherName;
      _occupation.text = widget.Family.fatherOccupation==null? "": widget.Family.fatherOccupation;
      _motherwp.text = widget.Family.motherWhatsapp==null? "": widget.Family.motherWhatsapp;
      _bro.text = widget.Family.totalBrother == null ? "" : widget.Family.totalBrother;
      _sis.text = widget.Family.totalSister == null ? " " : widget.Family.totalSister;
      _sismarr.text = widget.Family.totalMarriedSister == null ? "" : widget.Family.totalMarriedSister;
      _bromarr.text = widget.Family.totalMarriedBrother == null ? "" : widget.Family.totalMarriedBrother;

    initPref();
    }

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
            onPressed: () {
              if(widget.flag == "0"){
                Navigator.of(context).popUntil((_) => count++ >= 10);
              }else{
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {
              if(!_famKey.currentState.validate()){
                return;
              }

              if(widget.flag=="0") {
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "father_name", _fathername.text);
                  MySharedPreferences.instance.setStringValue(
                      "mother_name", _mothername.text);
                  MySharedPreferences.instance.setStringValue(
                      "total_brother", _bro.text);
                  MySharedPreferences.instance.setStringValue(
                      "total_married_brother", _bromarr.text);
                  MySharedPreferences.instance.setStringValue(
                      "total_sister", _sis.text);
                  MySharedPreferences.instance.setStringValue(
                      "total_married_sister", _sismarr.text);
                  MySharedPreferences.instance.setStringValue(
                      "family_type", _familytype);
                  MySharedPreferences.instance.setStringValue(
                      "house_type", _housetype);
                  MySharedPreferences.instance.setStringValue(
                      "father_occupation", _occupation.text);
                  MySharedPreferences.instance.setStringValue(
                      "office_type", _officetype);
                  MySharedPreferences.instance.setStringValue(
                      "father_office_address", _officeadd.text);
                  MySharedPreferences.instance.setStringValue(
                      "father_mobile_no", _fathermob.text);
                  MySharedPreferences.instance.setStringValue(
                      "father_office_no", _officeno.text);
                  MySharedPreferences.instance.setStringValue(
                      "father_whatsapp_no", _fatherwp.text);
                  MySharedPreferences.instance.setStringValue(
                      "mother_mobile_no", _mothermob.text);
                  MySharedPreferences.instance.setStringValue(
                      "mother_whatsapp_no", _motherwp.text);
                  MySharedPreferences.instance.setStringValue(
                      "office_type", _officetype);
                });
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => PartnerDetails(flag:"0")));
              }
              else {
                await Provider.of<ProviderService>(context, listen: false)
                    .addFamily({"user_id": _userid,
                  "token": token,
                  "bio_id": _bioid,
                  "father_name": _fathername.text,
                  "mother_name": _mothername.text,
                  "total_brother": _bro.text,
                  "total_married_brother": _bromarr.text,
                  "total_sister": _sis.text,
                  "total_married_sister": _sismarr.text,
                  "mother_whatsapp": _motherwp.text,
                  "family_type": _familytype,
                  "house_type": _housetype,
                  "father_occupation": _occupation.text,
                  "office_type": _officetype,
                  "father_office_address": _officeadd.text,
                  "father_mobile_no": _fathermob.text,
                  "father_office_no": _officeno.text,
                  "father_whatsapp": _fatherwp.text,
                  "mother_mob": _mothermob.text
                })
                    .then((value) => Familyresp(value.body));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
              }

            },
            child: Text('Yes', style: TextStyle(color: Colors.deepPurple),),
          ),

        ],
      ),
    ) ?? false;
  }

  initPref()
  async {
    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
    print("bioid = $_bioid");
  }

  Familyresp(familyadd resp){
    print("biooiodid $_bioid");
    print(resp.message);
    print("family is here");
    Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
  }

  @override
  Widget build(BuildContext context){

    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
            title: Text('Family Details', style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if(!_famKey.currentState.validate()){
                    return;
                  }

                  if(widget.flag=="0") {
                    setState(() {
                      MySharedPreferences.instance.setStringValue(
                          "father_name", _fathername.text);
                      MySharedPreferences.instance.setStringValue(
                          "mother_name", _mothername.text);
                      MySharedPreferences.instance.setStringValue(
                          "total_brother", _bro.text);
                      MySharedPreferences.instance.setStringValue(
                          "total_married_brother", _bromarr.text);
                      MySharedPreferences.instance.setStringValue(
                          "total_sister", _sis.text);
                      MySharedPreferences.instance.setStringValue(
                          "total_married_sister", _sismarr.text);
                      MySharedPreferences.instance.setStringValue(
                          "family_type", _familytype);
                      MySharedPreferences.instance.setStringValue(
                          "house_type", _housetype);
                      MySharedPreferences.instance.setStringValue(
                          "father_occupation", _occupation.text);
                      MySharedPreferences.instance.setStringValue(
                          "office_type", _officetype);
                      MySharedPreferences.instance.setStringValue(
                          "father_office_address", _officeadd.text);
                      MySharedPreferences.instance.setStringValue(
                          "father_mobile_no", _fathermob.text);
                      MySharedPreferences.instance.setStringValue(
                          "father_office_no", _officeno.text);
                      MySharedPreferences.instance.setStringValue(
                          "father_whatsapp_no", _fatherwp.text);
                      MySharedPreferences.instance.setStringValue(
                          "mother_mobile_no", _mothermob.text);
                      MySharedPreferences.instance.setStringValue(
                          "mother_whatsapp_no", _motherwp.text);
                      MySharedPreferences.instance.setStringValue(
                          "office_type", _officetype);
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PartnerDetails(flag:"0")));
                  }
                  else {
                    await Provider.of<ProviderService>(context, listen: false)
                        .addFamily({"user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "father_name": _fathername.text,
                      "mother_name": _mothername.text,
                      "total_brother": _bro.text,
                      "total_married_brother": _bromarr.text,
                      "total_sister": _sis.text,
                      "total_married_sister": _sismarr.text,
                      "mother_whatsapp": _motherwp.text,
                      "family_type": _familytype,
                      "house_type": _housetype,
                      "father_occupation": _occupation.text,
                      "office_type": _officetype,
                      "father_office_address": _officeadd.text,
                      "father_mobile_no": _fathermob.text,
                      "father_office_no": _officeno.text,
                      "father_whatsapp": _fatherwp.text,
                      "mother_mob": _mothermob.text
                    })
                        .then((value) => Familyresp(value.body));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => homepage()),
                            (route) => false);
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
                child: Form(
                    key: _famKey,
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
                                  child: RichText(
                                    text: TextSpan(
                                        text: '*',
                                        style: TextStyle(color: Colors.red, fontSize: 18),
                                        children:[
                                          TextSpan(
                                            text: "FATHER'S NAME",
                                            style: TextStyle(fontSize: 15, color: Colors.black),
                                          ),]
                                    ),
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
                                   // initialValue: widget.Family.fatherName==null? "": widget.Family.fatherName,
                                    decoration: InputDecoration(

                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none
                                    ),
                                    controller: _fathername,
                                    validator: (String value){
                                      if(value.isEmpty){
                                        return "Father's Name is Required";
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
                            child: RichText(
                              text: TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red, fontSize: 18),
                                  children:[
                                    TextSpan(
                                      text: "   MOTHER'S NAME",
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),]
                              ),
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
                              //initialValue: widget.Family.motherName==null? "": widget.Family.motherName,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _mothername,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Mother's Name is Required";
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
                            child: Text("BROTHER", style: TextStyle(),
                            ),
                          ),
                          Container(

                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 16),
                              //initialValue: widget.Family.totalBrother==null? "": widget.Family.totalBrother,
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  hintText: 'Total No. of Brothers',
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _bro,
                                validator : (String value) {
                                  if (value.isNotEmpty) {
                                    if (int.parse(value) <
                                        int.parse(_bromarr.text)) {
                                      return 'Enter Valid Number';
                                    }
                                  }
                                }
                            ),
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                            alignment: Alignment.bottomLeft,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.bottom,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 16),
                              //initialValue: widget.Family.totalMarriedBrothers==null? "": widget.Family.totalMarriedBrothers,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  hintText: 'Total No. of Married Brothers',

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _bromarr,

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
                            child: Text("SISTER", style: TextStyle(),
                            ),
                          ),
                          Container(

                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.phone,
                              //initialValue: widget.Family.totalSister==null? "": widget.Family.totalSister,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  hintText: 'Total No. of Sisters',
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _sis,
                              validator : (String value) {
                                if (value.isNotEmpty) {
                                  if (int.parse(value) <
                                      int.parse(_sismarr.text)) {
                                    return 'Enter Valid Number';
                                  }
                                }
                              }
                            ),
                          ),
                          Container(
                            height: 40,
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              //initialValue: widget.Family.totalMarriedSister==null? "": widget.Family.totalMarriedSister,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: 'Total No. of Married Sisters',
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _sismarr,
                              validator: (String value){
                                if(value.isNotEmpty){


                                if(int.tryParse(value) > int.tryParse(_sis.text)){
                                  return 'Enter valid number';
                                }}
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
                            child: Text(' FAMILY TYPE',
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
                                          title: const Text('Nuclear', style: TextStyle(fontSize: 17),),
                                          leading: Transform.scale(

                                            scale: 1.5,
                                            child: Radio(

                                              value: "nuclear",
                                              groupValue: _familytype,
                                              onChanged: (value){
                                                setState(() {
                                                  _familytype = value;
                                                });
                                              },
                                            ),
                                          )

                                    ),
                                    ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('Joint', style: TextStyle(fontSize: 17),),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "joint",
                                            groupValue: _familytype,
                                            onChanged: (value){
                                              setState(() {
                                                _familytype = value;
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
                            child: Text(' OFFICE TYPE',
                                      style: TextStyle(fontSize: 15, color: Colors.black),
                                    ),


                          ),
                          Container(
                              height: 170,
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
                                          title: const Text('Own', style: TextStyle(fontSize: 17),),
                                          leading: Transform.scale(

                                            scale: 1.5,
                                            child: Radio(

                                              value: "own",
                                              groupValue: _officetype,
                                              onChanged: (value){
                                                setState(() {
                                                  _officetype = value;
                                                });
                                              },
                                            ),
                                          )
                                    ),
                                    ListTile(
                                      dense: true,
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                          title: const Text('Rented', style: TextStyle(fontSize: 17),),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "rented",
                                            groupValue: _officetype,
                                            onChanged: (value){
                                              setState(() {
                                                _officetype = value;
                                              });
                                            },
                                          ),
                                        )

                              ),
                                    ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                      dense: true,
                                        title: const Text('Partnership', style: TextStyle(fontSize: 17),),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "partnership",
                                            groupValue: _officetype,
                                            onChanged: (value){
                                              setState(() {
                                                _officetype = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),

                                    ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('Job', style: TextStyle(fontSize: 17),),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "job",
                                            groupValue: _officetype,
                                            onChanged: (value){
                                              setState(() {
                                                _officetype = value;
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
                            child: Text("FATHER'S OCCUPATION", style: TextStyle(),
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
                              //initialValue: widget.Family.fatherOccupation==null? "": widget.Family.fatherOccupation,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _occupation,

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
                        child: Text('   HOUSE TYPE',
                              style: TextStyle(fontSize: 15, color: Colors.black),
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
                                      title: const Text('Own', style: TextStyle(fontSize: 17),),
                                      leading: Transform.scale(

                                         scale: 1.5,
                                        child: Radio(

                                          value: "own",
                                          groupValue: _housetype,
                                          onChanged: (value){
                                            setState(() {
                                              _housetype = value;
                                      });
                                    },
                                  ),
                                )
                            ),
                            ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                                dense: true,
                              title: const Text('Rented', style: TextStyle(fontSize: 17),),
                              leading: Transform.scale(

                                scale: 1.5,
                                child: Radio(
                                  value: "rented",
                                  groupValue: _housetype,
                                  onChanged: (value){
                                    setState(() {
                                      _housetype = value;
                                    });
                                  },
                                ),
                              )
                          ),
                          ]
                          )
                      ),
                          SizedBox(height:15,),
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.centerLeft,
                            height:35,
                            width: MediaQuery.of(context).size.width*.96,
                            decoration: BoxDecoration(
                              color: Colors.grey[400] ,
                              border: Border.all(color: Colors.grey[400]),
                            ),
                            child: Text("FATHER'S OFFICE ADDRESS", style: TextStyle(),
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
                              //initialValue: widget.Family.fatherOfficeAddress==null? "": widget.Family.fatherOfficeAddress,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _officeadd,

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
                            child: Text("FATHER'S MOBILE NO", style: TextStyle(),
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
                              keyboardType: TextInputType.phone,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _fathermob,

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
                            child: Text("FATHER'S OFFICE NO", style: TextStyle(),
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
                              //initialValue: widget.Family.fatherOfficeNo==null? "": widget.Family.fatherOfficeNo,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _officeno,

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
                            child: Text("FATHER'S WHATSAPP NO", style: TextStyle(),
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
                            //  initialValue: widget.flag=="0"? "": widget.Family.fatherWhatsapp,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _fatherwp,

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
                            child: Text("MOTHER'S MOBILE NO", style: TextStyle(),
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
                          //    initialValue: widget.flag == "1"?widget.Family.motherMob: " ",
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _mothermob,

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
                            child: Text("MOTHER'S WHATSAPP NO", style: TextStyle(),
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
                              //initialValue: widget.Family.motherWhatsapp==null? "": widget.Family.motherWhatsapp,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _motherwp,

                            ),
                          ),

                        ]
                    )
                )

        )

    ),
    )
    )
    );

  }
}