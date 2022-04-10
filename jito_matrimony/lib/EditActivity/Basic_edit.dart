import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jito_matrimony/EditActivity/Lifestyle_edit.dart';
import 'package:jito_matrimony/Edit_Biodata.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditClasses/Basic_add.dart';
import '../homepage.dart';

class BasicDetails extends StatefulWidget{

  var Basic;
  String flag;
  BasicDetails({this.Basic, this.flag});
  @override
  basicDetail createState() => basicDetail();
}


class basicDetail extends State<BasicDetails>{

  TextEditingController _name = TextEditingController();
  TextEditingController _birthplace = TextEditingController();
  TextEditingController _nativeplace = TextEditingController();
  TextEditingController _sangh = TextEditingController();
  TextEditingController _gnyati = TextEditingController();
  String _picked, _userid, token, _bioid;
  DateTime selectedDate = DateTime.now();
  String _gender = "Male";
  String _disability = "No";
  TextEditingController _disabilityes = TextEditingController();
  String date=' ';

  String tonguedropdownValue ;
  String jaindropdownValue ;
  String maritaldropdownValue;
  String activitydropdownValue;

  final GlobalKey<FormState> _basicKey = GlobalKey<FormState>();

  SharedPreferences myPrefs;

  void initState(){
    super.initState();


    if(widget.flag == "1") {
      setState(() {
        _name.text = widget.Basic.name == null ? "" : widget.Basic.name;
        _birthplace.text =
        widget.Basic.placeOfBirth == null ? "" : widget.Basic.placeOfBirth;
        _nativeplace.text =
        widget.Basic.nativePlace == null ? "" : widget.Basic.nativePlace;
        _sangh.text = widget.Basic.sangh == null ? "" : widget.Basic.sangh;
        _gnyati.text = widget.Basic.gnyati == null ? "" : widget.Basic.gnyati;
        _gender = widget.Basic.gender == null ? "" : widget.Basic.gender;

        tonguedropdownValue = widget.Basic.motherToungue == null ? "" : widget.Basic.motherToungue;
        jaindropdownValue = widget.Basic.jainSampradaya;
        maritaldropdownValue = widget.Basic.maritalStatus;
        activitydropdownValue = widget.Basic.currentActivity;

        _picked = widget.Basic.timeOfBirth;
        date = widget.Basic.dateOfBirth;
        _disability = widget.Basic.physicalDisability;

        _disabilityes.text =
        widget.Basic.physicalDisabilityYes == null ? "" : widget.Basic
            .physicalDisabilityYes;
      });
    }
    initPref();

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
              Navigator.pop(context),
              Navigator.pop(context),
            },

            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {

            if (!_basicKey.currentState.validate()) {
              Navigator.pop(context);
            }
            else if(date==' ' || selectedDate == ""){
              Fluttertoast.showToast(
                  msg: "Please Enter Date Of Birth",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 20.0
              );
              Navigator.pop(context);
              return;
              }
              else if(widget.flag =="0") {
                        print("datee  $date");
                        print("helloo");
                      setState(() {
                      MySharedPreferences.instance.setStringValue(
                      "name", _name.text);
                      MySharedPreferences.instance.setStringValue(
                      "date_of_birth", _birthplace.text);
                      MySharedPreferences.instance.setStringValue(
                      "sang", _sangh.text);
                      MySharedPreferences.instance.setStringValue(
                      "gnyati", _gnyati.text);
                      MySharedPreferences.instance.setStringValue(
                    "place_of_birth", _nativeplace.text);
                    MySharedPreferences.instance.setStringValue(
                    "gender", _gender);
                    MySharedPreferences.instance.setStringValue(
                    "physicaldisablity", _disability);
                    MySharedPreferences.instance.setStringValue(
                    "physicaldisablity_yes", _disabilityes.text);
                    MySharedPreferences.instance.setStringValue(
                    "marital_status", maritaldropdownValue);
                    MySharedPreferences.instance.setStringValue(
                    "current_activity", activitydropdownValue);
                    MySharedPreferences.instance.setStringValue(
                    "jain_sampraadaya", jaindropdownValue);
                    MySharedPreferences.instance.setStringValue(
                    "mother_tongue", tonguedropdownValue);
                    MySharedPreferences.instance.setStringValue(
                    "time_of_birth", _picked);
                    MySharedPreferences.instance.setStringValue(
                    "date_of_birth", date);
                    });

                      Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => LifeStyleDetails()));
    }
                      else {
                      await Provider.of<ProviderService>(context, listen: false)
                          .getBasicdetail({"user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "name": _name.text,
                      "physicalsisability": _disability,
                      "gender": _gender,
                      "marital_status": maritaldropdownValue,
                      "sang": _sangh.text,
                      "gnyati": _gnyati.text,
                      "date_of_birth": date,
                      "time_of_birth": _picked,
                      "place_of_birth": _birthplace.text,
                      "mother_tonge": tonguedropdownValue,
                      "jain_sampraadaya": jaindropdownValue,
                      "current_activity": activitydropdownValue,
                      "disabiliy_yes": _disabilityes.text,
                      "physicaldisability_yes": _disabilityes.text,
                      "native_place": _nativeplace.text,
                      })
                          .then((value) => setBasic(value.body));
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

  initPref()
  async {
    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
  }


  Future<void> _showTimePicker() async {
    final TimeOfDay result = await showTimePicker(
        context: context, initialTime: TimeOfDay.now() );
    if (result != null) {
      setState(() {
        _picked = result.format(context);
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context, // Refer step 1
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

      setState(() {
        selectedDate = pickedDate;
        date= "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
  }

  setBasic(Basic_add resp){

    Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
  }

  @override
  Widget build(BuildContext context){

    return WillPopScope(  onWillPop: _onWillPop,
      child:Scaffold(
        appBar: AppBar(
            title: Text('Basic Details', style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if (!_basicKey.currentState.validate()) {
                    Navigator.pop(context);
                  }
                  else if(date==' ' || selectedDate == ""){
                    Fluttertoast.showToast(
                        msg: "Please Enter Date Of Birth",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 20.0
                    );
                    Navigator.pop(context);
                    return;
                  }
                  else if(widget.flag =="0") {
                    setState(() {
                      MySharedPreferences.instance.setStringValue(
                          "name", _name.text);
                      MySharedPreferences.instance.setStringValue(
                          "date_of_birth", _birthplace.text);
                      MySharedPreferences.instance.setStringValue(
                          "sang", _sangh.text);
                      MySharedPreferences.instance.setStringValue(
                          "gnyati", _gnyati.text);
                      MySharedPreferences.instance.setStringValue(
                          "place_of_birth", _nativeplace.text);
                      MySharedPreferences.instance.setStringValue(
                          "gender", _gender);
                      MySharedPreferences.instance.setStringValue(
                          "physicaldisablity", _disability);
                      MySharedPreferences.instance.setStringValue(
                          "physicaldisablity_yes", _disabilityes.text);
                      MySharedPreferences.instance.setStringValue(
                          "marital_status", maritaldropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "current_activity", activitydropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "jain_sampraadaya", jaindropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "mother_tongue", tonguedropdownValue);
                      MySharedPreferences.instance.setStringValue(
                          "time_of_birth", _picked);
                      MySharedPreferences.instance.setStringValue(
                          "date_of_birth", date);
                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context) => LifeStyleDetails(flag: "0")));
                  }
                  else {
                    await Provider.of<ProviderService>(context, listen: false)
                        .getBasicdetail({"user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "name": _name.text,
                      "physicalsisability": _disability,
                      "gender": _gender,
                      "marital_status": maritaldropdownValue,
                      "sang": _sangh.text,
                      "gnyati": _gnyati.text,
                      "date_of_birth": date,
                      "time_of_birth": _picked,
                      "place_of_birth": _birthplace.text,
                      "mother_tonge": tonguedropdownValue,
                      "jain_sampraadaya": jaindropdownValue,
                      "current_activity": activitydropdownValue,
                      "disabiliy_yes": _disabilityes.text,
                      "physicaldisability_yes": _disabilityes.text,
                      "native_place": _nativeplace.text,
                    })
                        .then((value) => setBasic(value.body));
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
          child: Form(
              key: _basicKey,
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
                            text: '   Candidate Name (Name Fathername Surname)',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                          ),]
                          ),
                    ),
              ),
                    Container(

                      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0,0.0),
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width*.96,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 16),
                          cursorColor: Colors.black,
                        //  initialValue: _name.text,
                          readOnly: widget.flag == "0" ? false : true,
                          decoration: InputDecoration(

                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none
                      ),
                        controller: _name,
                        validator: (String value){
                          if(value.isEmpty){
                            return 'FullName is Required';
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
                          text: '   GENDER',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),]
                  ),
                ),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400])
                ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                    <Widget> [
                      Container(
                        height: 25,
                        child: ListTile(
                          title: const Text('MALE'),
                          leading: Transform.scale(

                              scale: 1.5,
                              child: Radio(
                          value: "Male",
                          groupValue: _gender,
                          onChanged: (value){
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),

                      ),
                      ),
                ),
                      SizedBox(height: 15,),
                      ListTile(
                        title: const Text('FEMALE'),
                        leading: Transform.scale(

                              scale: 1.5,
                          child: Radio(
                          value: "Female",
                          groupValue: _gender,
                          onChanged: (value){
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        ),
                      )
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
                child: RichText(
                  text: TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      children:[
                        TextSpan(
                          text: '   DATE OF BIRTH',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),]
                  ),
                ),
                ),
              GestureDetector(
                onTap: () async {
                  if(widget.flag == "0"){
                    _selectDate(context);

                  }
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 40,
                    width: MediaQuery.of(context).size.width*.96,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey[400]
                        )
                    ),

                    child: selectedDate != null ? Text('   $date', style: TextStyle(fontSize: 15),) : Text('  '),

                ),

              ),

              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 4.0, 0.0),
                alignment: Alignment.centerLeft,
                height:35,
                width: MediaQuery.of(context).size.width*.96,
                decoration: BoxDecoration(
                  color: Colors.grey[400] ,
                  border: Border.all(color: Colors.grey[400]),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TIME OF BIRTH', style: TextStyle(),),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _picked = null;
                        });
                      },
                      child: Icon(Icons.close)
                    )
                  ],
                )

                ),
              GestureDetector(
                onTap: () async {

                  if(widget.flag == "0") {
                    _showTimePicker();
                  }

                },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 35,
                      width: MediaQuery.of(context).size.width*.96,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400]
                        )
                      ),
                      child: _picked != null ? Text('   $_picked', style: TextStyle(fontSize: 15),) : Text('  ')
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
                child: Text('PLACE OF BIRTH', style: TextStyle(),
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
                  readOnly: widget.flag == "0" ? false: true,
                  decoration: InputDecoration(

                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none
                  ),
                  controller: _birthplace,
                  validator: (String value){
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
                child: RichText(
                  text: TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      children:[
                        TextSpan(
                          text: '   MOTHER TONGUE',
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
                        value: tonguedropdownValue,
                        icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                        iconSize: 44,
                        elevation: 16,

                        hint: Text('Select Mother Tongue', style: TextStyle(fontSize: 15)),

                        onChanged: (newValue) {
                          setState(() {
                            tonguedropdownValue = newValue;
                          });
                        },
                          validator : ( val){
                            if(val == null){
                              return 'Please Select Mother Tongue';
                            }
                          },
                        items: <String>["Doesn't Matter", 'Gujarati', 'Marwadi', 'Hindi', 'Other']
                            .map<DropdownMenuItem<String>>((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val, textAlign: TextAlign.start,),
                          );
                        }).toList(),
                      ),
                    ),)
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
                      style: TextStyle(color: Colors.red, fontSize: 18),
                      children:[
                        TextSpan(
                          text: '   JAIN SAMPRADAYA',
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
                          value: jaindropdownValue,
                          icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                          iconSize: 44,
                          elevation: 16,
                          hint: Text('Select Jain Sampradaya', style: TextStyle(fontSize: 15)),
                          validator : (String val){
                            if(val==null){
                              return 'Please Select Jain Sampradaya';
                            }
                          },
                        onChanged: (newValue) {
                          setState(() {
                            jaindropdownValue = newValue;
                          });
                        },
                        items: <String>["Shwetamber", 'Digambar', 'Sthanakwasi', 'Terapanth']
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
                child: Text('NATIVE PLACE', style: TextStyle(),
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

                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none
                ),
                controller: _nativeplace,
                validator: (String value){
                  return null;
                },
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
                child: Text('SANGH', style: TextStyle(),
                ),
              ),
            Container(
                height: 50,
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

              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none
            ),
              textCapitalization: TextCapitalization.characters,
            controller: _sangh,

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
                child: Text('GNYATI', style: TextStyle(),
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

                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none
                  ),
                  textCapitalization: TextCapitalization.characters,
                  controller: _gnyati,
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
                          text: '   PHYSICAL DISABILITY',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),]
                  ),
                ),
              ),
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400])
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      <Widget> [
                        Container(
                          height: 25,
                          child: ListTile(
                            title: const Text('Yes'),
                            leading: Transform.scale(

                              scale: 1.5,
                              child: Radio(

                              value: "Yes",
                              groupValue: _disability,
                              onChanged: (value){
                                setState(() {
                                  _disability = value;
                                });
                              },
                            ),
                            )
                          ),
                        ),
                        SizedBox(height:15,),
                        ListTile(
                          title: const Text('No'),
                          leading: Transform.scale(

                              scale: 1.5,
                              child: Radio(
                            value: "No",
                            groupValue: _disability,
                            onChanged: (value){
                              setState(() {
                                _disability = value;
                              });
                            },
                          ),
                        )
                        ),
                      ]
                  )
              ),
              SizedBox(height: 10,),
              Visibility(
                visible: _disability == "No" ? false : true,
                child: Container(
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

                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    hintText : 'Enter Disability',
                  ),

                  controller: _disabilityes,
                ),
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
                          text: '   MARITAL STATUS',
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
                      child:  DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
                        value: maritaldropdownValue,
                        icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                        iconSize: 44,
                        elevation: 16,
                        hint: Text('Select Marital Status', style: TextStyle(fontSize: 15)),
                        validator : (String val){
                          if(val==null){
                            return 'Please Select Marital Status';
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            maritaldropdownValue = newValue;
                          });
                        },
                        items: <String>["Single", 'Divorced', 'Widowed']
                            .map<DropdownMenuItem<String>>((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val, textAlign: TextAlign.start,),
                          );
                        }).toList(),
                      ),
                    ),)
                  ]
              ),

              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                alignment: Alignment.centerLeft,
                height:40,
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
                          text: '   CURRENT ACTIVITY',
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
                        value: activitydropdownValue,
                        icon: Icon(Icons.arrow_drop_down_outlined, size: 25, color: Colors.black,),
                        iconSize: 44,
                        elevation: 16,
                        hint: Text('Select Current Activity', style: TextStyle(fontSize: 15)),
                        validator : (String val){
                          if(val==null){
                            return 'Please Select Current Activity';
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            activitydropdownValue = newValue;
                          });
                        },
                        items: <String>["Study", 'House Hold', 'Business', 'Self Employed', 'Job/Service', 'Job Seeker', 'Retired', 'Social Work', 'Other']
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

            ]
          )
    )
    )
      )
      )
    ));;

  }
}