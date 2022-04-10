import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:jito_matrimony/EditActivity/Biodata.dart';
import 'package:jito_matrimony/EditActivity/Contact_edit.dart';
import 'package:jito_matrimony/EditActivity/Professional_edit.dart';
import 'package:jito_matrimony/EditActivity/ViewPhoto.dart';
import 'package:jito_matrimony/EditActivity/state_list.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/EditActivity/Basic_edit.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditActivity/Astro_edit.dart';
import 'EditActivity/Education_edit.dart';
import 'EditActivity/Family_edit.dart';
import 'EditActivity/Hobby_edit.dart';
import 'EditActivity/Lifestyle_edit.dart';
import 'EditActivity/Partner_edit.dart';
import 'EditActivity/city_list.dart';
import 'constants.dart';

class Edit_Biodata extends StatefulWidget{

  Edit_Page createState() => Edit_Page();
}

class CityList{
  String city_name;
  String city_id;
  String state_id;

  CityList(this.city_name, this.city_id, this.state_id);
}

class StatList{
  String state_name;
  String country_id;
  String state_id;

  StatList(this.state_name, this.state_id, this.country_id);
}


class Edit_Page extends State<Edit_Biodata> {

  SharedPreferences myPrefs;
  String _name;
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
  var _hobbies;
  String _educationdetails, _academics;

  String _residentadd, _city, _state, _country, _pincode, _landline, _email, _wp, _live, _candidatemob, _visa;

  String _height, _weight, _bloodgrp, _spects, _skin, _body, _diet, _disease, _facebook, _instagram, _linkedin;

  String _aboutme, _aboutpartner, _partnerheightmax, _partnerheightmin, _partneragemin, _partneragemax, _partnermanglik, _partnerbody, _partnermarital, _partnerworkcategory, _partnereducation, _partnerskin;

  String _fathername, _mothername, _totalbro, _totalmarrbro, _totalsis, _totalmarrsis, _familytype, _housetype, _fatherocc, _officetype, _fatheroffadd, _fathermob, _fatheroffno, _mothermob, _motherwp, _fatherwp;

  String _officeadd, _workwith, _designation, _businesscat, _occupationdet;

  String img1, img2 , img3;

  String path;

  String _userid, _token;

  String flag;

  String _joinHobbies = " ";
  List<CityList> listcity = <CityList>[CityList("Select", '0', '0')];
  List<StatList> liststate = <StatList>[StatList("Select", '0', '0')];
  List<String> _joinHobbieslist = [];

  var _Family, _Partner, _Profession, _Lifestyle, _Hobbies, _Basic, _Astro, _Education, _Contact;

  bool isLoading;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    initPreference();

    path = 'Assets/ic_profile.png';
  }

  getBioid(Biodata response){


    setState(() {

      img1 = response.datainfo[0].img1;
      img2 = response.datainfo[0].imgDetail[0].img2;
      img3 = response.datainfo[0].imgDetail[0].img3;

      _name = response.datainfo[0].basicDetail[0].name;
      _gender = response.datainfo[0].basicDetail[0].gender;
      _birthdate = response.datainfo[0].basicDetail[0].dateOfBirth;
      _tongue = response.datainfo[0].basicDetail[0].motherToungue;
      _jain = response.datainfo[0].basicDetail[0].jainSampradaya;
      _sangh = response.datainfo[0].basicDetail[0].sangh;
      _gnyati = response.datainfo[0].basicDetail[0].gnyati;
      _disability = response.datainfo[0].basicDetail[0].physicalDisability;
      _disabilityyes = response.datainfo[0].basicDetail[0].physicalDisabilityYes;
      _birthtime = response.datainfo[0].basicDetail[0].timeOfBirth;
      _birthplace = response.datainfo[0].basicDetail[0].placeOfBirth;
      _marital = response.datainfo[0].basicDetail[0].maritalStatus;
      _activity = response.datainfo[0].basicDetail[0].currentActivity;
      _nativeplace = response.datainfo[0].basicDetail[0].nativePlace;

      _manglik = response.datainfo[0].astroDetail[0].manglik;
      _horoscope = response.datainfo[0].astroDetail[0].horoscope;

      _residentadd = response.datainfo[0].contactDetail[0].residenceAddress;
      _pincode = response.datainfo[0].contactDetail[0].pincode;
      _landline = response.datainfo[0].contactDetail[0].landlineNo;
      _email = response.datainfo[0].contactDetail[0].contactEmail;
      _country = response.datainfo[0].contactDetail[0].countryName;
      _state = response.datainfo[0].contactDetail[0].stateName;
      _city = response.datainfo[0].contactDetail[0].cityName;
      _live = response.datainfo[0].contactDetail[0].liveswithfmlyn;
      _visa = response.datainfo[0].contactDetail[0].visaStatus;
      _wp = response.datainfo[0].contactDetail[0].candWhatsappno;
      _candidatemob = response.datainfo[0].contactDetail[0].mobileNo;

      _fathername = response.datainfo[0].familyDetail[0].fatherName;
      _mothername = response.datainfo[0].familyDetail[0].motherName;
      _totalbro = response.datainfo[0].familyDetail[0].totalBrother;
      _totalmarrbro = response.datainfo[0].familyDetail[0].totalMarriedBrother;
      _totalsis  = response.datainfo[0].familyDetail[0].totalSister;
      _totalmarrsis = response.datainfo[0].familyDetail[0].totalMarriedSister;
      _housetype = response.datainfo[0].familyDetail[0].houseType;
      _fatherocc = response.datainfo[0].familyDetail[0].fatherOccupation;
      _familytype = response.datainfo[0].familyDetail[0].familyType;
      _fatheroffadd = response.datainfo[0].familyDetail[0].fatherOfficeAddress;
      _fatheroffno = response.datainfo[0].familyDetail[0].fatherOfficeNo;
      _fathermob = response.datainfo[0].familyDetail[0].fatherMobileNo;
      _fatherwp = response.datainfo[0].familyDetail[0].fatherWhatsapp;
      _motherwp = response.datainfo[0].familyDetail[0].motherWhatsapp;
      _mothermob = response.datainfo[0].familyDetail[0].motherMob;

      _height = response.datainfo[0].lifestyleDetail[0].height;
      _weight= response.datainfo[0].lifestyleDetail[0].weight;
      _bloodgrp = response.datainfo[0].lifestyleDetail[0].bloodGroup;
      _spects = response.datainfo[0].lifestyleDetail[0].spects;
      _skin = response.datainfo[0].lifestyleDetail[0].skinTone;
      _body = response.datainfo[0].lifestyleDetail[0].bodyType;
      _diet = response.datainfo[0].lifestyleDetail[0].dietType;
      _disease = response.datainfo[0].lifestyleDetail[0].disease;
      _facebook = response.datainfo[0].lifestyleDetail[0].socialFacebook;
      _instagram = response.datainfo[0].lifestyleDetail[0].socialInstagram;
      _linkedin = response.datainfo[0].lifestyleDetail[0].socialLinkedin;

      _workwith = response.datainfo[0].professionalDetail[0].workingWith;
      _businesscat = response.datainfo[0].professionalDetail[0].buisnessType;
      _designation = response.datainfo[0].professionalDetail[0].designationName;
      _occupationdet = response.datainfo[0].professionalDetail[0].occupationDet;
      _officeadd = response.datainfo[0].professionalDetail[0].officeAddress;

      _hobbies = response.datainfo[0].hobbiesDetail[0].hobbiesTypes;

      _educationdetails = response.datainfo[0].educationDetail[0].educationDetails;
      _academics = response.datainfo[0].educationDetail[0].academicsDet;

      _partnerworkcategory = response.datainfo[0].partnerDetail[0].partnerWorkingCategory;
      _partnereducation = response.datainfo[0].partnerDetail[0].partnerEducation;
      _partnermarital = response.datainfo[0].partnerDetail[0].partnerMeritalStatus;
      _partnerbody = response.datainfo[0].partnerDetail[0].partnerBodyType;
      _partnermanglik = response.datainfo[0].partnerDetail[0].partnerNamglic;
      _partnerheightmax = response.datainfo[0].partnerDetail[0].partnerHeightMax;
      _partnerheightmin = response.datainfo[0].partnerDetail[0].partnerHeightMin;
      _partneragemax = response.datainfo[0].partnerDetail[0].partnerAgeMax;
      _partneragemin = response.datainfo[0].partnerDetail[0].partnerAgeMin;
      _partnerskin = response.datainfo[0].partnerDetail[0].partnerSkintone;
      _aboutme = response.datainfo[0].partnerDetail[0].aboutMe;
      _aboutpartner = response.datainfo[0].partnerDetail[0].aboutPartner;

      _Family = response.datainfo[0].familyDetail[0];
      _Partner = response.datainfo[0].partnerDetail[0];
      _Lifestyle = response.datainfo[0].lifestyleDetail[0];
      _Basic = response.datainfo[0].basicDetail[0];
      _Profession = response.datainfo[0].professionalDetail[0];
      _Hobbies = response.datainfo[0].hobbiesDetail[0].hobbiesTypes;
      _Contact = response.datainfo[0].contactDetail[0];
      _Astro = response.datainfo[0].astroDetail[0];
      _Education = response.datainfo[0];


      MySharedPreferences.instance.setStringValue("image1", img1);
      MySharedPreferences.instance.setStringValue("image2", img2);
      MySharedPreferences.instance.setStringValue("image3", img3);
    });

  }


  initPreference() async{

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue(UserID.user_id, myPrefs);
    _token = MySharedPreferences.instance.getStringValue(Verify.token, myPrefs);

    await Provider.of<ProviderService>(context, listen: false).getBiodata({"user_id": _userid, "token": _token}).then((value) => getBioid(value.body));
    setState(()  {

      isLoading = true;


      initpref();
      // await Provider.of<ProviderService>(context, listen: false).getCity({}).then((
      //     value) => ListCity(value.body));

    });

    if(_hobbies[0].hobbiesName != null){
      _joining();
    }


    isLoading = false;



  }

  _joining(){



    for(int i =0; i<_hobbies.length; i++){
      _joinHobbieslist.add(_hobbies[i].hobbiesName);

    }
    _splitting();
  }

  _splitting(){
    _joinHobbies = _joinHobbieslist.join(',');
  }

  initpref() async{

    await Provider.of<ProviderService>(context, listen: false).getState({}).then((
        value) => ListState(value.body));


    await Provider.of<ProviderService>(context, listen: false).getCity({}).then((
        value) => ListCity(value.body));
  }


  ListState(state_list body) {

    setState(() {
      for (int i = 0; i < 4119; i++) {
        var res = body.datainfo[i];

        liststate.add(StatList(body.datainfo[i].stateName.toString(),
            body.datainfo[i].stateId.toString(),
            body.datainfo[i].countryId.toString()));

      }
      print('statteeeeeeeeeeeee enddd');
    });
  }


  ListCity(city_list body) {

    setState(() {
      print("citytyty start");

      for (int i = 0; i < 48354; i++) {
        var res = body.datainfo[i];

        listcity.add(CityList(body.datainfo[i].cityName.toString(), body.datainfo[i].cityId.toString(), body.datainfo[i].stateId.toString()));

      }
      print(" CItyyyyy End");
    });



  }

  @override dispose(){
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text('Edit Biodata', style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(thickness: 1.0, color: Colors.white,),
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 5,),
                  Text('Delete  ', style: TextStyle(color: Colors.white, fontSize: 17))
                ],
              ),
            ),

          ]
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
        child: Container(

          child: Column(

              children: [
          Container(
          decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/blurred_bg.jpg"),
          fit: BoxFit.cover,
        ),),
      child:ListView(
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
                height: 200.0,
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
      ]
    )
    )
    )
    );
  }
}