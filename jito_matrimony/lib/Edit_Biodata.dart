import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:jito_matrimony/EditActivity/Biodata.dart';
import 'package:jito_matrimony/EditActivity/Contact_edit.dart';
import 'package:jito_matrimony/EditActivity/Professional_edit.dart';
import 'package:jito_matrimony/EditActivity/ViewPhoto.dart';
import 'package:jito_matrimony/EditActivity/addbiodata.dart';
import 'package:jito_matrimony/EditActivity/state_list.dart';
import 'package:jito_matrimony/ProviderService.dart';
import 'package:jito_matrimony/Widgets/rows.dart';
import 'package:jito_matrimony/EditActivity/Basic_edit.dart';
import 'package:jito_matrimony/utils/MySharedPreferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'EditActivity/Astro_edit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'EditActivity/Education_edit.dart';
import 'EditActivity/Family_edit.dart';
import 'EditActivity/Hobby_edit.dart';
import 'EditActivity/Lifestyle_edit.dart';
import 'EditActivity/Partner_edit.dart';
import 'EditActivity/city_list.dart';
import 'EditActivity/editdoc.dart';
import 'ViewDoc.dart';
import 'constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'homepage.dart';

class Edit_Biodata extends StatefulWidget{

  String flag;
  Edit_Biodata({this.flag});

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
  String _bioid;

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

  var _hobbies, _educationdetails, _partnereducationlist, _partnerworkcategory;

  String  _academics;

  String _residentadd, _city, _state, _country, _pincode, _landline, _email, _wp, _live, _candidatemob, _visa;

  String _height, _weight, _bloodgrp, _spects, _skin, _body, _diet, _disease, _facebook, _instagram, _linkedin;

  String _aboutme, _aboutpartner, _partnerheightmax, _partnerheightmin, _partneragemin, _partneragemax, _partnermanglik, _partnerbody, _partnermarital, _partnerskin;

  String _fathername, _mothername, _totalbro, _totalmarrbro, _totalsis, _totalmarrsis, _familytype, _housetype, _fatherocc, _officetype, _fatheroffadd, _fathermob, _fatheroffno, _mothermob, _motherwp, _fatherwp;

  String _officeadd, _workwith, _designation, _businesscat, _occupationdet;
  
  String img1, img2 , img3;

  String imgdoc1, imgdoc2;

  String path;
  
  String _userid, _token;

  String flag1, flag2, flag3, flag4, flag5, flag6, flagtest;

  String _joinHobbies = " ";
  String _joinEducation = " ";
  String _joinpartnereducation ='';
  String _joinpartnerwork ="";
  List<CityList> listcity = <CityList>[CityList("Select", '0', '0')];
  List<StatList> liststate = <StatList>[StatList("Select", '0', '0')];
  List<String> _joinHobbieslist = [];
  List<String> _joineducationlist = [];
  List<String> _partnereducation =[];
  List<String> _partnerworklist =[];

  var _Family, _Partner, _Profession, _Lifestyle, _Hobbies, _Basic, _Astro, _Education, _Contact;

  bool isLoading;
  VideoPlayerController _playerController;
  Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    initPreference();

    path = 'Assets/ic_profile.png';


        }

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

                Navigator.pop(context);
                Navigator.pop(context);

            },
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () async {


              if(widget.flag=="0"){

                await Provider.of<ProviderService>(context, listen: false)
                    .addBiodata({"user_id": _userid,
                  "token": _token,
                  "biodata_person":"self"
                }).then((value) => addingBioData(value.body));

              }
            },

            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  addingBioData(addbiodata resp) async {

    if(resp.status == 200){
      setState(() {
        _bioid = resp.datainfo.bioId;
        MySharedPreferences.instance.setStringValue("bio_id", _bioid);
      });

      await Provider.of<ProviderService>(context, listen: false)
          .getBasicdetail({"user_id": _userid,
        "token": _token,
        "bio_id": _bioid,
        "name": _name,
        "physicalsisability": _disability,
        "gender": _gender,
        "marital_status": _marital,
        "sang": _sangh,
        "gnyati": _gnyati,
        "date_of_birth": _birthdate,
        "time_of_birth": _birthtime,
        "place_of_birth": _birthplace,
        "mother_tonge": _tongue,
        "jain_sampraadaya": _jain,
        "current_activity": _activity,
        "disabiliy_yes": _disability,
        "physicaldisability_yes": _disabilityyes,
        "native_place": _nativeplace,
      }).then((value) => (value.body));

      await Provider.of<ProviderService>(context, listen: false)
          .addLifestyle({"user_id": _userid,
        "token": _token,
        "bio_id": _bioid,
        "height": _height,
        "weight": _weight,
        "blood_group": _bloodgrp,
        "spects": _spects,
        "skin_tone": _skin,
        "body_type": _body,
        "diet": _diet,
        "facebook_profile_url": _facebook,
        "instagram_profile_url": _instagram,
        "linkedin_profile_url": _linkedin,
        "disease": _disease,
        "social_facebook": _facebook,
        "social_instagram": _instagram,
        "social_linkedin": _linkedin
      }).then((value) => (value.body));

      await Provider.of<ProviderService>(context, listen: false)
          .addContact({"user_id": _userid,
        "token": _token,
        "bio_id": _bioid,
        "city": _city,
        "country": _country,
        "state": _state,
        "pincode": _pincode,
        "landline_no": _landline,
        "contact_no": _candidatemob,
        "email": _email,
        "residant_address": _residentadd,
        "visa_status": _visa,
        "cand_whatsappno": _wp,
        "liveswithfmlyn": _live,

      })
          .then((value) => (value.body));


      await Provider.of<ProviderService>(context, listen: false)
          .addeducation({
        "academics_det": _academics,
        "user_id": _userid,
        "token": _token,
        "bio_id": _bioid,
        "education_details": _joinEducation
      }).then((value) => (value.body));

      await Provider.of<ProviderService>(context, listen: false).addAstro({"user_id":_userid,
        "token":_token,
        "bio_id":_bioid,
        "manglik": _manglik,
        "horoscope": _horoscope,
      }).then((value) => (value.body));

      await Provider.of<ProviderService>(context, listen: false).addHobbies({"user_id":_userid,
        "token": _token,
        "bio_id":_bioid,
        "hobbies": _hobbies,
      }).then((value) =>(value.body));

      await Provider.of<ProviderService>(context, listen: false)
          .addFamily({"user_id": _userid,
        "token": _token,
        "bio_id": _bioid,
        "father_name": _fathername,
        "mother_name": _mothername,
        "total_brother": _totalbro,
        "total_married_brother": _totalmarrbro,
        "total_sister": _totalsis,
        "total_married_sister": _totalmarrsis,
        "mother_whatsapp": _motherwp,
        "family_type": _familytype,
        "house_type": _housetype,
        "father_occupation": _fatherocc,
        "office_type": _officetype,
        "father_office_address": _officeadd,
        "father_mobile_no": _fathermob,
        "father_office_no": _fatheroffno,
        "father_whatsapp": _fatherwp,
        "mother_mob": _mothermob
      })
          .then((value) =>(value.body));

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);

    }
  }
  
  getBioid(Biodata response){

    if(response.status == 400){
      Navigator.push(context, MaterialPageRoute(builder: (context) => BasicDetails()));
    }
    else {

      setState(() {
        img1 = response.datainfo[0].img1;

        if (response.datainfo[0].imgDetail != null) {
          img2 = response.datainfo[0].imgDetail[0].img2 != null ? response.datainfo[0].imgDetail[0].img2 : "";
          img3 =  response.datainfo[0].imgDetail[0].img3 != null ? response.datainfo[0].imgDetail[0].img3 : "";
        }
        if (response.datainfo[0].certificateDetail != null) {
          imgdoc1 = response.datainfo[0].certificateDetail[0].photoProof;
          imgdoc2 = response.datainfo[0].certificateDetail[0].eduProof;
        }
        _name = response.datainfo[0].basicDetail[0].name;
        _gender = response.datainfo[0].basicDetail[0].gender;
        _birthdate = response.datainfo[0].basicDetail[0].dateOfBirth;
        _tongue = response.datainfo[0].basicDetail[0].motherToungue;
        _jain = response.datainfo[0].basicDetail[0].jainSampradaya;
        _sangh = response.datainfo[0].basicDetail[0].sangh;
        _gnyati = response.datainfo[0].basicDetail[0].gnyati;
        _disability = response.datainfo[0].basicDetail[0].physicalDisability;

        _disabilityyes =
            response.datainfo[0].basicDetail[0].physicalDisabilityYes;
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
        _totalsis = response.datainfo[0].familyDetail[0].totalSister;
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
        _officetype = response.datainfo[0].familyDetail[0].officeType;

        _height = response.datainfo[0].lifestyleDetail[0].height;
        _weight = response.datainfo[0].lifestyleDetail[0].weight;
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

        _educationdetails = response.datainfo[0].educationDetail[0].educationTypes;
        _academics = response.datainfo[0].educationDetail[0].academicsDet;

        _partnerworkcategory = response.datainfo[0].partnerDetail[0].workingCategoryTypes;
        _partnereducationlist = response.datainfo[0].partnerDetail[0].educationTypes;
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
        // print('HObbibiess  =  ---  ${_Hobbies[0].hobbiesName}');
        _Contact = response.datainfo[0].contactDetail[0];
        _Astro = response.datainfo[0].astroDetail[0];
        _Education = response.datainfo[0];

        _playerController = VideoPlayerController.network(
            '${response.datainfo[0].videosample}');
        print('platere contorll ${response.datainfo[0].videosample}');

        _initializeVideoPlayerFuture = _playerController.initialize();
        _playerController.setLooping(true);


        MySharedPreferences.instance.setStringValue("image1", img1);
        MySharedPreferences.instance.setStringValue("image2", img2);
        MySharedPreferences.instance.setStringValue("image3", img3);
        MySharedPreferences.instance.setStringValue("imagedoc1", imgdoc1);
        MySharedPreferences.instance.setStringValue("imagedoc2", imgdoc2);
      });
    }
  }


  initPreference() async{

    myPrefs = await SharedPreferences.getInstance();
    _userid = MySharedPreferences.instance.getStringValue(UserID.user_id, myPrefs);
    _token = MySharedPreferences.instance.getStringValue(Verify.token, myPrefs);

    print("toke is here $_token");

    await Provider.of<ProviderService>(context, listen: false).getBiodata({"user_id": _userid, "token": _token}).then((value) => getBioid(value.body));
    setState(()  {

      isLoading = true;

      if(widget.flag == "0") {
        _name = MySharedPreferences.instance.getStringValue("name", myPrefs);
        _birthplace = MySharedPreferences.instance.getStringValue("date_of_birth", myPrefs);
        _sangh = MySharedPreferences.instance.getStringValue("sang", myPrefs);
        _gnyati = MySharedPreferences.instance.getStringValue("gnyati", myPrefs);
        _nativeplace = MySharedPreferences.instance.getStringValue("place_of_birth", myPrefs);
        _gender = MySharedPreferences.instance.getStringValue("gender", myPrefs);
        _disability = MySharedPreferences.instance.getStringValue("physicaldisablity", myPrefs);
        _disabilityyes = MySharedPreferences.instance.getStringValue("physicaldisablity_yes", myPrefs);
        _marital = MySharedPreferences.instance.getStringValue("marital_status", myPrefs);
        _activity = MySharedPreferences.instance.getStringValue("current_activity", myPrefs);
        _jain = MySharedPreferences.instance.getStringValue("jain_sampraadaya", myPrefs);
        _tongue = MySharedPreferences.instance.getStringValue("mother_tongue", myPrefs);
        _birthtime = MySharedPreferences.instance.getStringValue("time_of_birth", myPrefs);
        _birthdate = MySharedPreferences.instance.getStringValue("date_of_birth", myPrefs);
        _manglik = MySharedPreferences.instance.getStringValue("manglik", myPrefs);
        _horoscope = MySharedPreferences.instance.getStringValue("horoscope", myPrefs);
        _hobbies = MySharedPreferences.instance.getStringValue("hobbies", myPrefs);
        _workwith = MySharedPreferences.instance.getStringValue("working_with", myPrefs);
        _businesscat = MySharedPreferences.instance.getStringValue("business_category", myPrefs);
        _designation = MySharedPreferences.instance.getStringValue("designation", myPrefs);
        _officeadd = MySharedPreferences.instance.getStringValue("office_address", myPrefs);
        _occupationdet = MySharedPreferences.instance.getStringValue("occupation_details", myPrefs);
        _educationdetails = MySharedPreferences.instance.getStringValue("education_details", myPrefs);

        _aboutme =
            MySharedPreferences.instance.getStringValue("about_me", myPrefs);
        _aboutpartner = MySharedPreferences.instance.getStringValue(
            "about_partner", myPrefs);
        _partneragemin = MySharedPreferences.instance.getStringValue(
            "partner_age_min", myPrefs);
        _partneragemax = MySharedPreferences.instance.getStringValue(
            "partner_age_max", myPrefs);
        _partnerheightmin = MySharedPreferences.instance.getStringValue(
            "partner_height_min", myPrefs);
        _partnerheightmax = MySharedPreferences.instance.getStringValue(
            "partner_height_max", myPrefs);
        _partnermanglik = MySharedPreferences.instance.getStringValue(
            "partner_manglic", myPrefs);
        _partnerbody = MySharedPreferences.instance.getStringValue(
            "partner_body_type", myPrefs);
        _partnermarital = MySharedPreferences.instance.getStringValue(
            "partner_marital_status", myPrefs);
        // _partnereducation = MySharedPreferences.instance.getStringValue(
        //     "partner_education", myPrefs);
        _partnerskin = MySharedPreferences.instance.getStringValue(
            "partner_skin_tone", myPrefs);
        _partnerworkcategory = MySharedPreferences.instance.getStringValue(
            "partner_work_category", myPrefs);

        _fathername =
            MySharedPreferences.instance.getStringValue("father_name", myPrefs);
        _mothername =
            MySharedPreferences.instance.getStringValue("mother_name", myPrefs);
        _totalbro = MySharedPreferences.instance.getStringValue(
            "total_brother", myPrefs);
        _totalmarrbro = MySharedPreferences.instance.getStringValue(
            "total_married_brother", myPrefs);
        _totalsis = MySharedPreferences.instance.getStringValue(
            "total_sister", myPrefs);
        _totalmarrsis = MySharedPreferences.instance.getStringValue(
            "total_married_sister", myPrefs);
        _familytype =
            MySharedPreferences.instance.getStringValue("family_type", myPrefs);
        _housetype =
            MySharedPreferences.instance.getStringValue("house_type", myPrefs);
        _fatherocc = MySharedPreferences.instance.getStringValue(
            "father_occupation", myPrefs);
        _officetype =
            MySharedPreferences.instance.getStringValue("office_type", myPrefs);
        _fatheroffadd = MySharedPreferences.instance.getStringValue(
            "father_office_address", myPrefs);
        _fathermob = MySharedPreferences.instance.getStringValue(
            "father_mobile_no", myPrefs);
        _fatheroffno = MySharedPreferences.instance.getStringValue(
            "father_office_no", myPrefs);

        _height =
            MySharedPreferences.instance.getStringValue("height", myPrefs);
        _weight =
            MySharedPreferences.instance.getStringValue("weight", myPrefs);
        _bloodgrp =
            MySharedPreferences.instance.getStringValue("blood_group", myPrefs);
        _spects =
            MySharedPreferences.instance.getStringValue("spects", myPrefs);
        _skin =
            MySharedPreferences.instance.getStringValue("skin_tone", myPrefs);
        _body =
            MySharedPreferences.instance.getStringValue("body_type", myPrefs);
        _diet = MySharedPreferences.instance.getStringValue("diet", myPrefs);
        _disease = MySharedPreferences.instance.getStringValue("disease", myPrefs);

        _residentadd = MySharedPreferences.instance.getStringValue("residant_address", myPrefs);
        _city = MySharedPreferences.instance.getStringValue("city", myPrefs);
        _state = MySharedPreferences.instance.getStringValue("state", myPrefs);
        _country =
            MySharedPreferences.instance.getStringValue("country", myPrefs);
        _pincode =
            MySharedPreferences.instance.getStringValue("pincode", myPrefs);
        _landline =
            MySharedPreferences.instance.getStringValue("landline_no", myPrefs);
        _candidatemob =
            MySharedPreferences.instance.getStringValue("contact_no", myPrefs);
        _email = MySharedPreferences.instance.getStringValue("email", myPrefs);
        _visa = MySharedPreferences.instance.getStringValue("visa", myPrefs);
        _live = MySharedPreferences.instance.getStringValue("live", myPrefs);
        _email = MySharedPreferences.instance.getStringValue("email", myPrefs);
      }
      initpref();
      // await Provider.of<ProviderService>(context, listen: false).getCity({}).then((
      //     value) => ListCity(value.body));

    });


      _joining();


    isLoading = false;
    
  }

  _joining(){


    if(_hobbies != null) {
      for (int i = 0; i < _hobbies.length; i++) {

        _joinHobbieslist.add(_hobbies[i].hobbiesName);
      }
      _joinHobbies = _joinHobbieslist.join(', ');
    }
    if(_educationdetails != null){

      for (int i = 0; i < _educationdetails.length; i++) {
        print("hobbiirsss ${_educationdetails[i].educationName}");

        _joineducationlist.add(_educationdetails[i].educationName);
      }
      _joinEducation = _joineducationlist.join(', ');
    }
    if(_partnereducationlist !=null){
      for(int i=0; i<_partnereducationlist.length;i++){
        _partnereducation.add(_educationdetails[i].educationName);
      }
      _joinpartnereducation = _partnereducation.join(', ');
    }
    print("in work");
    if(_partnerworkcategory != null){
      for(int i =0; i< _partnerworkcategory.length;i++){
        _partnerworklist.add(_partnerworkcategory[i].business_type_name);
      }
      _joinpartnerwork = _partnerworklist.join(', ');
    }
    print("out work");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text('Edit Biodata', style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            InkWell(
                onTap:(){
                Fluttertoast.showToast(
                msg: "Please Contact Jito Office",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 20.0
                );
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homepage()), (route) => false);
    },
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(thickness: 1.0, color: Colors.white,),
                      Icon(Icons.delete, color: Colors.white),
                      SizedBox(width: 5,),

                      Text('Delete  ', style: TextStyle(color: Colors.white, fontSize: 17)),
                ],
              ),
            ),
            )
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
                      flag1 ="0";
                    }
                    else{
                      flag1 ='$img1';
                    }

                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhoto(flag : flag1, flagtest : "1", edvi: true,)));
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
                        flag2 ="0";
                      }
                      else{
                        flag2='$img2';
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhoto(flag : flag2, flagtest : "2", edvi: true,)));
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
                              flag3 = "0";
                          }
                          else{
                            flag3 =  '$img3';
                          }
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPhoto(flag : flag3, flagtest : "3", edvi: true,)));
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
            Container(
              child: Card(

              shape: RoundedRectangleBorder(
              side: new BorderSide(color : Colors.grey,),
             borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),

                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                    borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                      child:Container(

                        decoration: new BoxDecoration (
                        border: Border.all(
                        color : HexColor('#dac8fa'),
                ),

                ),

                        child: ListView(
                        shrinkWrap: true,

                        children :<Widget>[
                                    //color: Colors.deepOrangeAccent,
                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BasicDetails(Basic: _Basic, flag:"1")));
                            } ,
                          child: ListTile(
                              dense: true,
                                tileColor: HexColor('#dac8fa'),
                                title: new Text('BASIC DETAILS', style: TextStyle(fontSize: 14),),
                              trailing:   FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                      Text('EDIT', style: TextStyle( ),),
                                      SizedBox(width: 8,),
                                      Icon(Icons.edit),
                                ])
                              ),
                        ),
                          )
    ]
    )

    ),
    ),

                    Container(
                      padding: EdgeInsets.all(4.0),
                     child: rows("*Name", _name),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*GENDER", _gender),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*DATE OF BIRTH", _birthdate),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("TIME OF BIRTH", _birthtime),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("PLACE OF BIRTH", _birthplace),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*MOTHER TONGUE", _tongue),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*JAIN SAMPRADAYA", _jain),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("NATIVE PLACE", _nativeplace),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),

                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(flex: 1,
                              child: Text(" SANGH ", style: TextStyle(fontSize: 15.0,),),
                            ),

                            Expanded(
                                flex: 3,
                                child: Text(" $_sangh", style: TextStyle(fontSize: 15.0,),)

                            )
                          ]

                      ),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("GNYATI", _gnyati),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*PHYSICAL DISABILITY", _disability),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*MARITAL STATUS", _marital),
                    ),
                    Divider(thickness: 0.5,),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: rows("*CURRENT ACTIVITY", _activity),
                    ),


            ]
    )
    )
            ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                  InkWell(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LifeStyleDetails(Lifestyle: _Lifestyle, flag:"1")));
                                      } ,
                                    child: ListTile(
                                          dense: true,
                                          tileColor: HexColor('#dac8fa'),
                                          title: new Text('LIFESTYLE DETAILS', style: TextStyle(fontSize: 14),),
                                          trailing:   FittedBox(
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[
                                                    Text('EDIT', style: TextStyle( ),),
                                                    SizedBox(width: 8,),
                                                    Icon(Icons.edit),
                                                  ])
                                          ),
                                        )
                                  )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*HEIGHT", _height),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("WEIGHT", _weight),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("BLOOD GROUP", _bloodgrp),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("SPECTS", _spects),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("SKIN TONE", _skin),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("BODY TYPE", _body),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("DIET", _diet),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("PERMANENT DISEASE", _disease),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" FACEBOOK PROFILE URL ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_facebook", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" INSTAGRAM PROFILE URL ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_instagram", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" LINKEDIN PROFILE URL ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_linkedin", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),

                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                        InkWell(
                                            onTap : (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetails(Contact: _Contact, listcity: listcity, liststate: liststate, flag:"1")));
                                            },
                                            child: ListTile(
                                              dense: true,
                                              tileColor: HexColor('#dac8fa'),
                                              title: new Text('CONTACT DETAILS', style: TextStyle(fontSize: 14),),
                                              trailing:   FittedBox(
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        Text('EDIT', style: TextStyle( ),),
                                                        SizedBox(width: 8,),
                                                        Icon(Icons.edit),
                                                      ])
                                              ),
                                            )
                                        )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" *FAMILY RESIDENCE ADDRESS ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_residentadd", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*CITY", _city),
                            ),

                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*STATE", _state),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*COUNTRY", _country),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("PINCODE", _pincode),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("LANDLINE NO", _landline),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("CANDIDATE LIVE WITH FAMILY?", _live),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("VISA STATUS", _visa),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*CANDIDATE MOBILE NUMBER", _candidatemob),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("CANDIDATE WHATSAPP NO.", _wp),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" CANDIDATE EMAIL ID ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_email", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),

                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                        InkWell(
                                            onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetails(Education_: _joineducationlist, academics: _academics, flag: '1')));
                                            } ,
                                            child: ListTile(
                                              dense: true,
                                              tileColor: HexColor('#dac8fa'),
                                              title: new Text('EDUCATION DETAILS', style: TextStyle(fontSize: 14),),
                                              trailing:   FittedBox(
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        Text('EDIT', style: TextStyle( ),),
                                                        SizedBox(width: 8,),
                                                        Icon(Icons.edit),
                                                      ])
                                              ),
                                            )
                                        )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" *EDUCATION ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_joinEducation", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" ACADEMICS DETAILS", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_academics", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),

                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa')),
                                      ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                        InkWell(
                                            onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfessionDetails(Profession: _Profession, flag:'1')));
                                            } ,
                                            child: ListTile(
                                              dense: true,
                                              tileColor: HexColor('#dac8fa'),
                                              title: new Text('CANDIDATE OCCUPATION DETAILS', style: TextStyle(fontSize: 14),),
                                              trailing:   FittedBox(
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        Text('EDIT', style: TextStyle( ),),
                                                        SizedBox(width: 8,),
                                                        Icon(Icons.edit),
                                                      ])
                                              ),
                                            )
                                        )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text(" WORKING WITH", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_workwith, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text(" *OCCUPATION CATEGORY ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_businesscat, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text(" DESIGNATION ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_designation, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text(" OFFICE ADDRESS ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_officeadd, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),

                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text(" OCCUPATION DETAILS ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_occupationdet, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),

                            Divider(thickness: 0.5,),

                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color :HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                        InkWell(
                                            onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => HobbyDetails(Hobby: _Hobbies, flag:"1")));
                                            } ,
                                            child: ListTile(
                                              dense: true,
                                              tileColor: HexColor('#dac8fa'),
                                              title: new Text('HOBBY DETAILS', style: TextStyle(fontSize: 14),),
                                              trailing:   FittedBox(
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        Text('EDIT', style: TextStyle( ),),
                                                        SizedBox(width: 8,),
                                                        Icon(Icons.edit),
                                                      ])
                                              ),
                                            )
                                        )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" HOBBIES ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_joinHobbies", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            )
                          ]
                      )
                  )
              ),
            ),

            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                  InkWell(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AstroDetails(Astro: _Astro, flag:"1")));
                                      } ,
                                       child: ListTile(
                                          dense: true,
                                          tileColor: HexColor('#dac8fa'),
                                          title: new Text('ASTRO DETAILS', style: TextStyle(fontSize: 14),),
                                          trailing:   FittedBox(
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[
                                                    Text('EDIT', style: TextStyle( ),),
                                                    SizedBox(width: 8,),
                                                    Icon(Icons.edit),
                                                  ])
                                          ),
                                        )
                                        )
                                      ]
                                  )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("MANGLIK", _manglik),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("HOROSCOPE", _horoscope),
                            ),

                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                        InkWell(
                                            onTap:(){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyDetails(Family: _Family, flag:"1")));
                                            } ,
                                            child: ListTile(
                                              dense: true,
                                              tileColor: HexColor('#dac8fa'),
                                              title: new Text('FAMILY DETAILS', style: TextStyle(fontSize: 14),),
                                              trailing:   FittedBox(
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:[
                                                        Text('EDIT', style: TextStyle( ),),
                                                        SizedBox(width: 8,),
                                                        Icon(Icons.edit),
                                                      ])
                                              ),
                                            )
                                        )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*FATHER ", _fathername),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("*MOTHER ", _mothername),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" BROTHERS ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [

                                            Text(" $_totalbro brothers", style: TextStyle(fontSize: 15.0,),),
                                            Text(" $_totalmarrbro married", style: TextStyle(fontSize: 15.0,),),
                                          ],
                                        )


                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text(" SISTERS ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                               children: [

                                                 Text(" $_totalsis sisters", style: TextStyle(fontSize: 15.0,),),
                                                 Text(" $_totalmarrsis married", style: TextStyle(fontSize: 15.0,),),
    ],
    )


                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("FAMILY TYPE", _familytype),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("HOUSE TYPE", _housetype),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("FATHER OCCUPATION", _fatherocc),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("OFFICE TYPE", _officetype),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("FATHER OFFICE ADDRESS", _fatheroffadd),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("FATHER OFFICE NO", _fatheroffno),
                            ),

                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("FATHER MOBILE NO", _fathermob),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("FATHER WHATSAPP NO", _fatherwp),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("MOTHER'S MOBILE NO.", _mothermob),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows("MOTHER'S WHATSAPP NO", _fatherwp),
                            ),


                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                  InkWell(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PartnerDetails(Partner: _Partner, flag: "1")));
                                      } ,
                                        child: ListTile(
                                          dense: true,
                                          tileColor: HexColor('#dac8fa'),
                                          title: new Text('PARTNER PREFERENCES', style: TextStyle(fontSize: 14),),
                                          trailing:   FittedBox(
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[
                                                    Text('EDIT', style: TextStyle( ),),
                                                    SizedBox(width: 8,),
                                                    Icon(Icons.edit),
                                                  ])
                                          ),
                                        )
                                    )
                                      ]
                                  )

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text("  ABOUT ME ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_aboutme, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 2,
                                      child: Text("  ABOUT PARTNER ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(_aboutpartner, style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows(" AGE ", _partneragemin),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows(" HEIGHT ", _partnerheightmax),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows(" MANGLIK", _partnermanglik),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows(" BODY TYPE", _partnerbody),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows(" MARITAL STATUS", _partnermarital),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text("  EDUCATION ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_joinpartnereducation", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: rows(" SKIN TONE", _partnerskin),
                            ),
                            Divider(thickness: 0.5,),
                            Container(
                              padding: EdgeInsets.all(4.0),

                              child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 1,
                                      child: Text("  WORK CATEGORY ", style: TextStyle(fontSize: 15.0,),),
                                    ),

                                    Expanded(
                                        flex: 3,
                                        child: Text(" $_joinpartnerwork", style: TextStyle(fontSize: 15.0,),)

                                    )
                                  ]

                              ),
                            ),
                            Divider(thickness: 0.5,),


                          ]
                      )
                  )
              ),
            ),

            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                  decoration: new BoxDecoration (
                                    border: Border.all(
                                      color : HexColor('#dac8fa'),
                                    ),

                                  ),

    child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("Assets/blurred_bg.jpg"),
    fit: BoxFit.cover,
    ),),
                                  child: ListView(
                                      shrinkWrap: true,

                                      children :<Widget>[
                                        //color: Colors.deepOrangeAccent,
                                    InkWell(
                                      onTap:(){
                                            Navigator.push(context, MaterialPageRoute(builder : (context) => editdoc()));
                                        },
                                      child: ListTile(
                                          dense: true,
                                          tileColor: HexColor('#dac8fa'),
                                          title: new Text('Upload User Document', style: TextStyle(fontSize: 14),),
                                          trailing:   FittedBox(
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[
                                                    Text('UPLOAD ', style: TextStyle( ),),
                                                    SizedBox(width: 8,),
                                                  ])
                                          ),
                                        )
                                        ),

                                        CarouselSlider(
                                          items: [

                                            InkWell(
                                              onTap: (){
                                                if(imgdoc1 == null){
                                                  flag4 ="0";
                                                }
                                                else{
                                                  flag4='$imgdoc1';
                                                }
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoc(flag : flag4, imag5: "$imgdoc2")));
                                              },
                                              child: Stack(
                                                  children:[

                                                     Container(

                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            image: DecorationImage(
                                                              image: imgdoc2==null ?AssetImage('Assets/ic_profile.png') : NetworkImage('$imgdoc1'),

                                                            )
                                                        ),

                                                      ),

                                                    Align(
                                                      alignment: Alignment.topCenter,
                                                      child: Container(
                                                        width:100,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[350].withOpacity(0.5),
                                                        ),
                                                        child: FittedBox(
                                                          child: Text('Education Proof',),
                                                          fit: BoxFit.cover,
                                                        ),                                           ),
                                                    ),
                                                  ]),
                                            ),

                                            InkWell(
                                              onTap: (){
                                                if(imgdoc2 == null){
                                                  flag5 ="0";
                                                }
                                                else{
                                                  flag5='$imgdoc2';
                                                }
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoc(flag : flag5, imag5: "$imgdoc1")));
                                              },
                                              child: Stack(
                                              children:[

                                                Expanded(

                                                child: Container(


                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      image: DecorationImage(
                                                        image: imgdoc2==null ?AssetImage('Assets/ic_profile.png') : NetworkImage('$imgdoc2'),

                                                      )
                                                  ),

                                              ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Container(

                                                 decoration: BoxDecoration(
                                                   color: Colors.grey[350].withOpacity(0.5),
                                                 ),
                                                   child: FittedBox(
                                                      child: Text('Photo Proof', style:TextStyle(fontSize: 18)),
                                                     fit: BoxFit.fill,
                                                    ),                                           ),
                                                ),
                                     ]),
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
                                  )

                              ),
                            ),
                            ),

                            Divider(thickness: 0.5,),


                          ]
                      )
                  )
              ),
            ),
            Container(
              child: Card(

                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color : Colors.grey,),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),

                  child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:BorderRadius.vertical(top: Radius.circular(10.0)),
                              child:Container(

                                decoration: new BoxDecoration (
                                  border: Border.all(
                                    color : HexColor('#dac8fa'),
                                  ),

                                ),

                                child: Container(

                                    child: ListView(
                                        shrinkWrap: true,

                                        children :<Widget>[
                                          //color: Colors.deepOrangeAccent,
                                          InkWell(
                                              onTap:(){
                                                Navigator.push(context, MaterialPageRoute(builder : (context) => editdoc()));
                                              },
                                              child: ListTile(
                                                dense: true,
                                                tileColor: HexColor('#dac8fa'),
                                                title: new Text('INTRODUCTION VIDEO', style: TextStyle(fontSize: 14),),
                                                trailing:   FittedBox(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:[
                                                          Text('UPLOAD ', style: TextStyle( ),),
                                                          SizedBox(width: 8,),
                                                        ])
                                                ),
                                              )
                                          ),
                       Container(
                         width: MediaQuery.of(context).size.width*.95,

                           // child: _playerController.value.isInitialized
                           //            ? AspectRatio(
                           //            aspectRatio: _playerController.value.aspectRatio,
                           //            child: VideoPlayer(_playerController),
                         child: Stack(
                           children: [
                            FutureBuilder(
                              future: _initializeVideoPlayerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  // If the VideoPlayerController has finished initialization, use
                                  // the data it provides to limit the aspect ratio of the video.
                                  return AspectRatio(
                                    aspectRatio: _playerController.value.aspectRatio,
                                    // Use the VideoPlayer widget to display the video.
                                    child: VideoPlayer(_playerController),
                                  );
                                } else {
                                  // If the VideoPlayerController is still initializing, show a
                                  // loading spinner.
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            ),

                             Center(
                               heightFactor: 4,
                                 child:
                                 ButtonTheme(
                                     height: 35.0,
                                     minWidth: 30.0,
                                     child: RaisedButton(
                                       padding: EdgeInsets.only(top: 5.0),
                                       color: Colors.transparent,
                                       textColor: Colors.white,
                                       onPressed: () {
                                         // Wrap the play or pause in a call to `setState`. This ensures the
                                         // correct icon is shown.
                                         setState(() {
                                           // If the video is playing, pause it.
                                           if (_playerController.value.isPlaying) {
                                             _playerController.pause();
                                           } else {
                                             // If the video is paused, play it.
                                             _playerController.play();
                                           }
                                         });
                                       },
                                       child: Icon(
                                         _playerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                         size: 20.0,
                                       ),
                                     ))
                             )

                           ]

                       ),)

                                        ]
                                    )


                                ),

                              ),

                            ),


                          ]
                      )
                  )
              ),
            ),

                        ]
                    )
                )
            ),

    );
  }
}