import 'package:json_annotation/json_annotation.dart';

part 'view_biodata.g.dart';

@JsonSerializable()
class view_biodata {
  int status;
  String message;
  int fltCnt;
  int totCnt;
  List<Datainfo> datainfo;

  view_biodata(
      {this.status, this.message, this.fltCnt, this.totCnt, this.datainfo});

  view_biodata.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    fltCnt = json['FltCnt'];
    totCnt = json['TotCnt'];
    if (json['datainfo'] != null) {
      datainfo = new List<Datainfo>();
      json['datainfo'].forEach((v) {
        datainfo.add(new Datainfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['FltCnt'] = this.fltCnt;
    data['TotCnt'] = this.totCnt;
    if (this.datainfo != null) {
      data['datainfo'] = this.datainfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datainfo {
  String id;
  String biodataPerson;
  String currentActivity;
  String userId;
  String name;
  String gender;
  String status;
  String dateOfBirth;
  String timeOfBirth;
  String placeOfBirth;
  String motherToungue;
  String jainSampradaya;
  String sangh;
  String gnyati;
  String nativePlace;
  String physicalDisability;
  String physicalDisabilityYes;
  String maritalStatus;
  String height;
  String weight;
  String bloodGroup;
  String spects;
  String skinTone;
  String bodyType;
  String dietType;
  String disease;
  String socialFacebook;
  String socialInstagram;
  String socialLinkedin;
  String residenceAddress;
  String countryId;
  String country;
  String stateId;
  String state;
  String cityId;
  String city;
  String pincode;
  String landlineNo;
  String mobileNo;
  String contactEmail;
  String liveswithfmlyn;
  String curliveaddr;
  String curlivecountrynm;
  String curlivestatenm;
  String curlivecitynm;
  String candWhatsappno;
  String visaStatus;
  List<EducationDetails> educationDetails;
  String academicsDet;
  String workingWith;
  List<BuisnessType> buisnessType;
  String designationId;
  String designation;
  String officeAddress;
  String occupationDet;
  List<Hobbies> hobbies;
  String astroManglik;
  String astroHoroscope;
  String fatherName;
  String motherName;
  String totalBrother;
  String totalMarriedBrother;
  String totalSister;
  String totalMarriedSister;
  String familyType;
  String houseType;
  String fatherOccupation;
  String officeType;
  String fatherOfficeAddress;
  String fatherMobileNo;
  String fatherOfficeNo;
  String fatherWhatsapp;
  String motherMob;
  String motherWhatsapp;
  String aboutMe;
  String aboutPartner;
  String partnerAgeMin;
  String partnerAgeMax;
  String partnerHeightMin;
  String partnerHeightMax;
  String partnerNamglic;
  String partnerSkintone;
  String partnerBodyType;
  String partnerMeritalStatus;
  List<EducationDetails> partnerEducation;
  List<BuisnessType> partnerWorkingCategory;
  String img1;
  String img2;
  String img3;
  String imgmed1;
  String imgmed2;
  String imgmed3;
  String imgsmall1;
  String imgsmall2;
  String imgsmall3;
  String video1;
  String createbyFname;
  String createbyLname;
  String familyAnnualIncome;
  String photoProof;
  String eduProof;
  String profileId;
  String dispstatus;
  String connectStatus;
  String acceptStatus;
  String favStatus;
  String age;

  Datainfo(
      {this.id,
        this.biodataPerson,
        this.currentActivity,
        this.userId,
        this.name,
        this.gender,
        this.status,
        this.dateOfBirth,
        this.timeOfBirth,
        this.placeOfBirth,
        this.motherToungue,
        this.jainSampradaya,
        this.sangh,
        this.gnyati,
        this.nativePlace,
        this.physicalDisability,
        this.physicalDisabilityYes,
        this.maritalStatus,
        this.height,
        this.weight,
        this.bloodGroup,
        this.spects,
        this.skinTone,
        this.bodyType,
        this.dietType,
        this.disease,
        this.socialFacebook,
        this.socialInstagram,
        this.socialLinkedin,
        this.residenceAddress,
        this.countryId,
        this.country,
        this.stateId,
        this.state,
        this.cityId,
        this.city,
        this.pincode,
        this.landlineNo,
        this.mobileNo,
        this.contactEmail,
        this.liveswithfmlyn,
        this.curliveaddr,
        this.curlivecountrynm,
        this.curlivestatenm,
        this.curlivecitynm,
        this.candWhatsappno,
        this.visaStatus,
        this.educationDetails,
        this.academicsDet,
        this.workingWith,
        this.buisnessType,
        this.designationId,
        this.designation,
        this.officeAddress,
        this.occupationDet,
        this.hobbies,
        this.astroManglik,
        this.astroHoroscope,
        this.fatherName,
        this.motherName,
        this.totalBrother,
        this.totalMarriedBrother,
        this.totalSister,
        this.totalMarriedSister,
        this.familyType,
        this.houseType,
        this.fatherOccupation,
        this.officeType,
        this.fatherOfficeAddress,
        this.fatherMobileNo,
        this.fatherOfficeNo,
        this.fatherWhatsapp,
        this.motherMob,
        this.motherWhatsapp,
        this.aboutMe,
        this.aboutPartner,
        this.partnerAgeMin,
        this.partnerAgeMax,
        this.partnerHeightMin,
        this.partnerHeightMax,
        this.partnerNamglic,
        this.partnerSkintone,
        this.partnerBodyType,
        this.partnerMeritalStatus,
        this.partnerEducation,
        this.partnerWorkingCategory,
        this.img1,
        this.img2,
        this.img3,
        this.imgmed1,
        this.imgmed2,
        this.imgmed3,
        this.imgsmall1,
        this.imgsmall2,
        this.imgsmall3,
        this.video1,
        this.createbyFname,
        this.createbyLname,
        this.familyAnnualIncome,
        this.photoProof,
        this.eduProof,
        this.profileId,
        this.dispstatus,
        this.connectStatus,
        this.acceptStatus,
        this.favStatus,
        this.age});

  Datainfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    biodataPerson = json['biodata_person'];
    currentActivity = json['current_activity'];
    userId = json['user_id'];
    name = json['name'];
    gender = json['gender'];
    status = json['status'];
    dateOfBirth = json['date_of_birth'];
    timeOfBirth = json['time_of_birth'];
    placeOfBirth = json['place_of_birth'];
    motherToungue = json['mother_toungue'];
    jainSampradaya = json['jain_sampradaya'];
    sangh = json['sangh'];
    gnyati = json['gnyati'];
    nativePlace = json['native_place'];
    physicalDisability = json['physical_disability'];
    physicalDisabilityYes = json['physical_disability_yes'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
    spects = json['spects'];
    skinTone = json['skin_tone'];
    bodyType = json['body_type'];
    dietType = json['diet_type'];
    disease = json['disease'];
    socialFacebook = json['social_facebook'];
    socialInstagram = json['social_instagram'];
    socialLinkedin = json['social_linkedin'];
    residenceAddress = json['residence_address'];
    countryId = json['country_id'];
    country = json['country'];
    stateId = json['state_id'];
    state = json['state'];
    cityId = json['city_id'];
    city = json['city'];
    pincode = json['pincode'];
    landlineNo = json['landline_no'];
    mobileNo = json['mobile_no'];
    contactEmail = json['contact_email'];
    liveswithfmlyn = json['liveswithfmlyn'];
    curliveaddr = json['curliveaddr'];
    curlivecountrynm = json['curlivecountrynm'];
    curlivestatenm = json['curlivestatenm'];
    curlivecitynm = json['curlivecitynm'];
    candWhatsappno = json['cand_whatsappno'];
    visaStatus = json['visa_status'];
    if (json['education_details'] != null) {
      educationDetails = new List<EducationDetails>();
      json['education_details'].forEach((v) {
        educationDetails.add(new EducationDetails.fromJson(v));
      });
    }
    academicsDet = json['academics_det'];
    workingWith = json['working_with'];
    if (json['buisness_type'] != null) {
      buisnessType = new List<BuisnessType>();
      json['buisness_type'].forEach((v) {
        buisnessType.add(new BuisnessType.fromJson(v));
      });
    }
    designationId = json['designation_id'];
    designation = json['designation'];
    officeAddress = json['office_address'];
    occupationDet = json['occupation_det'];
    if (json['hobbies'] != null) {
      hobbies = new List<Hobbies>();
      json['hobbies'].forEach((v) {
        hobbies.add(new Hobbies.fromJson(v));
      });
    }
    astroManglik = json['astro_manglik'];
    astroHoroscope = json['astro_horoscope'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    totalBrother = json['total_brother'];
    totalMarriedBrother = json['total_married_brother'];
    totalSister = json['total_sister'];
    totalMarriedSister = json['total_married_sister'];
    familyType = json['family_type'];
    houseType = json['house_type'];
    fatherOccupation = json['father_occupation'];
    officeType = json['office_type'];
    fatherOfficeAddress = json['father_office_address'];
    fatherMobileNo = json['father_mobile_no'];
    fatherOfficeNo = json['father_office_no'];
    fatherWhatsapp = json['father_whatsapp'];
    motherMob = json['mother_mob'];
    motherWhatsapp = json['mother_whatsapp'];
    aboutMe = json['about_me'];
    aboutPartner = json['about_partner'];
    partnerAgeMin = json['partner_age_min'];
    partnerAgeMax = json['partner_age_max'];
    partnerHeightMin = json['partner_height_min'];
    partnerHeightMax = json['partner_height_max'];
    partnerNamglic = json['partner_namglic'];
    partnerSkintone = json['partner_skintone'];
    partnerBodyType = json['partner_body_type'];
    partnerMeritalStatus = json['partner_merital_status'];
    if (json['partner_education'] != null) {
      partnerEducation = new List<EducationDetails>();
      json['partner_education'].forEach((v) {
        partnerEducation.add(new EducationDetails.fromJson(v));
      });
    }
    if (json['partner_working_category'] != null) {
      partnerWorkingCategory = new List<BuisnessType>();
      json['partner_working_category'].forEach((v) {
        partnerWorkingCategory.add(new BuisnessType.fromJson(v));
      });
    }
    img1 = json['img_1'];
    img2 = json['img_2'];
    img3 = json['img_3'];
    imgmed1 = json['imgmed_1'];
    imgmed2 = json['imgmed_2'];
    imgmed3 = json['imgmed_3'];
    imgsmall1 = json['imgsmall_1'];
    imgsmall2 = json['imgsmall_2'];
    imgsmall3 = json['imgsmall_3'];
    video1 = json['video1'];
    createbyFname = json['createby_fname'];
    createbyLname = json['createby_lname'];
    familyAnnualIncome = json['family_annual_income'];
    photoProof = json['photo_proof'];
    eduProof = json['edu_proof'];
    profileId = json['profile_id'];
    dispstatus = json['dispstatus'];
    connectStatus = json['connect_status'];
    acceptStatus = json['accept_status'];
    favStatus = json['fav_status'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['biodata_person'] = this.biodataPerson;
    data['current_activity'] = this.currentActivity;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['date_of_birth'] = this.dateOfBirth;
    data['time_of_birth'] = this.timeOfBirth;
    data['place_of_birth'] = this.placeOfBirth;
    data['mother_toungue'] = this.motherToungue;
    data['jain_sampradaya'] = this.jainSampradaya;
    data['sangh'] = this.sangh;
    data['gnyati'] = this.gnyati;
    data['native_place'] = this.nativePlace;
    data['physical_disability'] = this.physicalDisability;
    data['physical_disability_yes'] = this.physicalDisabilityYes;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['blood_group'] = this.bloodGroup;
    data['spects'] = this.spects;
    data['skin_tone'] = this.skinTone;
    data['body_type'] = this.bodyType;
    data['diet_type'] = this.dietType;
    data['disease'] = this.disease;
    data['social_facebook'] = this.socialFacebook;
    data['social_instagram'] = this.socialInstagram;
    data['social_linkedin'] = this.socialLinkedin;
    data['residence_address'] = this.residenceAddress;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    data['city_id'] = this.cityId;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['landline_no'] = this.landlineNo;
    data['mobile_no'] = this.mobileNo;
    data['contact_email'] = this.contactEmail;
    data['liveswithfmlyn'] = this.liveswithfmlyn;
    data['curliveaddr'] = this.curliveaddr;
    data['curlivecountrynm'] = this.curlivecountrynm;
    data['curlivestatenm'] = this.curlivestatenm;
    data['curlivecitynm'] = this.curlivecitynm;
    data['cand_whatsappno'] = this.candWhatsappno;
    data['visa_status'] = this.visaStatus;
    if (this.educationDetails != null) {
      data['education_details'] =
          this.educationDetails.map((v) => v.toJson()).toList();
    }
    data['academics_det'] = this.academicsDet;
    data['working_with'] = this.workingWith;
    if (this.buisnessType != null) {
      data['buisness_type'] = this.buisnessType.map((v) => v.toJson()).toList();
    }
    data['designation_id'] = this.designationId;
    data['designation'] = this.designation;
    data['office_address'] = this.officeAddress;
    data['occupation_det'] = this.occupationDet;
    if (this.hobbies != null) {
      data['hobbies'] = this.hobbies.map((v) => v.toJson()).toList();
    }
    data['astro_manglik'] = this.astroManglik;
    data['astro_horoscope'] = this.astroHoroscope;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['total_brother'] = this.totalBrother;
    data['total_married_brother'] = this.totalMarriedBrother;
    data['total_sister'] = this.totalSister;
    data['total_married_sister'] = this.totalMarriedSister;
    data['family_type'] = this.familyType;
    data['house_type'] = this.houseType;
    data['father_occupation'] = this.fatherOccupation;
    data['office_type'] = this.officeType;
    data['father_office_address'] = this.fatherOfficeAddress;
    data['father_mobile_no'] = this.fatherMobileNo;
    data['father_office_no'] = this.fatherOfficeNo;
    data['father_whatsapp'] = this.fatherWhatsapp;
    data['mother_mob'] = this.motherMob;
    data['mother_whatsapp'] = this.motherWhatsapp;
    data['about_me'] = this.aboutMe;
    data['about_partner'] = this.aboutPartner;
    data['partner_age_min'] = this.partnerAgeMin;
    data['partner_age_max'] = this.partnerAgeMax;
    data['partner_height_min'] = this.partnerHeightMin;
    data['partner_height_max'] = this.partnerHeightMax;
    data['partner_namglic'] = this.partnerNamglic;
    data['partner_skintone'] = this.partnerSkintone;
    data['partner_body_type'] = this.partnerBodyType;
    data['partner_merital_status'] = this.partnerMeritalStatus;
    if (this.partnerEducation != null) {
      data['partner_education'] =
          this.partnerEducation.map((v) => v.toJson()).toList();
    }
    if (this.partnerWorkingCategory != null) {
      data['partner_working_category'] =
          this.partnerWorkingCategory.map((v) => v.toJson()).toList();
    }
    data['img_1'] = this.img1;
    data['img_2'] = this.img2;
    data['img_3'] = this.img3;
    data['imgmed_1'] = this.imgmed1;
    data['imgmed_2'] = this.imgmed2;
    data['imgmed_3'] = this.imgmed3;
    data['imgsmall_1'] = this.imgsmall1;
    data['imgsmall_2'] = this.imgsmall2;
    data['imgsmall_3'] = this.imgsmall3;
    data['video1'] = this.video1;
    data['createby_fname'] = this.createbyFname;
    data['createby_lname'] = this.createbyLname;
    data['family_annual_income'] = this.familyAnnualIncome;
    data['photo_proof'] = this.photoProof;
    data['edu_proof'] = this.eduProof;
    data['profile_id'] = this.profileId;
    data['dispstatus'] = this.dispstatus;
    data['connect_status'] = this.connectStatus;
    data['accept_status'] = this.acceptStatus;
    data['fav_status'] = this.favStatus;
    data['age'] = this.age;
    return data;
  }
}

class EducationDetails {
  String educationId;
  String educationName;
  String catId;

  EducationDetails({this.educationId, this.educationName, this.catId});

  EducationDetails.fromJson(Map<String, dynamic> json) {
    educationId = json['education_id'];
    educationName = json['education_name'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education_id'] = this.educationId;
    data['education_name'] = this.educationName;
    data['cat_id'] = this.catId;
    return data;
  }
}

class BuisnessType {
  String businessTypeId;
  String businessTypeName;

  BuisnessType({this.businessTypeId, this.businessTypeName});

  BuisnessType.fromJson(Map<String, dynamic> json) {
    businessTypeId = json['business_type_id'];
    businessTypeName = json['business_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_type_id'] = this.businessTypeId;
    data['business_type_name'] = this.businessTypeName;
    return data;
  }
}

class Hobbies {
  String hobbiesId;
  String hobbiesName;

  Hobbies({this.hobbiesId, this.hobbiesName});

  Hobbies.fromJson(Map<String, dynamic> json) {
    hobbiesId = json['hobbies_id'];
    hobbiesName = json['hobbies_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobbies_id'] = this.hobbiesId;
    data['hobbies_name'] = this.hobbiesName;
    return data;
  }
}
