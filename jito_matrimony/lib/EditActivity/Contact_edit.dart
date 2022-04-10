//import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jito_matrimony/EditActivity/Education_edit.dart';
import 'package:jito_matrimony/EditActivity/city_list.dart';
import 'package:jito_matrimony/EditActivity/country_list.dart';
import 'package:jito_matrimony/EditActivity/state_list.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:jito_matrimony/Edit_Biodata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage.dart';

class ContactDetails extends StatefulWidget{

  List<CityList> listcity;
  List<StatList> liststate;
  String flag;
  var Contact;
  ContactDetails({this.Contact, this.listcity, this.liststate, this.flag});



  @override
  contactDetail createState() => contactDetail();
}
class ConList{
  final String country_name;
  final String country_id;

   ConList(this.country_name, this.country_id);
}


class contactDetail extends State<ContactDetails> {

  String _lives;
  String _visa;
  ConList country ;
  StatList state;
  bool isLoading = true;
  int count = 0;

  String _userid, _bioid, token;
  SharedPreferences myPrefs;

  TextEditingController _mail = TextEditingController();
  TextEditingController _wp = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phoneno = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _mobile = TextEditingController();


  List<ConList> listcountry = <ConList>[ ConList('Select', '0')];
  List<StatList> _liststate = <StatList>[ StatList('Select', '0', '0')];
  List<CityList> _listcity = <CityList>[CityList("Select", '0', '0')];
  CityList city;

  final GlobalKey<FormState> _contkey = GlobalKey<FormState>();

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
                Navigator.of(context).popUntil((_) => count++ >= 4);
              }else{
              Navigator.pop(context);
              Navigator.pop(context);
              }
            },
            child: Text('No', style: TextStyle(color: Colors.deepPurple),),
          ),
          FlatButton(
            onPressed: () async {

              if (!_contkey.currentState.validate()) {
                Navigator.pop(context);
                return;
              }
              if(widget.flag == "0"){
                setState(() {
                  MySharedPreferences.instance.setStringValue(
                      "city", city.toString());
                  MySharedPreferences.instance.setStringValue(
                      "country", country.toString());
                  MySharedPreferences.instance.setStringValue(
                      "state", state.toString());
                  MySharedPreferences.instance.setStringValue(
                      "pincode",_pincode.text);
                  MySharedPreferences.instance.setStringValue(
                      "landline_no",_phoneno.text);
                  MySharedPreferences.instance.setStringValue(
                      "mobile_no", _mobile.text);
                  MySharedPreferences.instance.setStringValue(
                      "emailid", _mail.text);
                  MySharedPreferences.instance.setStringValue(
                      "resident_address", _address.text);
                  MySharedPreferences.instance.setStringValue(
                      "visa_status", _visa);
                  MySharedPreferences.instance.setStringValue(
                      "cand_whatsapp", _wp.text);
                  MySharedPreferences.instance.setStringValue(
                      "liveswithfmlyn", _lives);

                });
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetails(flag: "0")));
              }
              else {
                await Provider.of<ProviderService>(context, listen: false)
                    .addContact({"user_id": _userid,
                  "token": token,
                  "bio_id": _bioid,
                  "city": city.city_id,
                  "country": country.country_id,
                  "state": state.state_id,
                  "pincode": _pincode.text,
                  "landline_no": _phoneno.text,
                  "contact_no": _mobile.text,
                  "email": _mail.text,
                  "residant_address": _address.text,
                  "visa_status": _visa,
                  "cand_whatsappno": _wp.text,
                  "liveswithfmlyn": _lives,

                })
                    .then((value) => (value.body));
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
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

    super.initState();

    if(widget.flag =="1") {
      setState(() {
        isLoading = true;
        listcountry = <ConList>[
          ConList(
              '${widget.Contact.countryName}', '${widget.Contact.countryId}')        ];
        _liststate = <StatList>[
          StatList('${widget.Contact.stateName}', '${widget.Contact.stateId}',              '${widget.Contact.countryId}')
        ];
        _listcity = <CityList>[
          CityList('${widget.Contact.cityName}', '${widget.Contact.cityId}',              '${widget.Contact.stateId}')
        ];
        country = listcountry[0];
        state = _liststate[0];
        city = _listcity[0];

        _mail.text = widget.Contact.contactEmail == null ? "" : widget.Contact.contactEmail;
        _mobile.text =  widget.Contact.mobileNo == null ? "" : widget.Contact.mobileNo;
        _address.text = widget.Contact.residenceAddress == null ? "" : widget.Contact.residenceAddress;
        _phoneno.text = widget.Contact.landlineNo == null ? "" : widget.Contact.landlineNo;
        _pincode.text = widget.Contact.pincode == null ? "" : widget.Contact.pincode;_visa =
        widget.Contact.visaStatus == null ? "" : widget.Contact.visaStatus;
        _wp.text = widget.Contact.candWhatsappno == null ? "" : widget.Contact.candWhatsappno;
        _lives = widget.Contact.liveswithfmlyn == null ? "" : widget.Contact.liveswithfmlyn;
      });

      print("name of city =${country.country_name}=");
    }
    else{
      widget.liststate = [];
      widget.listcity = [];
      country = listcountry[0];
      state = _liststate[0];
      city = _listcity[0];
    }

    _initPefrence();

    print(memId + " ------- 0000000");
  }


  String memId = "",
      servtype = "",
      dcode = "",
      cmmemid = "",
      smjid = "";

  _initPefrence() async {
    print("memId");

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue("user_id", myPrefs);
    token = MySharedPreferences.instance.getStringValue("token", myPrefs);
    _bioid = MySharedPreferences.instance.getStringValue("bio_id", myPrefs);

    await Provider.of<ProviderService>(context, listen: false).getCountry({}).then((
        value) => ListCountry(value.body));

    print("niinitititi ${widget.flag}");

   if(widget.flag=="0") {
     await Provider.of<ProviderService>(context, listen: false)
         .getState({})
         .then((value) => ListState(value.body));


     await Provider.of<ProviderService>(context, listen: false)
         .getCity({})
         .then((value) => ListCity(value.body));
   }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(  onWillPop: _onWillPop,
    child: Scaffold(
        appBar: AppBar(
            title: Text('Contact Details',
              style: TextStyle(color: Colors.white, fontSize: 17),),
            actions: <Widget>[
              TextButton(
                onPressed: () async {

                  if (!_contkey.currentState.validate()) {
                    return;
                  }

                  if(widget.flag == "0"){
                    setState(() {
                      MySharedPreferences.instance.setStringValue(
                          "city", city.toString());
                      MySharedPreferences.instance.setStringValue(
                          "country", country.toString());
                      MySharedPreferences.instance.setStringValue(
                          "state", state.toString());
                      MySharedPreferences.instance.setStringValue(
                          "pincode",_pincode.text);
                      MySharedPreferences.instance.setStringValue(
                          "landline_no",_phoneno.text);
                      MySharedPreferences.instance.setStringValue(
                          "mobile_no", _mobile.text);
                      MySharedPreferences.instance.setStringValue(
                          "emailid", _mail.text);
                      MySharedPreferences.instance.setStringValue(
                          "resident_address", _address.text);
                      MySharedPreferences.instance.setStringValue(
                          "visa_status", _visa);
                      MySharedPreferences.instance.setStringValue(
                          "cand_whatsapp", _wp.text);
                      MySharedPreferences.instance.setStringValue(
                          "liveswithfmlyn", _lives);


                    });

                    Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetails(flag: "0")));
                  }
                  else {
                    await Provider.of<ProviderService>(context, listen: false)
                        .addContact({"user_id": _userid,
                      "token": token,
                      "bio_id": _bioid,
                      "city": city.city_id,
                      "country": country.country_id,
                      "state": state.state_id,
                      "pincode": _pincode.text,
                      "landline_no": _phoneno.text,
                      "contact_no": _mobile.text,
                      "email": _mail.text,
                      "residant_address": _address.text,
                      "visa_status": _visa,
                      "cand_whatsappno": _wp.text,
                      "liveswithfmlyn": _lives,

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
                    key: _contkey,
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                  children: [
                                    TextSpan(
                                      text: '   FAMILY RESIDENCE ADDRESS',
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Container(

                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
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
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _address,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Family Address is Required';
                                }
                                return null;
                              },
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
                                      text: '   COUNTRY',
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ]
                              ),
                            ),
                          ),

                            Container(

                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                              alignment: Alignment.topCenter,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: DropdownButtonFormField<ConList>(
                              isExpanded: true,
                              // underline: Container(
                              //   height: 3,
                              //   decoration: BoxDecoration(
                              //     border: Border(bottom: BorderSide.none,)),
                              //   ),

                                value: country,
                              items: listcountry.map((ConList val) {
                                return new DropdownMenuItem<ConList>(
                                  value: val,
                                  child: Text(val.country_name , style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                                );
                              }).toList(),

                              onChanged: (value) {
                                setState(() {

                                  country = value;

                                  _liststate = widget.liststate.where((f) => f.country_id == value.country_id ).toList();

                                  if(_liststate.length <= 0) {

                                    state = widget.liststate[0];
                                  }else{

                                    state = _liststate[0];
                                  }

                                });
                              },
                              validator: (val){
                                if(val.country_name == "Select"){
                                  return 'Please Select Country';
                                }
                              },

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
                                    text: '   STATE',
                                    style: TextStyle(fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        Container(

                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: DropdownButtonFormField<StatList>(
                                isExpanded: true,
                                validator: (val){
                                  if(val.state_name== "Select"){
                                    return 'Please Select City';
                                  }
                                },
                                value: state,
                                items: _liststate.map((StatList val) {
                                return new DropdownMenuItem<StatList>(
                                    value: val,
                                    child: Text(val.state_name , style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                                );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {

                                    state = value;

                                    _listcity = widget.listcity.where((f) => f.state_id == value.state_id ).toList();

                                    if(_listcity.length<=0){
                                      city = widget.listcity[0];
                                    }
                                    else
                                      {
                                        city = _listcity[0];
                                      }

                          });
                        }),

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
                                      text: '   CITY',
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ]
                              ),
                            ),
                          ),

                          Container(

                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 7.0),
                            alignment: Alignment.topCenter,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .96,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: DropdownButtonFormField<CityList>(
                                isExpanded: true,

                                validator: (val){
                                  if(val.city_name== "Select"){
                                    return 'Please Select City';
                                  }
                                },
                                value: city,
                                items: _listcity.map((CityList val) {
                                  return new DropdownMenuItem<CityList>(
                                    value: val,
                                    child: Text(val.city_name , style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {

                                    city = value;

                                  });
                                }
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
                            child: Text(" PINCODE", style: TextStyle(),
                            ),
                          ),
                          Container(
                            height: 40,
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
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _pincode,
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
                            child: Text(" LANDLINE NO", style: TextStyle(),
                            ),
                          ),
                          Container(
                            height: 40,
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
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _phoneno,

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
                            child: Text(' CANDIDATE LIVES WITH FAMILY?',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black),),

                          ),
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400])
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                <Widget>[
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -2),
                                      dense: true,
                                      title: const Text('YES', style: TextStyle(
                                          fontSize: 17),),
                                      leading: Transform.scale(

                                        scale: 1.5,
                                        child: Radio(

                                          value: "yes",
                                          groupValue: _lives,
                                          onChanged: (value) {
                                            setState(() {
                                              _lives = value;
                                            });
                                          },
                                        ),
                                      )

                                  ),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -2),
                                      dense: true,
                                      title: const Text('NO', style: TextStyle(
                                          fontSize: 17),),
                                      leading: Transform.scale(

                                        scale: 1.5,
                                        child: Radio(
                                          value: "no",
                                          groupValue: _lives,
                                          onChanged: (value) {
                                            setState(() {
                                              _lives = value;
                                            });
                                          },
                                        ),
                                      )
                                  ),

                                ]
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
                            child: Text(' VISA STATUS',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black),),

                          ),
                          Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400])
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  <Widget>[
                                    ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('None'),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(

                                            value: "none",
                                            groupValue: _visa,
                                            onChanged: (value) {
                                              setState(() {
                                                _visa = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                    ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('Resident'),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "resident",
                                            groupValue: _visa,
                                            onChanged: (value) {
                                              setState(() {
                                                _visa = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                    ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('H1B'),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "h1b",
                                            groupValue: _visa,
                                            onChanged: (value) {
                                              setState(() {
                                                _visa = value;
                                              });
                                            },
                                          ),
                                        )
                                    ),
                                    ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -2),
                                        dense: true,
                                        title: const Text('Others'),
                                        leading: Transform.scale(

                                          scale: 1.5,
                                          child: Radio(
                                            value: "others",
                                            groupValue: _visa,
                                            onChanged: (value) {
                                              setState(() {
                                                _visa = value;
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
                            child: RichText(
                              text: TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                  children: [
                                    TextSpan(
                                      text: ' CANDIDATE MOBILE NO',
                                      style: TextStyle(fontSize: 15,
                                          color: Colors.black),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Container(
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
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _mobile,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Mobile Number is Required';
                                }
                                return null;
                              },
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
                            child: Text(" WHATSAPP NUMBER", style: TextStyle(),
                            ),
                          ),
                          Container(
                            height: 40,
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
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _wp,

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
                            child: Text(
                              " CANDIDATE EMAIL ID", style: TextStyle(),
                            ),
                          ),
                          Container(
                            height: 40,
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
                              style: TextStyle(fontSize: 16),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(

                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                              controller: _mail,

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

  ListCountry(country_list body) {

    setState(() {
      print("conuntry start = ");
      for (int i = 0; i < 247; i++) {

        listcountry.add(ConList(body.datainfo[i].countryName.toString(), body.datainfo[i].countryId.toString()));

      }
      if(widget.flag == "1"){
        isLoading = false;
      }

    });

  }

  ListState(state_list body) {

    setState(() {
      for (int i = 0; i < 4119; i++) {

        widget.liststate.add(StatList(body.datainfo[i].stateName.toString(),
            body.datainfo[i].stateId.toString(),
            body.datainfo[i].countryId.toString()));

      }
      isLoading = false;
      print('statteeeeeeeeeeeee enddd');
    });
  }


  ListCity(city_list body) {
    setState(() {
      print("citytyty start");

      for (int i = 0; i < 48354; i++) {

        widget.listcity.add(CityList(body.datainfo[i].cityName.toString(),
            body.datainfo[i].cityId.toString(),
            body.datainfo[i].stateId.toString()));
      }
      print(" CItyyyyy End");
    });
  }

    // ListState(state_list body) {
  //
  //   setState(() {
  //     for (int i = 0; i < 4119; i++) {
  //       var res = body.datainfo[i];
  //
  //       liststate.add(StatList(body.datainfo[i].stateName.toString(),
  //           body.datainfo[i].stateId.toString(),
  //           body.datainfo[i].countryId.toString()));
  //
  //     }
  //     _liststate = liststate;
  //     print('statteeeeeeeeeeeee enddd');
  //
  //     isLoading = false;
  //   });
  // }

  // ListCity(city_list body) {
  //
  //   setState(() {
  //
  //     for (int i = 0; i < 48354; i++) {
  //       var res = body.datainfo[i];
  //
  //       listcity.add(CityList(body.datainfo[i].cityName.toString(), body.datainfo[i].cityId.toString(), body.datainfo[i].stateId.toString()));
  //       print("citytyyyyyyy $i "+ res.toString());
  //     }
  //     _listcity = listcity;
  //   });
  //   pr.hide();
  //
  //
  // }
}