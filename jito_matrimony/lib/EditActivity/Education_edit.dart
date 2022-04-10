import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/education_list.dart';
import 'package:jito_matrimony/EditClasses/educationadd.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/homepage.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Professional_edit.dart';


class EducationDetails extends StatefulWidget{

  var Education_;
  String academics, flag;
  EducationDetails({this.Education_, this.academics, this.flag});
  @override
  educationDetail createState() => educationDetail();
}

class Education{
  final String educationId;
  final String educationName;
  Education({this.educationId, this.educationName});
}

class educationDetail extends State<EducationDetails> {

  TextEditingController _academic = TextEditingController();
  TextEditingController _edudegree = TextEditingController();

  Education edu;


  var edudropdownValue;
  int count = 0;
  int t = 2;

  SharedPreferences myPrefs;
  bool isLoading = true;

  String _userid, token, _bioid, eduids;

  List<Education> edulist = [ Education(educationId : "1", educationName:'10TH')];
  List<Education> eduselectlist = [Education(educationId : "1", educationName:'10TH')];
  List<String> educonf = [];
  List<String> templist =[];
  var _eduitems, eduselectitems;

  final GlobalKey<FormState> _edukey = GlobalKey<FormState>();


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

              if(widget.flag == "0"){
                Navigator.of(context).popUntil((_) => count++ >= 5),
              }else{
                Navigator.pop(context),
                Navigator.pop(context),
              }
            },

            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {

              if (!_edukey.currentState.validate()) {
                Navigator.pop(context);
                return;
              }

              if(widget.flag =="0"){

                MySharedPreferences.instance.setStringValue("education_details", eduids);
                MySharedPreferences.instance.setStringValue("academics_det", _academic.text);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProfessionDetails(flag: "0")));
              }
              else {
                await Provider.of<ProviderService>(context, listen: false)
                    .addeducation({
                  "academics_det": _academic.text,
                  "user_id": _userid,
                  "token": token,
                  "bio_id": _bioid,
                  "education_details": eduids
                })
                    .then((value) => addingedu(value.body));

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
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

  void initState(){
    super.initState();

    edudropdownValue = widget.Education_;
    print("gttniningg into");
    setState(() {
      isLoading = true;

     if(widget.flag=="1") {
       _academic.text = widget.academics;
       print("helo");
     }
       educall();
       initPref();

    });

  }

  initPref() async {
    myPrefs = await SharedPreferences.getInstance();

    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);
  }

  educall() async{
    await Provider.of<ProviderService>(context, listen: false).getEducation({}).then((value) => Edulist(value.body));
  }

  Edulist(education_list response){

    setState(() {
      for (int j = 0; j < 6; j++) {
        for (int i = 1; i < (response.datainfo[j].details.length); i++) {
          edulist.add(Education(
              educationId: response.datainfo[j].details[i].educationId,
              educationName: response.datainfo[j].details[i].educationName));

          print("edulist  is here : ${edulist[i].educationName}");

          if (widget.flag == "1") {
            if (widget.Education_.contains(
                response.datainfo[j].details[i].educationName)) {
              eduselectlist.add(Education(
                  educationId: response.datainfo[j].details[i].educationId,
                  educationName: response.datainfo[j].details[i]
                      .educationName));
            }
            print("sellist  is here : ${edulist[i].educationName}");
          }
        }
        print("above ed");
        _eduitems = edulist.map((edu) =>
            MultiSelectItem<Education>(edu, edu.educationName)).toList();

        print(edulist);

        print('ed');

        isLoading = false;
      }
    });

  }

   _showDialog(context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Expanded(child:
                    Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Enter Category'),
                      SizedBox(height: 10,),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 45,
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width * .6,

                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                              ),

                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                ),
                                value: "Select Category",
                                icon: Icon(
                                  Icons.arrow_drop_down_outlined, size: 25,
                                  color: Colors.black,),
                                iconSize: 44,
                                elevation: 16,
                                //hint: Text('Select Jain Sampradaya', style: TextStyle(fontSize: 15)),

                                onChanged: (newValue) {
                                  setState(() {
                                    edudropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Select Category',
                                  "Graduate",
                                  'Professional',
                                  'Masters',
                                  'Doctorate',
                                  'Diploma',
                                  'Secondary'
                                ]
                                    .map<DropdownMenuItem<String>>((
                                    String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(
                                      val, textAlign: TextAlign.start,),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,

                        style: TextStyle(fontSize: 16),
                        cursorColor: Colors.black,

                        decoration: InputDecoration(
                            hintText: '   Enter Your Education Degree',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none
                        ),

                        controller: _edudegree,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      ),
                      ButtonTheme(
                          child: RaisedButton(
                              onPressed: () {},
                              child: Text('Cancel')
                          )
                      ),
                      ButtonTheme(

                          child: RaisedButton(
                            onPressed: () {
                              setState((){
                                edudropdownValue = _edudegree.text;
                              });

                              Navigator.pop(context);
                            },
                            child: Text('Ok'),
                          )
                      )

                    ]
                    ),
                );
              }
          ),

        );
      },
    );
  }

  dropdownDialog(context) async {
    return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
                return Expanded(



            );

            }
            )
          );
        }
    );
  }

  addingedu(educationadd resp){
    print("hwedoewweienwiwnd    ${resp.message}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
            title: Text('Education Details',
              style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if (!_edukey.currentState.validate()) {
                    return;
                  }

                  if(widget.flag =="0"){

                    MySharedPreferences.instance.setStringValue("education_details", eduids);
                    MySharedPreferences.instance.setStringValue("academics_det", _academic.text);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfessionDetails(flag: "0")));
                  }
                  else {
                    await Provider.of<ProviderService>(context, listen: false)
                        .addeducation({
                      "academics_det": _academic.text,
                      "user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "education_details": eduids
                    })
                        .then((value) => addingedu(value.body));

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
                  }

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(thickness: 1.0, color: Colors.white,),
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 5,),
                    Text('SAVE  ',
                        style: TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
              ),
            ]
        ),
        body: isLoading ? Loader() : SingleChildScrollView(
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
                    key: _edukey,

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

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
                              style: TextStyle(color: Colors.red, fontSize: 18),
                              children: [
                                TextSpan(
                                  text: ' Educational Details',
                                  style: TextStyle(fontSize: 15,
                                      color: Colors.black),
                                ),
                                WidgetSpan(
                                  child: InkWell(
                                      onTap: () {
                                        _showDialog(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 180),
                                        child: Icon(Icons.add),
                                      )

                                  ),

                                )
                              ]
                          ),
                        ),
                      ),
                          Row(

                            children:[
                              InkWell(

                                child: Container(

                                    width: MediaQuery.of(context).size.width*.945,
                                    decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey)

                                ),
                                  child: MultiSelectDialogField(
                                    initialValue: eduselectlist ,
                                    listType: MultiSelectListType.LIST,
                                    items: _eduitems,
                                    title: Text(" Education Fields", style: TextStyle(color: Colors.black),),
                                    selectedColor: Colors.blueGrey,

                                    buttonIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.deepPurple,
                                      size: 50,
                                  ),
                                  validator: (val){
                                      if(val.length < t){
                                        return 'Please Enter Education Details';
                                      }
                                  },
                                  searchable: true,
                                  onSelectionChanged: (values){

                                      setState(() {
                                        t=1;
                                      });
                                  },
                                  onConfirm: ( results) {
                                    setState(() {
                                      eduselectlist = results;
                                      print(results.length);
                                      for(int j=0; j<eduselectlist.length;j++){
                                        educonf.add(eduselectlist[j].educationId);
                                        print("educonf     $educonf");
                                      }
                                      eduids = educonf.join(',');
                                      print(eduids);

                                    });

                                  },
                                ),
                              ),
                        ), ]
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width * .96,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [

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
                              child: Text(' ACADEMIC DETAILS',
                                style: TextStyle(fontSize: 15,
                                    color: Colors.black),
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
                                controller: _academic,

                              ),
                            )
                          ],
                        ),
                      ),

                    ]
                ),
              ),

            )
        )
        )
    )
    );
  }

}