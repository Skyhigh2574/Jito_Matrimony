import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/Hobby_edit.dart';
import 'package:jito_matrimony/EditActivity/occupation_list.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditClasses/Basic_add.dart';
import '../homepage.dart';

class ProfessionDetails extends StatefulWidget{

  var Profession, flag;
  ProfessionDetails({this.Profession, this.flag});
  @override
  professionDetail createState() => professionDetail();
}

class profList{

  String prof_name;
  String prof_id;
  profList(this.prof_name, this.prof_id);
}

class professionDetail extends State<ProfessionDetails>{

  TextEditingController _workingwith = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _offAdd = TextEditingController();
  int count= 0;

  var profession;
  List<profList> listprofession = <profList>[ profList('Select', '0')];
  final GlobalKey<FormState> _profkey = GlobalKey<FormState>();

  SharedPreferences myPrefs;

  String _userid, _bioid, token;

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Save Changes?',),
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
                Navigator.of(context).popUntil((_) => count++ >= 6);
              }else{
              Navigator.pop(context);
              Navigator.pop(context);
              }
    },
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () async {

              if (!_profkey.currentState.validate()) {
                  Navigator.pop(context);
                  return;
              }

              if(widget.flag=="0"){

                MySharedPreferences.instance.setStringValue("working_with", _workingwith.text);
                MySharedPreferences.instance.setStringValue("business_category", profession.prof_id);
                MySharedPreferences.instance.setStringValue("designation", _designation.text);
                MySharedPreferences.instance.setStringValue("office_address", _offAdd.text);
                MySharedPreferences.instance.setStringValue("occupation_det", _profession.text);

                Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context) => HobbyDetails(flag: "0")));
              }
              else {
              await Provider.of<ProviderService>(context, listen: false)
                  .addProfeession({"user_id": _userid,
              "token": token,
              "bio_id": _bioid,
              "working_with": _workingwith.text,
              "business_category": profession.prof_id,
              "designationnm": _designation.text,
              "office_address": _offAdd.text,
              "occupation_det": _profession.text,
              }).then((value) => (value.body));

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
              }
          },

          child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  void initState() {

    super.initState();
    if(widget.flag == "1"){
        _workingwith.text = widget.Profession.workingWith == null ? "" :widget.Profession.workingWith ;
        _profession.text = widget.Profession.occupationDet == null ?"":widget.Profession.occupationDet;
        _designation.text = widget.Profession.designationName == null ? "" : widget.Profession.designationName;
        _offAdd.text = widget.Profession.officeAddress == null ? "": widget.Profession.officeAddress;
        profession = widget.Profession.businessTypes == null ? listprofession[0]: widget.Profession.businessTypes;
    }

    _initPefrence();

  }

  _initPefrence() async {
    myPrefs = await SharedPreferences.getInstance();

    await Provider.of<ProviderService>(context, listen: false).getOccupation({}).then((value) => ListProf(value.body));

    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
  }

  ListProf(occupation_list body){

    setState(() {
      for(int i=0; i<196;i++){
        listprofession.add(profList(body.datainfo[i].businessName.toString(), body.datainfo[i].businessTypeId.toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
            title: Text('Profession Details', style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if (!_profkey.currentState.validate()) {
                    return;
                  }
                    if(widget.flag=="0"){
                      MySharedPreferences.instance.setStringValue("working_with", _workingwith.text);
                      MySharedPreferences.instance.setStringValue("business_category", profession.prof_id);
                      MySharedPreferences.instance.setStringValue("designation", _designation.text);
                      MySharedPreferences.instance.setStringValue("office_address", _offAdd.text);
                      MySharedPreferences.instance.setStringValue("occupation_det", _profession.text);

                      Navigator.push(context, MaterialPageRoute(builder: (context) => HobbyDetails(flag: "0")));
                    }
                    else {
                      await Provider.of<ProviderService>(context, listen: false)
                          .addProfeession({"user_id": _userid,
                        "token": token,
                        "bio_id": _bioid,
                        "working_with": _workingwith.text,
                        "business_category": profession.prof_id,
                        "designationnm": _designation.text,
                        "office_address": _offAdd.text,
                        "occupation_det": _profession.text,
                      })
                          .then((value) => (value.body));

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
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
                      key: _profkey,
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
                                  child: Text(' WORKING WITH',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
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
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    style: TextStyle(fontSize: 16),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(

                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none
                                    ),
                                    controller: _workingwith,

                                  ),
                                )
                              ],
                            ),
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
                            child: RichText(
                              text: TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                  children: [
                                    TextSpan(
                                      text: '   OCCUPATION CATEGORY',
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ]
                              ),
                            ),
                          ),

                          Container(
                            height: 80,
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: DropdownButtonFormField<profList>(
                                isExpanded: true,
                                iconDisabledColor: Colors.deepPurple,
                                iconEnabledColor: Colors.deepPurple,
                                iconSize: 70,

                                validator: (val){
                                  if(val == null){
                                      return 'Please Select Occupation Category';
                                  }
                                },

                                value: profession,
                                items: listprofession.map((profList val) {
                                  return new DropdownMenuItem<profList>(
                                    value: val,
                                    child: Text(val.prof_name , style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {

                                    profession = value;


                                  });
                                }),

                          ),
                          SizedBox(height: 20,),
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
                                  child: Text(' DESIGNATION',
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
                                    controller: _designation,

                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),
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
                                  child: Text(' OFFICE ADDRESS',
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
                                    controller: _offAdd,

                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),
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
                                  child: Text(' OCCUPATION DETAILS',
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
                                    controller: _profession,

                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),

                        ]
                    )


                )
            )
        )
        )
    )
    );

  }

}