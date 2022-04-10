import "dart:async";
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:jito_matrimony/EditActivity/Biodata.dart';
import 'package:jito_matrimony/EditActivity/Hobbies_list.dart';
import 'package:jito_matrimony/EditActivity/Partner_edit.dart';
import 'package:jito_matrimony/EditActivity/city_list.dart';
import 'package:jito_matrimony/EditActivity/country_list.dart';
import 'package:jito_matrimony/EditActivity/education_list.dart';
import 'package:jito_matrimony/MenuItems/addfeedback.dart';
import 'package:jito_matrimony/MenuItems/addfeedback.dart';
import 'package:jito_matrimony/advertisement.dart';
import 'package:jito_matrimony/view_biodata.dart';
import 'EditActivity/addbiodata.dart';
import 'EditActivity/uploaddoc.dart';
import 'EditClasses/astroadd.dart';
import 'EditClasses/contactadd.dart';
import 'EditClasses/deletebio.dart';
import 'EditClasses/hobbiesadd.dart';
import 'EditClasses/familyadd.dart';
import 'EditClasses/lifestyleadd.dart';
import 'EditClasses/Basic_add.dart';
import 'EditClasses/educationadd.dart';
import 'EditClasses/professionaladd.dart';
import 'package:jito_matrimony/EditClasses/partneradd.dart';
import 'package:jito_matrimony/EditClasses/lifestyleadd.dart';
import 'package:jito_matrimony/EditActivity/occupation_list.dart';
import 'package:jito_matrimony/EditActivity/state_list.dart';
import 'package:jito_matrimony/EditActivity/uploadphoto.dart';
import 'package:jito_matrimony/MenuItems/_register.dart';
import 'package:jito_matrimony/termscondition.dart';
import 'package:jito_matrimony/addbio.dart';
import 'package:jito_matrimony/logut.dart';
import 'package:jito_matrimony/MenuItems/_contact.dart';
import 'package:jito_matrimony/MenuItems/_about.dart';
import 'package:jito_matrimony/MenuItems/_privacypolicy.dart';
import 'package:jito_matrimony/MenuItems/committee.dart';
import 'package:jito_matrimony/registeration.dart';

import 'EditActivity/uploadphoto.dart';
import 'MenuItems/addfeedback.dart';
import 'MenuItems/feedbacklist.dart';
import 'Search/search.dart';
import 'view_biodata.dart';
import 'favouriteadd.dart';
import 'managefav.dart';

part "ProviderService.chopper.dart";


@ChopperApi(baseUrl:"")
abstract class ProviderService extends ChopperService {

  static ProviderService create() {
    final client = ChopperClient(
        baseUrl: "http://jito.lakecitypivotz.com/",
        services: [
        _$ProviderService()
    ],
    converter: JsonToTypeConverter({

      Logut : (jsonData) => Logut.fromJson(jsonData),

      contact : (jsonData) => contact.fromJson(jsonData),

      about : (jsonData) => about.fromJson(jsonData),

      privacypolicy : (jsonData) => privacypolicy.fromJson(jsonData),

      committee : (jsonData) => committee.fromJson(jsonData),

      register : (jsonData) => register.fromJson(jsonData),

      Basic_add : (jsonData) => Basic_add.fromJson(jsonData),

      country_list: (jsonData) => country_list.fromJson(jsonData),

      education_list : (jsonData) => education_list.fromJson(jsonData),

      state_list : (jsonData) => state_list.fromJson(jsonData),

      city_list : (jsonData) => city_list.fromJson(jsonData),

      occupation_list : (jsonData) => occupation_list.fromJson(jsonData),

      registeration : (jsonData) => registeration.fromJson(jsonData),

      addbio : (jsonData) => addbio.fromJson(jsonData),

      search : (jsonData) => search.fromJson(jsonData),

      Biodata : (jsonData) => Biodata.fromJson(jsonData),

      uploadphoto : (jsonData) => uploadphoto.fromJson(jsonData),

      familyadd : (jsonData) => familyadd.fromJson(jsonData),

      astroadd : (jsonData) => astroadd.fromJson(jsonData),

      contactadd : (jsonData) => contactadd.fromJson(jsonData),

      educationadd : (jsonData) => educationadd.fromJson(jsonData),

      hobbiesadd : (jsonData) => hobbiesadd.fromJson(jsonData),

      lifestyleadd : (jsonData) => lifestyleadd.fromJson(jsonData),

      partneradd : (jsonData) => partneradd.fromJson(jsonData),

      professionaladd : (jsonData) => professionaladd.fromJson(jsonData),

      termscondition : (jsonData) => termscondition.fromJson(jsonData),

      advertisement : (jsonData) => advertisement.fromJson(jsonData),

      addfeedback : (jsonData) => addfeedback.fromJson(jsonData),

      feedbacklist : (jsonData) => feedbacklist.fromJson(jsonData),

      addbiodata : (jsonData) => addbiodata.fromJson(jsonData),

      view_biodata : (jsonData) => view_biodata.fromJson(jsonData),

      Hobbies_list : (jsonData) => Hobbies_list.fromJson(jsonData),

      managefav: (jsonData) => managefav.fromJson(jsonData),

      favouriteadd: (jsonData) => favouriteadd.fromJson(jsonData),

      //deletebio : (jsonData) => deletebio.fromJson(jsonData),

        }
      )
    );
    return _$ProviderService(client);

}

  @Post(path: 'api/UserLogin/sendOtp?', headers: {'Content-Type' : 'application/json;'})
  Future<Response<Logut>> getResource(@Body() Map<String, dynamic> body);

  @Post(path: 'api/UserLogin/register', headers: {'Content-Type' : 'application/json;'})
  Future<Response<registeration>> getRegisteration(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Biodata/addBioData', headers: {'Content-Type' : 'application/json;'})
  Future<Response<addbio>> getbio(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Biodata/listBiodata_v1', headers: {'Content-Type' : 'application/json;'})
  Future<Response<Biodata>> getBiodata(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Biodata/addBioData', headers: {'Content-Type' : 'application/json;'})
  Future<Response<addbiodata>> addBiodata(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Biodata/searchless_v1', headers: {'Content-Type' : 'application/json;'})
  Future<Response<search>> getsearchlist(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Family/FamilyDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<familyadd>> addFamily(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Basic/basicDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<Basic_add>> addBasic(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Contact/contactDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<contactadd>> addContact(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Lifestyle/lifestyleDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<lifestyleadd>> addLifestyle(@Body() Map<String, dynamic> body);

  @Post(path: 'api/hobbies/hobbiesDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<hobbiesadd>> addHobbies(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Professional/professionalDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<professionaladd>> addProfeession(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Partner/partnerDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<partneradd>> addPartner(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Astro/astroDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<astroadd>> addAstro(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Image/userPhotos', headers: {'Content-Type' : 'application/json;'})
  Future<Response<uploadphoto>> getuploadphoto(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Image/userDocumentUpload', headers: {'Content-Type' : 'application/json;'})
  Future<Response<uploaddoc>> getuploaddoc(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Ad/advertisement', headers: {'Content-Type' : 'application/json;'})
  Future<Response<advertisement>> getAdvertise(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Biodata/search_v1', headers: {'Content-Type' : 'application/json;'})
  Future<Response<view_biodata>> getviewbio(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Request/feedback', headers: {'Content-Type' : 'application/json;'})
  Future<Response<addfeedback>> feedbackadd(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Education/educationDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<educationadd>> addeducation(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Request/favourite', headers: {'Content-Type' : 'application/json;'})
  Future<Response<favouriteadd>> addfavourite(@Body() Map<String, dynamic> body);

  @Post(path: 'api/Request/manageFavourite', headers: {'Content-Type' : 'application/json;'})
  Future<Response<managefav>> managefavourite(@Body() Map<String, dynamic> body);

  // @Post(path: 'api/Biodata/deleteBiodata', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<deletebio>> deleteBio(@Body() Map<String, dynamic> body);

  @Get(path: 'api/Master/contactUs?', headers: {'Content-Type' : 'application/json;'})
  Future<Response<contact>> getContact(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/hobbies', headers: {'Content-Type' : 'application/json;'})
  Future<Response<Hobbies_list>> getHobbies(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/AboutUs?', headers: {'Content-Type' : 'application/json;'})
  Future<Response<about>> getAbout(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/privacyPolicy?', headers: {'Content-Type' : 'application/json;'})
  Future<Response<privacypolicy>> getPolicy(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/committee_details?', headers: {'Content-Type' : 'application/json;'})
  Future<Response<committee>> getCommittee(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/why_register', headers: {'Content-Type' : 'application/json;'})
  Future<Response<register>> getRegister(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/termsCondition', headers: {'Content-Type' : 'application/json;'})
  Future<Response<termscondition>> getterms(@Query() Map<String, dynamic> body);

  @Post(path: 'api/Biodata/basicDetail', headers: {'Content-Type' : 'application/json;'})
  Future<Response<Basic_add>> getBasicdetail(@Body() Map<String, dynamic> body);

  @Get(path: 'api/Master/education', headers: {'Content-Type' : 'application/json;'})
  Future<Response<education_list>> getEducation(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/country?', headers: {'Content-Type' : 'application/json;'})
  Future<Response<country_list>> getCountry(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/state', headers: {'Content-Type' : 'application/json;'})
  Future<Response<state_list>> getState(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/city', headers: {'Content-Type' : 'application/json;'})
  Future<Response<city_list>> getCity(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Master/businessType', headers: {'Content-Type' : 'application/json;'})
  Future<Response<occupation_list>> getOccupation(@Query() Map<String, dynamic> body);

  @Get(path: 'api/Request/listFeedback', headers: {'Content-Type' : 'application/json;'})
  Future<Response<feedbacklist>> getfeedback(@Query() Map<String, dynamic> body);



  //
  // @Post(path: 'api/Contact/contactDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Contact_add>> getContactdetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/Lifestyle/lifeStyleDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Lifestyle_add>> getLifestyledetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/Family/FamilyDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Family_add>> getFamilydetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/Education/educationDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Education_add>> getEducationdetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/Hobbies/hobbiesDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Hobby_add>> getHobbydetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/Astro/astroDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Astro_add>> getAstrodetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/APartner/partnerDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Partner_add>> getPartnerdetail(@Body() Map<String, dynamic> body);
  //
  // @Post(path: 'api/Professional/professionalDetail', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Professional_add>> getProfessionaldetail(@Body() Map<String, dynamic> body);


  // @Post(path: 'api/Biodata/addBioData', headers: {'Content-Type' : 'application/json;'})
  // Future<Response<Basic_add>> getResource(@Body() Map<String, dynamic> body);

}

class JsonToTypeConverter extends JsonConverter {

  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(

      body: fromJsonData<BodyType, InnerType>(response.body, typeToJsonFactoryMap[InnerType]),
    );
  }


  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {

    print('jjjjjjjjjjjjjjj' + jsonData);

    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }

}