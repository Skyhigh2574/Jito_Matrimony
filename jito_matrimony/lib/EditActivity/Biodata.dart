import 'package:json_annotation/json_annotation.dart';

part 'Biodata.g.dart';

@JsonSerializable()
class Biodata {
  int status;
  String message;
  List<Datainfo> datainfo;

  Biodata({this.status, this.message, this.datainfo});

  Biodata.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    if (this.datainfo != null) {
      data['datainfo'] = this.datainfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datainfo {
  String bioId;
  String userId;
  String mFId;
  String gender;
  String uploadphotoPerson;
  String name;
  String img1;
  String bioStatus;
  List<BasicDetail> basicDetail;
  List<ImgDetail> imgDetail;
  List<CertificateDetail> certificateDetail;
  List<AstroDetail> astroDetail;
  List<ContactDetail> contactDetail;
  List<FamilyDetail> familyDetail;
  List<LifestyleDetail> lifestyleDetail;
  List<ProfessionalDetail> professionalDetail;
  List<HobbiesDetail> hobbiesDetail;
  List<EducationDetail> educationDetail;
  List<PartnerDetail> partnerDetail;
  String video1;
  String videosample;
  String videotext;

  Datainfo(
      {this.bioId,
        this.userId,
        this.mFId,
        this.gender,
        this.uploadphotoPerson,
        this.name,
        this.img1,
        this.bioStatus,
        this.basicDetail,
        this.imgDetail,
        this.certificateDetail,
        this.astroDetail,
        this.contactDetail,
        this.familyDetail,
        this.lifestyleDetail,
        this.professionalDetail,
        this.hobbiesDetail,
        this.educationDetail,
        this.partnerDetail,
        this.video1,
        this.videosample,
        this.videotext});

  Datainfo.fromJson(Map<String, dynamic> json) {
    bioId = json['bio_id'];
    userId = json['user_id'];
    mFId = json['m_f_id'];
    gender = json['gender'];
    uploadphotoPerson = json['uploadphoto_person'];
    name = json['name'];
    img1 = json['img_1'];
    bioStatus = json['bio_status'];
    if (json['basic_detail'] != null) {
      basicDetail = new List<BasicDetail>();
      json['basic_detail'].forEach((v) {
        basicDetail.add(new BasicDetail.fromJson(v));
      });
    }
    if (json['img_detail'] != null) {
      imgDetail = new List<ImgDetail>();
      json['img_detail'].forEach((v) {
        imgDetail.add(new ImgDetail.fromJson(v));
      });
    }
    if (json['Certificate_detail'] != null) {
      certificateDetail = new List<CertificateDetail>();
      json['Certificate_detail'].forEach((v) {
        certificateDetail.add(new CertificateDetail.fromJson(v));
      });
    }
    if (json['astro_detail'] != null) {
      astroDetail = new List<AstroDetail>();
      json['astro_detail'].forEach((v) {
        astroDetail.add(new AstroDetail.fromJson(v));
      });
    }
    if (json['contact_detail'] != null) {
      contactDetail = new List<ContactDetail>();
      json['contact_detail'].forEach((v) {
        contactDetail.add(new ContactDetail.fromJson(v));
      });
    }
    if (json['family_detail'] != null) {
      familyDetail = new List<FamilyDetail>();
      json['family_detail'].forEach((v) {
        familyDetail.add(new FamilyDetail.fromJson(v));
      });
    }
    if (json['lifestyle_detail'] != null) {
      lifestyleDetail = new List<LifestyleDetail>();
      json['lifestyle_detail'].forEach((v) {
        lifestyleDetail.add(new LifestyleDetail.fromJson(v));
      });
    }
    if (json['professional_detail'] != null) {
      professionalDetail = new List<ProfessionalDetail>();
      json['professional_detail'].forEach((v) {
        professionalDetail.add(new ProfessionalDetail.fromJson(v));
      });
    }
    if (json['hobbies_detail'] != null) {
      hobbiesDetail = new List<HobbiesDetail>();
      json['hobbies_detail'].forEach((v) {
        hobbiesDetail.add(new HobbiesDetail.fromJson(v));
      });
    }
    if (json['education_detail'] != null) {
      educationDetail = new List<EducationDetail>();
      json['education_detail'].forEach((v) {
        educationDetail.add(new EducationDetail.fromJson(v));
      });
    }
    if (json['partner_detail'] != null) {
      partnerDetail = new List<PartnerDetail>();
      json['partner_detail'].forEach((v) {
        partnerDetail.add(new PartnerDetail.fromJson(v));
      });
    }
    video1 = json['video1'];
    videosample = json['videosample'];
    videotext = json['videotext'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['m_f_id'] = this.mFId;
    data['gender'] = this.gender;
    data['uploadphoto_person'] = this.uploadphotoPerson;
    data['name'] = this.name;
    data['img_1'] = this.img1;
    data['bio_status'] = this.bioStatus;
    if (this.basicDetail != null) {
      data['basic_detail'] = this.basicDetail.map((v) => v.toJson()).toList();
    }
    if (this.imgDetail != null) {
      data['img_detail'] = this.imgDetail.map((v) => v.toJson()).toList();
    }
    if (this.certificateDetail != null) {
      data['Certificate_detail'] =
          this.certificateDetail.map((v) => v.toJson()).toList();
    }
    if (this.astroDetail != null) {
      data['astro_detail'] = this.astroDetail.map((v) => v.toJson()).toList();
    }
    if (this.contactDetail != null) {
      data['contact_detail'] =
          this.contactDetail.map((v) => v.toJson()).toList();
    }
    if (this.familyDetail != null) {
      data['family_detail'] = this.familyDetail.map((v) => v.toJson()).toList();
    }
    if (this.lifestyleDetail != null) {
      data['lifestyle_detail'] =
          this.lifestyleDetail.map((v) => v.toJson()).toList();
    }
    if (this.professionalDetail != null) {
      data['professional_detail'] =
          this.professionalDetail.map((v) => v.toJson()).toList();
    }
    if (this.hobbiesDetail != null) {
      data['hobbies_detail'] =
          this.hobbiesDetail.map((v) => v.toJson()).toList();
    }
    if (this.educationDetail != null) {
      data['education_detail'] =
          this.educationDetail.map((v) => v.toJson()).toList();
    }
    if (this.partnerDetail != null) {
      data['partner_detail'] =
          this.partnerDetail.map((v) => v.toJson()).toList();
    }
    data['video1'] = this.video1;
    data['videosample'] = this.videosample;
    data['videotext'] = this.videotext;
    return data;
  }
}

class BasicDetail {
  String bioId;
  String userId;
  String uploadphotoPerson;
  String name;
  String gender;
  String dateOfBirth;
  String timeOfBirth;
  String placeOfBirth;
  String motherToungue;
  String jainSampradaya;
  String sangh;
  String gnyati;
  String physicalDisability;
  String physicalDisabilityYes;
  String maritalStatus;
  String status;
  String suspendReason;
  String currentActivity;
  String nativePlace;

  BasicDetail(
      {this.bioId,
        this.userId,
        this.uploadphotoPerson,
        this.name,
        this.gender,
        this.dateOfBirth,
        this.timeOfBirth,
        this.placeOfBirth,
        this.motherToungue,
        this.jainSampradaya,
        this.sangh,
        this.gnyati,
        this.physicalDisability,
        this.physicalDisabilityYes,
        this.maritalStatus,
        this.status,
        this.suspendReason,
        this.currentActivity,
        this.nativePlace});

  BasicDetail.fromJson(Map<String, dynamic> json) {
    bioId = json['bio_id'];
    userId = json['user_id'];
    uploadphotoPerson = json['uploadphoto_person'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    timeOfBirth = json['time_of_birth'];
    placeOfBirth = json['place_of_birth'];
    motherToungue = json['mother_toungue'];
    jainSampradaya = json['jain_sampradaya'];
    sangh = json['sangh'];
    gnyati = json['gnyati'];
    physicalDisability = json['physical_disability'];
    physicalDisabilityYes = json['physical_disability_yes'];
    maritalStatus = json['marital_status'];
    status = json['status'];
    suspendReason = json['suspend_reason'];
    currentActivity = json['current_activity'];
    nativePlace = json['native_place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['uploadphoto_person'] = this.uploadphotoPerson;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['time_of_birth'] = this.timeOfBirth;
    data['place_of_birth'] = this.placeOfBirth;
    data['mother_toungue'] = this.motherToungue;
    data['jain_sampradaya'] = this.jainSampradaya;
    data['sangh'] = this.sangh;
    data['gnyati'] = this.gnyati;
    data['physical_disability'] = this.physicalDisability;
    data['physical_disability_yes'] = this.physicalDisabilityYes;
    data['marital_status'] = this.maritalStatus;
    data['status'] = this.status;
    data['suspend_reason'] = this.suspendReason;
    data['current_activity'] = this.currentActivity;
    data['native_place'] = this.nativePlace;
    return data;
  }
}

class ImgDetail {
  String imgId;
  String bioId;
  String userId;
  String img1;
  String imgmed1;
  String imgsmall1;
  String img2;
  String imgmed2;
  String imgsmall2;
  String img3;
  String imgmed3;
  String imgsmall3;

  ImgDetail(
      {this.imgId,
        this.bioId,
        this.userId,
        this.img1,
        this.imgmed1,
        this.imgsmall1,
        this.img2,
        this.imgmed2,
        this.imgsmall2,
        this.img3,
        this.imgmed3,
        this.imgsmall3});

  ImgDetail.fromJson(Map<String, dynamic> json) {
    imgId = json['img_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
    img1 = json['img_1'];
    imgmed1 = json['imgmed_1'];
    imgsmall1 = json['imgsmall_1'];
    img2 = json['img_2'];
    imgmed2 = json['imgmed_2'];
    imgsmall2 = json['imgsmall_2'];
    img3 = json['img_3'];
    imgmed3 = json['imgmed_3'];
    imgsmall3 = json['imgsmall_3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_id'] = this.imgId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['img_1'] = this.img1;
    data['imgmed_1'] = this.imgmed1;
    data['imgsmall_1'] = this.imgsmall1;
    data['img_2'] = this.img2;
    data['imgmed_2'] = this.imgmed2;
    data['imgsmall_2'] = this.imgsmall2;
    data['img_3'] = this.img3;
    data['imgmed_3'] = this.imgmed3;
    data['imgsmall_3'] = this.imgsmall3;
    return data;
  }
}

class CertificateDetail {
  String userId;
  String imgId;
  String bioId;
  String photoProof;
  String birthProof;
  String addressProof;
  String eduProof;

  CertificateDetail(
      {this.userId,
        this.imgId,
        this.bioId,
        this.photoProof,
        this.birthProof,
        this.addressProof,
        this.eduProof});

  CertificateDetail.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    imgId = json['img_id'];
    bioId = json['bio_id'];
    photoProof = json['photo_proof'];
    birthProof = json['birth_proof'];
    addressProof = json['address_proof'];
    eduProof = json['edu_proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['img_id'] = this.imgId;
    data['bio_id'] = this.bioId;
    data['photo_proof'] = this.photoProof;
    data['birth_proof'] = this.birthProof;
    data['address_proof'] = this.addressProof;
    data['edu_proof'] = this.eduProof;
    return data;
  }
}

class AstroDetail {
  String astroId;
  String bioId;
  String userId;
  String manglik;
  String horoscope;

  AstroDetail(
      {this.astroId, this.bioId, this.userId, this.manglik, this.horoscope});

  AstroDetail.fromJson(Map<String, dynamic> json) {
    astroId = json['astro_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
    manglik = json['manglik'];
    horoscope = json['horoscope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['astro_id'] = this.astroId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['manglik'] = this.manglik;
    data['horoscope'] = this.horoscope;
    return data;
  }
}

class ContactDetail {
  String contactId;
  String bioId;
  String userId;
  String residenceAddress;
  String pincode;
  String landlineNo;
  String mobileNo;
  String contactEmail;
  String countryId;
  String countryName;
  String stateId;
  String stateName;
  String cityId;
  String cityName;
  String liveswithfmlyn;
  String curliveaddr;
  String candWhatsappno;
  String clcountryId;
  String curlivecountry;
  String clcountryName;
  String clstateId;
  String curlivestated;
  String clstateName;
  String clcityId;
  String curlivecity;
  String visaStatus;

  ContactDetail(
      {this.contactId,
        this.bioId,
        this.userId,
        this.residenceAddress,
        this.pincode,
        this.landlineNo,
        this.mobileNo,
        this.contactEmail,
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
        this.liveswithfmlyn,
        this.curliveaddr,
        this.candWhatsappno,
        this.clcountryId,
        this.curlivecountry,
        this.clcountryName,
        this.clstateId,
        this.curlivestated,
        this.clstateName,
        this.clcityId,
        this.curlivecity,
        this.visaStatus});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    contactId = json['contact_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
    residenceAddress = json['residence_address'];
    pincode = json['pincode'];
    landlineNo = json['landline_no'];
    mobileNo = json['mobile_no'];
    contactEmail = json['contact_email'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    liveswithfmlyn = json['liveswithfmlyn'];
    curliveaddr = json['curliveaddr'];
    candWhatsappno = json['cand_whatsappno'];
    clcountryId = json['clcountry_id'];
    curlivecountry = json['curlivecountry'];
    clcountryName = json['clcountry_name'];
    clstateId = json['clstate_id'];
    curlivestated = json['curlivestated'];
    clstateName = json['clstate_name'];
    clcityId = json['clcity_id'];
    curlivecity = json['curlivecity'];
    visaStatus = json['visa_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_id'] = this.contactId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['residence_address'] = this.residenceAddress;
    data['pincode'] = this.pincode;
    data['landline_no'] = this.landlineNo;
    data['mobile_no'] = this.mobileNo;
    data['contact_email'] = this.contactEmail;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['liveswithfmlyn'] = this.liveswithfmlyn;
    data['curliveaddr'] = this.curliveaddr;
    data['cand_whatsappno'] = this.candWhatsappno;
    data['clcountry_id'] = this.clcountryId;
    data['curlivecountry'] = this.curlivecountry;
    data['clcountry_name'] = this.clcountryName;
    data['clstate_id'] = this.clstateId;
    data['curlivestated'] = this.curlivestated;
    data['clstate_name'] = this.clstateName;
    data['clcity_id'] = this.clcityId;
    data['curlivecity'] = this.curlivecity;
    data['visa_status'] = this.visaStatus;
    return data;
  }
}

class FamilyDetail {
  String familyId;
  String bioId;
  String userId;
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
  String familyAnnualIncome;
  String fatherWhatsapp;
  String motherMob;
  String motherWhatsapp;
  String nativePlace;

  FamilyDetail(
      {this.familyId,
        this.bioId,
        this.userId,
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
        this.familyAnnualIncome,
        this.fatherWhatsapp,
        this.motherMob,
        this.motherWhatsapp,
        this.nativePlace});

  FamilyDetail.fromJson(Map<String, dynamic> json) {
    familyId = json['family_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
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
    familyAnnualIncome = json['family_annual_income'];
    fatherWhatsapp = json['father_whatsapp'];
    motherMob = json['mother_mob'];
    motherWhatsapp = json['mother_whatsapp'];
    nativePlace = json['native_place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_id'] = this.familyId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
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
    data['family_annual_income'] = this.familyAnnualIncome;
    data['father_whatsapp'] = this.fatherWhatsapp;
    data['mother_mob'] = this.motherMob;
    data['mother_whatsapp'] = this.motherWhatsapp;
    data['native_place'] = this.nativePlace;
    return data;
  }
}

class LifestyleDetail {
  String lifestyleId;
  String bioId;
  String userId;
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

  LifestyleDetail(
      {this.lifestyleId,
        this.bioId,
        this.userId,
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
        this.socialLinkedin});

  LifestyleDetail.fromJson(Map<String, dynamic> json) {
    lifestyleId = json['lifestyle_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lifestyle_id'] = this.lifestyleId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
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
    return data;
  }
}

class ProfessionalDetail {
  String professionalId;
  String bioId;
  String userId;
  String workingWith;
  String buisnessType;
  String officeAddress;
  String designationId;
  String designationName;
  String occupationDet;
  List<BusinessTypes> businessTypes;

  ProfessionalDetail(
      {this.professionalId,
        this.bioId,
        this.userId,
        this.workingWith,
        this.buisnessType,
        this.officeAddress,
        this.designationId,
        this.designationName,
        this.occupationDet,
        this.businessTypes});

  ProfessionalDetail.fromJson(Map<String, dynamic> json) {
    professionalId = json['professional_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
    workingWith = json['working_with'];
    buisnessType = json['buisness_type'];
    officeAddress = json['office_address'];
    designationId = json['designation_id'];
    designationName = json['designation_name'];
    occupationDet = json['occupation_det'];
    if (json['business_types'] != null) {
      businessTypes = new List<BusinessTypes>();
      json['business_types'].forEach((v) {
        businessTypes.add(new BusinessTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_id'] = this.professionalId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['working_with'] = this.workingWith;
    data['buisness_type'] = this.buisnessType;
    data['office_address'] = this.officeAddress;
    data['designation_id'] = this.designationId;
    data['designation_name'] = this.designationName;
    data['occupation_det'] = this.occupationDet;
    if (this.businessTypes != null) {
      data['business_types'] =
          this.businessTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessTypes {
  String businessTypeId;
  String businessTypeName;

  BusinessTypes({this.businessTypeId, this.businessTypeName});

  BusinessTypes.fromJson(Map<String, dynamic> json) {
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

class HobbiesDetail {
  String hobbiesId;
  String bioId;
  String userId;
  String hobbies;
  List<HobbiesTypes> hobbiesTypes;

  HobbiesDetail(
      {this.hobbiesId,
        this.bioId,
        this.userId,
        this.hobbies,
        this.hobbiesTypes});

  HobbiesDetail.fromJson(Map<String, dynamic> json) {
    hobbiesId = json['hobbies_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
    hobbies = json['hobbies'];
    if (json['hobbies_types'] != null) {
      hobbiesTypes = new List<HobbiesTypes>();
      json['hobbies_types'].forEach((v) {
        hobbiesTypes.add(new HobbiesTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobbies_id'] = this.hobbiesId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['hobbies'] = this.hobbies;
    if (this.hobbiesTypes != null) {
      data['hobbies_types'] = this.hobbiesTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HobbiesTypes {
  String hobbiesId;
  String hobbiesName;

  HobbiesTypes({this.hobbiesId, this.hobbiesName});

  HobbiesTypes.fromJson(Map<String, dynamic> json) {
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

class EducationDetail {
  String educationId;
  String bioId;
  String userId;
  String educationDetails;
  String academicsDet;
  List<EducationTypes> educationTypes;

  EducationDetail(
      {this.educationId,
        this.bioId,
        this.userId,
        this.educationDetails,
        this.academicsDet,
        this.educationTypes});

  EducationDetail.fromJson(Map<String, dynamic> json) {
    educationId = json['education_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
    educationDetails = json['education_details'];
    academicsDet = json['academics_det'];
    if (json['education_types'] != null) {
      educationTypes = new List<EducationTypes>();
      json['education_types'].forEach((v) {
        educationTypes.add(new EducationTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education_id'] = this.educationId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
    data['education_details'] = this.educationDetails;
    data['academics_det'] = this.academicsDet;
    if (this.educationTypes != null) {
      data['education_types'] =
          this.educationTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EducationTypes {
  String educationId;
  String educationName;
  String catId;

  EducationTypes({this.educationId, this.educationName, this.catId});

  EducationTypes.fromJson(Map<String, dynamic> json) {
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

class WorkingCategoryTypes {
  String business_type_name;
  String business_type_id;

  WorkingCategoryTypes({ this.business_type_id, this.business_type_name });

  WorkingCategoryTypes.fromJson(Map<String, dynamic> json) {
    business_type_name = json['business_type_name'];
    business_type_id = json['business_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_type_name'] = this.business_type_name;
    data['business_type_id'] = this.business_type_id;
    return data;
  }
}

class PartnerDetail {
  String partnerId;
  String bioId;
  String userId;
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
  String partnerEducation;
  String partnerWorkingCategory;
  List<EducationTypes> educationTypes;
  List<WorkingCategoryTypes> workingCategoryTypes;

  PartnerDetail(
      {this.partnerId,
        this.bioId,
        this.userId,
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
        this.educationTypes,
        this.workingCategoryTypes});

  PartnerDetail.fromJson(Map<String, dynamic> json) {
    partnerId = json['partner_id'];
    bioId = json['bio_id'];
    userId = json['user_id'];
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
    partnerEducation = json['partner_education'];
    partnerWorkingCategory = json['partner_working_category'];
    if (json['education_types'] != null) {
      educationTypes = new List<EducationTypes>();
      json['education_types'].forEach((v) {
        educationTypes.add(new EducationTypes.fromJson(v));
      });
    }
    if (json['working_category_types'] != null) {
      workingCategoryTypes = new List<WorkingCategoryTypes>();
      json['working_category_types'].forEach((v) {
        workingCategoryTypes.add(new WorkingCategoryTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partner_id'] = this.partnerId;
    data['bio_id'] = this.bioId;
    data['user_id'] = this.userId;
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
    data['partner_education'] = this.partnerEducation;
    data['partner_working_category'] = this.partnerWorkingCategory;
    if (this.educationTypes != null) {
      data['education_types'] =
          this.educationTypes.map((v) => v.toJson()).toList();
    }
    if (this.workingCategoryTypes != null) {
      data['working_category_types'] =
          this.workingCategoryTypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
