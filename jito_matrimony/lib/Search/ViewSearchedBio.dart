import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:path/path.dart' as path;
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:jito_matrimony/EditActivity/Contact_edit.dart';
import 'package:jito_matrimony/EditActivity/Professional_edit.dart';
import 'package:jito_matrimony/EditActivity/ViewPhoto.dart';
import 'package:jito_matrimony/EditActivity/state_list.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/EditActivity/Basic_edit.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:jito_matrimony/view_biodata.dart';
import 'package:jito_matrimony/view_biodata.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';



class ViewSearchedBio extends StatefulWidget{

  String profid;
  ViewSearchedBio({this.profid});

  viewbio createState() => viewbio();
}

class viewbio extends State<ViewSearchedBio> {

  SharedPreferences myPrefs;
  String _name, _age;
  String _birthplace;
  String _sangh;
  String _gnyati;
  String _nativeplace;
  String _gender;
  String _disability;
  String _disabilityyes;
  String _marital;
  String _activity;
  String _jain;
  String _tongue;
  String _birthtime;
  String _birthdate;
  String _manglik;
  String _horoscope;
  var _hobbies, _educationdetails, _businesscat;
  String  _academics, _joineducation, _joinbusiness;

  String _residentadd, _city, _state, _country, _pincode, _landline, _email, _wp, _live, _candidatemob, _visa;

  String _height, _weight, _bloodgrp, _spects, _skin, _body, _diet, _disease, _facebook, _instagram, _linkedin;

  String _aboutme, _aboutpartner, _partnerheightmax, _partnerheightmin, _partneragemin, _partneragemax, _partnermanglik, _partnerbody, _partnermarital, _partnerworkcategory, _partnereducation, _partnerskin;

  String _fathername, _mothername, _totalbro, _totalmarrbro, _totalsis, _totalmarrsis, _familytype, _housetype, _fatherocc, _officetype, _fatheroffadd, _fathermob, _fatheroffno, _mothermob, _motherwp, _fatherwp;

  String _officeadd, _workwith, _designation, _occupationdet;

  String img1, img2 , img3;

  String path;

  String _userid, _token;

  String flag;

  String _joinHobbies = " ";

  List<String> _joinHobbieslist = [];
  List<String> _joinEducationlist = [];
  List<String> _joinBusinesslist = [];

  var _Family, _Partner, _Profession, _Lifestyle, _Hobbies, _Basic, _Astro, _Education, _Contact;

  bool vis_sangh, vis_gnyati, vis_birthtime, vis_birthplace, vis_native, vis_manglik, vis_horoscope, vis_academics, vis_pincode, vis_landline, vis_email, vis_wp, vis_live, vis_visa;
  bool vis_officetype, vis_fathermob, vis_fatheroffadd, vis_fatherwp, vis_familytype, vis_motherwp, vis_mothermob, vis_fatherocc, vis_housetype, vis_fatheroffno, vis_bloodgrp, vis_spects ;
  bool vis_skin, vis_body, vis_diet, vis_disease, vis_facebook, vis_instagram , vis_linkedin, vis_workwith, vis_designation, vis_officeadd, vis_occupationdet, vis_hobbies, vis_totalbro, vis_totalsis;
  bool vis_partnermarital, vis_partnerbody, vis_partnerheightmin, vis_partnerheightmax, vis_partneragemin, vis_partneragemax, vis_partnerskin, vis_aboutme, vis_aboutpartner, vis_partnermanglik;

  bool isLoading;

  // final GlobalKey pdfglobalKey = new GlobalKey();
  final GlobalKey<State<StatefulWidget>> pdfglobalKey = GlobalKey();
  File _imageFile;
  Random rng = new Random();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    initPreference();

    path = 'Assets/ic_profile.png';
  }

  getBio(view_biodata response){


    setState(() {

      img1 = response.datainfo[0].img1;
      img2 = response.datainfo[0].img2;
      img3 = response.datainfo[0].img3;

      _name = response.datainfo[0].name;
      _gender = response.datainfo[0].gender;
      _birthdate = response.datainfo[0].dateOfBirth;
      _tongue = response.datainfo[0].motherToungue;
      _jain = response.datainfo[0].jainSampradaya;
      _sangh = response.datainfo[0].sangh;
      _gnyati = response.datainfo[0].gnyati;
      _disability = response.datainfo[0].physicalDisability;
      _disabilityyes = response.datainfo[0].physicalDisabilityYes;
      _birthtime = response.datainfo[0].timeOfBirth;
      _birthplace = response.datainfo[0].placeOfBirth;
      _marital = response.datainfo[0].maritalStatus;
      _activity = response.datainfo[0].currentActivity;
      _nativeplace = response.datainfo[0].nativePlace;
      _age = response.datainfo[0].age;

      vis_sangh = _sangh == null ? false: true;
      vis_gnyati = _gnyati == null ? false: true;
      vis_birthplace = _birthplace == null ? false: true;
      vis_birthtime = _birthtime == null ? false: true;
      vis_native = _nativeplace == null ? false: true;

      _manglik = response.datainfo[0].astroManglik;
      _horoscope = response.datainfo[0].astroHoroscope;

      vis_manglik = _manglik == null ? false: true;
      vis_horoscope = _horoscope == null ? false: true;

      _residentadd = response.datainfo[0].residenceAddress;
      _pincode = response.datainfo[0].pincode;
      _landline = response.datainfo[0].landlineNo;
      _email = response.datainfo[0].contactEmail;
      _country = response.datainfo[0].country;
      _state = response.datainfo[0].state;
      _city = response.datainfo[0].city;
      _live = response.datainfo[0].liveswithfmlyn;
      _visa = response.datainfo[0].visaStatus;
      _wp = response.datainfo[0].candWhatsappno;
      _candidatemob = response.datainfo[0].mobileNo;

      vis_pincode = _pincode  == null ? false: true;
      vis_landline = _landline == null ? false: true;
      vis_email = _email == null ? false: true;
      vis_live = _live == null ? false: true;
      vis_wp = _wp == null ? false: true;
      vis_visa = _visa == null ? false: true;

      _fathername = response.datainfo[0].fatherName;
      _mothername = response.datainfo[0].motherName;
      _totalbro = response.datainfo[0].totalBrother;
      _totalmarrbro = response.datainfo[0].totalMarriedBrother;
      _totalsis  = response.datainfo[0].totalSister;
      _totalmarrsis = response.datainfo[0].totalMarriedSister;
      _housetype = response.datainfo[0].houseType;
      _fatherocc = response.datainfo[0].fatherOccupation;
      _familytype = response.datainfo[0].familyType;
      _fatheroffadd = response.datainfo[0].fatherOfficeAddress;
      _fatheroffno = response.datainfo[0].fatherOfficeNo;
      _fathermob = response.datainfo[0].fatherMobileNo;
      _fatherwp = response.datainfo[0].fatherWhatsapp;
      _motherwp = response.datainfo[0].motherWhatsapp;
      _mothermob = response.datainfo[0].motherMob;

      vis_totalbro = _totalbro == null? false: true;
      vis_totalsis = _totalsis == null? false: true;
      vis_fathermob = _fathermob == null? false: true;
      vis_mothermob = _mothermob == null? false: true;
      vis_housetype = _housetype == null? false: true;
      vis_fatherocc = _fatherocc == null? false: true;
      vis_fatheroffadd = _fatheroffadd == null? false: true;
      vis_fatheroffno = _fatheroffno == null? false: true;
      vis_fatherwp = _fatherwp  == null? false: true;
      vis_motherwp = _motherwp == null? false: true;
      vis_familytype = _familytype == null? false: true;
      vis_officetype = _officetype == null? false: true;

      _height = response.datainfo[0].height;
      _weight= response.datainfo[0].weight;
      _bloodgrp = response.datainfo[0].bloodGroup;
      _spects = response.datainfo[0].spects;
      _skin = response.datainfo[0].skinTone;
      _body = response.datainfo[0].bodyType;
      _diet = response.datainfo[0].dietType;
      _disease = response.datainfo[0].disease;
      _facebook = response.datainfo[0].socialFacebook;
      _instagram = response.datainfo[0].socialInstagram;
      _linkedin = response.datainfo[0].socialLinkedin;

      vis_bloodgrp = _bloodgrp == null? false: true;
      vis_spects = _spects == null? false: true;
      vis_skin = _skin == null? false: true;
      vis_diet = _diet == null? false: true;
      vis_disease = _disease == null? false: true;
      vis_facebook = _facebook == null? false: true;
      vis_instagram = _instagram == null? false: true;
      vis_linkedin = _linkedin == null? false: true;

      _workwith = response.datainfo[0].workingWith;
      _businesscat = response.datainfo[0].buisnessType;
      _designation = response.datainfo[0].designation;
      _occupationdet = response.datainfo[0].occupationDet;
      _officeadd = response.datainfo[0].officeAddress;

      vis_workwith = _workwith == null? false: true;
      vis_designation = _designation == null? false: true;
      vis_occupationdet = _occupationdet == null? false: true;
      vis_officeadd = _officeadd == null? false: true;

      _hobbies = response.datainfo[0].hobbies;
      vis_hobbies = _hobbies == null? false: true;

      _educationdetails = response.datainfo[0].educationDetails;

      _academics = response.datainfo[0].academicsDet;
      vis_academics = _academics == null? false: true;

      // _partnerworkcategory = response.datainfo[0].partnerWorkingCategory;
      // _partnereducation = response.datainfo[0].partnerEducation;
      _partnermarital = response.datainfo[0].partnerMeritalStatus;
      _partnerbody = response.datainfo[0].partnerBodyType;
      _partnermanglik = response.datainfo[0].partnerNamglic;
      _partnerheightmax = response.datainfo[0].partnerHeightMax;
      _partnerheightmin = response.datainfo[0].partnerHeightMin;
      _partneragemax = response.datainfo[0].partnerAgeMax;
      _partneragemin = response.datainfo[0].partnerAgeMin;
      _partnerskin = response.datainfo[0].partnerSkintone;
      _aboutme = response.datainfo[0].aboutMe;
      _aboutpartner = response.datainfo[0].aboutPartner;

      // _Family = response.datainfo[0].familyDetail[0];
      // _Partner = response.datainfo[0].partnerDetail[0];
      // _Lifestyle = response.datainfo[0].lifestyleDetail[0];
      // _Basic = response.datainfo[0].basicDetail[0];
      // _Profession = response.datainfo[0].professionalDetail[0];
      // _Hobbies = response.datainfo[0].hobbiesDetail[0].hobbiesTypes;
      // _Contact = response.datainfo[0].contactDetail[0];
      // _Astro = response.datainfo[0].astroDetail[0];
      // _Education = response.datainfo[0];


      MySharedPreferences.instance.setStringValue("image1", img1);
      MySharedPreferences.instance.setStringValue("image2", img2);
      MySharedPreferences.instance.setStringValue("image3", img3);
    });

  }


  initPreference() async{

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue(UserID.user_id, myPrefs);
    _token = MySharedPreferences.instance.getStringValue(Verify.token, myPrefs);

    await Provider.of<ProviderService>(context, listen: false).getviewbio({
      "user_id": _userid,
      "profile_id": widget.profid,
    }).then((value) => getBio(value.body));
    setState(()  {

      isLoading = true;

    });

    _joining();

    isLoading = false;

  }

  _joining(){


    if(_businesscat[0].businessTypeName != null) {
      for (int a = 0; a < _businesscat.length; a++) {
        _joinBusinesslist.add(_businesscat[a].businessTypeName);
      }
      _joinbusiness = _joinBusinesslist.join(', ');
    }

    if(_educationdetails[0].educationName != null) {
      for (int a = 0; a < _educationdetails.length; a++) {
        _joinEducationlist.add(_educationdetails[a].educationName);
      }
      _joineducation = _joinEducationlist.join(', ');
    }

    if(_hobbies[0].hobbiesName != null) {
      for (int i = 0; i < _hobbies.length; i++) {
        _joinHobbieslist.add(_hobbies[i].hobbiesName);
      }
      _joinHobbies = _joinHobbieslist.join(', ');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('$_name', style: TextStyle(color: Colors.white),),

      ),
      body: isLoading ? Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[

                CircularProgressIndicator() ,

                SizedBox(width:20.0),

                new Text("Please Wait", style:TextStyle(fontSize: 30, color: Colors.deepPurple)),

              ]
          )
      ):SingleChildScrollView(
          child: RepaintBoundary(
          key: pdfglobalKey,
          child: Container(

              child: Column(
                mainAxisSize:  MainAxisSize.min,
                  children: [
                    Stack(

                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("Assets/blurred_bg.jpg"),
                                fit: BoxFit.cover,
                              ),),

                            child: ListView(
                                shrinkWrap: true,

                                children: [
                                  CarouselSlider(
                                    items: [
                                      InkWell(
                                        onTap: ()  {

                                          if(img1 == null){
                                            flag ="0";
                                          }
                                          else{
                                            flag='$img1';
                                          }

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhoto(flag : flag)));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  image: img1==null ? AssetImage('Assets/ic_profile.png') : NetworkImage('$img1'),
                                                )
                                            )
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          if(img2 == null){
                                            flag ="0";
                                          }
                                          else{
                                            flag='$img2';
                                          }
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhoto(flag : flag)));
                                        },
                                        child: Container(

                                            margin: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  image: img2==null ?AssetImage('Assets/ic_profile.png') : NetworkImage('$img2'),
                                                )
                                            )
                                        ),),
                                      InkWell(
                                          onTap: (){
                                            if(img3 == null){
                                              flag ="0";
                                            }
                                            else{
                                              flag='$img3';
                                            }
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhoto(flag : flag)));
                                          },
                                          child: Container(
                                              width: 200,
                                              height: 200,
                                              margin: EdgeInsets.all(6.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  image: DecorationImage(
                                                    image: img3==null ?AssetImage('Assets/ic_profile.png') : NetworkImage('$img3'),
                                                  )
                                              )
                                          )
                                      ),

                                    ],
                                    options: CarouselOptions(
                                      height: MediaQuery.of(context).size.height*.33,
                                      enlargeCenterPage: true,
                                      aspectRatio: 16 / 9,
                                      enableInfiniteScroll: true,
                                      autoPlayAnimationDuration: Duration(milliseconds: 80),
                                      viewportFraction: 0.37,
                                    ),
                                  )
                                ]
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$_name, $_gender', style: TextStyle(color: Colors.white, fontSize: 20)),
                                    Text('$_age, $_height , $_tongue', style: TextStyle(color: Colors.white,)),
                                    Text('$_jain, $_sangh ', style: TextStyle(color: Colors.white,)),
                                    Text('$_city, $_state ', style: TextStyle(color: Colors.white,)),
                                    Text('$_activity', style: TextStyle(color: Colors.white,)),
                                    Text('${widget.profid}', style: TextStyle(color: Colors.white,))

                                  ],
                                )
                            ),
                          )
                        ]),
                    Container(

                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),

                      child: Text('Basic Info & Lifestyle', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),),

                    Container(

                        padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                        child: Row(
                          children: [

                            Container(
                              width: 27,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('Assets/ic_biodata_girl.png')
                                  )
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('$_age old, $_height ft., $_body, $_skin'),
                            // Expanded(
                            //
                            // ),
                          ],                                  )

                    ),
                    Container(
                        child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('Assets/ic_biodata_ring.png')
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text('$_marital'),
                                      // Expanded(
                                      //
                                      // ),
                                    ],                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('Assets/ic_biodata_girl.png')
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text('Weight : $_weight Blood Group : $_bloodgrp'),
                                      // Expanded(
                                      //
                                      // ),
                                    ],                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('Assets/ic_biodata_diet.png')
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text('Diet : $_diet'),
                                      // Expanded(
                                      //
                                      // ),
                                    ],
                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('Assets/ic_biodata_address.png')
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text('Live in $_city, $_state'),
                                      // Expanded(
                                      //
                                      // ),
                                    ],                                  )
                              )
                            ]
                        )
                    ),

                    Visibility(visible: vis_native, child: biorows('Assets/ic_biodata_nativplace.png','Native Place : $_nativeplace'),),

                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),

                      child: Text('Education', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]
                        ),
                        color: Colors.grey[200],
                      ),

                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                        child: Row(
                          children: [

                            Container(
                              width: 27,
                              height: 27,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('Assets/ic_biodata_edu.png')
                                  )
                              ),
                            ),
                            SizedBox(width: 10),

                            Text('${_joineducation}'),

                            // Expanded(
                            //
                            // ),
                          ],                                  )
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),

                      child: Text('Astro Details', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('Assets/ic_pending.png')
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text('Birth Date : $_birthdate, Time: $_birthtime'),
                                      // Expanded(
                                      //
                                      // ),
                                    ],                                  )

                    ),
                    biorows('Assets/ic_biodata_address.png','Birth Place : $_birthplace'),
                  Visibility(visible: vis_manglik,
                        child: Container(

                                  padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('Assets/ic_biodata_manglik.png')
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text('$_manglik'),
                                      // Expanded(
                                      //
                                      // ),
                                    ],                                  )

                    ),
                  ),
                                      Visibility(visible: vis_horoscope,
    child: biorows('Assets/ic_biodata_nakshtra.png','Believe in Horoscope : $_horoscope'),),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),


                      child: Text('Contact Details', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),
                    ),
                    Visibility(visible: vis_fathermob,
                    child:biorows('Assets/ic_biodata_mobile.png', 'Father Mob No: $_fathermob'),),
                                    biorows('Assets/ic_biodata_address.png', '$_residentadd'),
                    Visibility(visible: vis_officeadd,
                    child:biorows('Assets/office.png', ' $_city - $_pincode $_state'),),
                    Visibility(visible: vis_visa,
                    child:biorows('Assets/visa.png', 'Father Mob No: $_live'),),
                    Visibility(visible: vis_email,
                    child:biorows('Assets/ic_biodata_mail.png', '$_email'),),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),


                      child: Text('Family Details', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),
                    ),
                    biorows('Assets/ic_father.png', 'FATHER NAME: $_fathername '),
                    biorows('Assets/ic_mother.png', 'MOTHER NAME: $_mothername  '),
                    // Visibility(visible: vis_totalbro,
                    // child: biorows('Assets/ic_brother.png', 'Total : $_totalbro Married : $_totalmarrbro (Brother)'),),
                    // Visibility(visible: vis_totalsis,
                    // child:biorows('Assets/ic_sister.png', 'Total : $_totalsis Married : $_totalmarrsis (Sister)'),),
                    Visibility(visible: vis_familytype,
                    child: biorows('Assets/ic_biodata_cast.png', 'Total : $_familytype Family'),),
                    Visibility(visible: vis_housetype,
                    child:biorows('Assets/ic_biodata_home_address.png', '$_housetype House'),),
                    Visibility(visible: vis_fatherocc,
                    child: biorows('Assets/ic_biodata_job.png', '$_fatherocc '),),
                    Visibility(visible: vis_officetype,
                    child:biorows('Assets/office.png', 'Office Type : $_officetype '),),
                    Visibility(visible: vis_fathermob,
                    child:biorows('Assets/ic_biodata_mobile.png', 'Father Mobile Number : $_fathermob '),),
                    Visibility(visible: vis_fatherwp,
                      child:biorows('Assets/whatsapp.png', 'Father Mobile Number : $_fatherwp '),),
                    Visibility(visible: vis_mothermob,
                    child:biorows('Assets/ic_biodata_mobile.png', 'Mother Mobile Number : $_mothermob '),),
                    Visibility(visible: vis_motherwp,
                      child:biorows('Assets/whatsapp.png', 'Mother Whatsapp : $_motherwp '),),

                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),


                      child: Text('Background', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),
                    ),
                    biorows('Assets/ic_biodata_cast.png', '$_jain '),
                    biorows('Assets/ic_biodata_langauge.png', '$_tongue '),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),


                      child: Text('Occupation Details', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                        child: Row(
                          children: [

                            SizedBox(width: 10),
                            Text('Current Status : $_activity '),
                            // Expanded(
                            //
                            // ),
                          ],                                  )
                    ),

                      //  padding: EdgeInsets.only(right: 5, left: 10, top: 7),
                        Row(
                          children: [

                            SizedBox(width: 10),
                            Expanded(child:Text('Occupation Type : $_joinbusiness'),),
                            // Expanded(
                            //
                            // ),
                          ],                                  ),

                    SizedBox(height: 5.0,),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width*.99,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10.0),


                      child: Text('Hobbies & other', style: TextStyle(color: Colors.red),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]),
                        color: Colors.grey[200],
                      ),
                    ),
                    biorows('Assets/ic_biodata_hobby.png', '$_joinHobbies'),


                  ]
              )
          ),
          ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
                  InkWell(
                  onTap: (){
            Navigator.pop(context);
            },
              child:
                Container(
                  width: MediaQuery.of(context).size.width*.33,
                  height: 70,
                child:Column(
                    children:[
                      SizedBox(height: 5,),
                      Container(
                        width: 30,
                        height: 27,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('Assets/ic_close_matrimony.png'),
                            )
                        ),

                      ),
                      SizedBox(height: 10,),
                      Text('NOT NOW',style: TextStyle(color: Colors.grey),),
                    ]
                )
              ),
            ),
            InkWell(
              onTap: (){
                takeScreenshot();
              },
              child: Container(
                  width: MediaQuery.of(context).size.width*.33,
                height: 65,
                child:Column(
                    children:[
                      SizedBox(height: 5,),
                      Container(
                        width: 30,
                        height: 27,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('Assets/ic_share_matrimony.png'),
                            )
                        ),

                      ),
                      SizedBox(height: 10,),
                      Text('Share Biodata',style: TextStyle(color: Colors.grey),),
                    ]
                )
            ),

            ),
            InkWell(
              onTap: () async {
                await Provider.of<ProviderService>(context, listen: false).getviewbio({"user_id": _userid, "profile_id": widget.profid,
                }).then((value) => getBio(value.body));
              },
            child: Container(
                width: MediaQuery.of(context).size.width*.33,
              height: 70,
              child:Column(
              children:[
                SizedBox(height: 5,),
              Container(
                width: 30,
              height: 27,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/ic_send.png'),

                )
              ),

            ),
                SizedBox(height: 10,),
                Text('Add to Favourite', style: TextStyle(color: Colors.grey),),
              ]
            )
            ),
            ),
          ],
        ),
      ),
    );
  }
  takeScreenshot() async {
    RenderRepaintBoundary boundary = pdfglobalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    print(pngBytes);
    File imgFile = new File('$directory/screenshot.png');
    setState(() {
      _imageFile = imgFile;
    });
    //_savefile(_imageFile);
    //saveFileLocal();
    imgFile.writeAsBytes(pngBytes);
    _printScreen(imgFile);

  }

  _savefile(File file) async {

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }

  void _printScreen(File _imageFile) async{
 
      final doc = pw.Document();
      final directory = (await getApplicationDocumentsDirectory()).path;
      final image = pw.MemoryImage(
        File('$directory/screenshot.png').readAsBytesSync(),
      );

      final format = PdfPageFormat(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return  pw.Center(
                child:pw.Column(
                children:[
                   pw.Expanded(
                child: pw.Image(image),

              ),
                  pw.SizedBox(height: 5.0),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
            children:[
              pw.Container(),
              pw.Container(
              child: pw.Text('Biodata created by JITO Ahmedabad Matrimonial Mobile App', style: pw.TextStyle(fontSize: 10.0)),),
            ]),
            ]),
            );
          }));
      Uint8List bytes = await doc.save();
      print('Directory    $directory');
      await File('$directory/outputbio.pdf').writeAsBytes(bytes);
      Share.shareFiles(['$directory/outputbio.pdf'],
        subject: 'URL File Share',
        text: 'Hello, check your share files!',
      );

  }

}