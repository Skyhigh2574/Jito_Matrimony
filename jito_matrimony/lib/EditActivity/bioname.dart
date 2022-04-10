// import 'package:jito_matrimony/EditActivity/Astro_edit.dart';
// import 'package:jito_matrimony/EditActivity/Contact_edit.dart';
// import 'package:jito_matrimony/EditActivity/Family_edit.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'bioname.g.dart';
//
// @JsonSerializable()
// class bioname {
//   int status;
//   String message;
//   List<Datainfo> datainfo;
//
//   bioname({this.status, this.message, this.datainfo});
//
//   bioname.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['datainfo'] != null) {
//       datainfo = new List<Datainfo>();
//       json['datainfo'].forEach((v) {
//         datainfo.add(new Datainfo.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.datainfo != null) {
//       data['datainfo'] = this.datainfo.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Datainfo {
//   String bioId;
//   String userId;
//   String mFId;
//   String gender;
//   String biodataPerson;
//   String name;
//   String img1;
//   String bioStatus;
//   List<BasicDetail> basicDetail;
//   List<CertificateDetail> certificateDetail;
//   List<AstroDetails> astroDetail;
//   List<ContactDetails> contactDetail;
//   List<FamilyDetails> familyDetail;
//   List<String> lifestyleDetail;
//   List<String> professionalDetail;
//   List<String> hobbiesDetail;
//   List<String> educationDetail;
//   List<String> partnerDetail;
//
//   Datainfo(
//       {this.bioId,
//         this.userId,
//         this.mFId,
//         this.gender,
//         this.biodataPerson,
//         this.name,
//         this.img1,
//         this.bioStatus,
//         this.basicDetail,
//         this.certificateDetail,
//         this.astroDetail,
//         this.contactDetail,
//         this.familyDetail,
//         this.lifestyleDetail,
//         this.professionalDetail,
//         this.hobbiesDetail,
//         this.educationDetail,
//         this.partnerDetail});
//
//   Datainfo.fromJson(Map<String, dynamic> json) {
//     bioId = json['bio_id'];
//     userId = json['user_id'];
//     mFId = json['m_f_id'];
//     gender = json['gender'];
//     biodataPerson = json['biodata_person'];
//     name = json['name'];
//     img1 = json['img_1'];
//     bioStatus = json['bio_status'];
//     if (json['basic_detail'] != null) {
//       basicDetail = new List<BasicDetail>();
//       json['basic_detail'].forEach((v) {
//         basicDetail.add(new BasicDetail.fromJson(v));
//       });
//     }
//     if (json['Certificate_detail'] != null) {
//       certificateDetail = new List<CertificateDetail>();
//       json['Certificate_detail'].forEach((v) {
//         certificateDetail.add(new CertificateDetail.fromJson(v));
//       });
//     }
//     if (json['astro_detail'] != null) {
//       astroDetail = new List<AstroDetails>();
//       json['astro_detail'].forEach((v) {
//         astroDetail.add(new AstroDetails.fromJson(v));
//       });
//     }
//     if (json['contact_detail'] != null) {
//       contactDetail = new List<String>();
//       json['contact_detail'].forEach((v) {
//         contactDetail.add(new String.fromJson(v));
//       });
//     }
//     if (json['family_detail'] != null) {
//       familyDetail = new List<String>();
//       json['family_detail'].forEach((v) {
//         familyDetail.add(new String.fromJson(v));
//       });
//     }
//     if (json['lifestyle_detail'] != null) {
//       lifestyleDetail = new List<String>();
//       json['lifestyle_detail'].forEach((v) {
//         lifestyleDetail.add(new String.fromJson(v));
//       });
//     }
//     if (json['professional_detail'] != null) {
//       professionalDetail = new List<String>();
//       json['professional_detail'].forEach((v) {
//         professionalDetail.add(new String.fromJson(v));
//       });
//     }
//     if (json['hobbies_detail'] != null) {
//       hobbiesDetail = new List<String>();
//       json['hobbies_detail'].forEach((v) {
//         hobbiesDetail.add(new String.fromJson(v));
//       });
//     }
//     if (json['education_detail'] != null) {
//       educationDetail = new List<String>();
//       json['education_detail'].forEach((v) {
//         educationDetail.add(new String.fromJson(v));
//       });
//     }
//     if (json['partner_detail'] != null) {
//       partnerDetail = new List<String>();
//       json['partner_detail'].forEach((v) {
//         partnerDetail.add(new String.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bio_id'] = this.bioId;
//     data['user_id'] = this.userId;
//     data['m_f_id'] = this.mFId;
//     data['gender'] = this.gender;
//     data['biodata_person'] = this.biodataPerson;
//     data['name'] = this.name;
//     data['img_1'] = this.img1;
//     data['bio_status'] = this.bioStatus;
//     if (this.basicDetail != null) {
//       data['basic_detail'] = this.basicDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.certificateDetail != null) {
//       data['Certificate_detail'] =
//           this.certificateDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.astroDetail != null) {
//       data['astro_detail'] = this.astroDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.contactDetail != null) {
//       data['contact_detail'] =
//           this.contactDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.familyDetail != null) {
//       data['family_detail'] = this.familyDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.lifestyleDetail != null) {
//       data['lifestyle_detail'] =
//           this.lifestyleDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.professionalDetail != null) {
//       data['professional_detail'] =
//           this.professionalDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.hobbiesDetail != null) {
//       data['hobbies_detail'] =
//           this.hobbiesDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.educationDetail != null) {
//       data['education_detail'] =
//           this.educationDetail.map((v) => v.toJson()).toList();
//     }
//     if (this.partnerDetail != null) {
//       data['partner_detail'] =
//           this.partnerDetail.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class BasicDetail {
//   String bioId;
//   String userId;
//   String biodataPerson;
//   String name;
//   String gender;
//   String dateOfBirth;
//   String timeOfBirth;
//   String placeOfBirth;
//   String motherToungue;
//   String jainSampradaya;
//   String sangh;
//   String gnyati;
//   String physicalDisability;
//   String physicalDisabilityYes;
//   String maritalStatus;
//   String status;
//   String suspendReason;
//   String currentActivity;
//   String nativePlace;
//
//   BasicDetail(
//       {this.bioId,
//         this.userId,
//         this.biodataPerson,
//         this.name,
//         this.gender,
//         this.dateOfBirth,
//         this.timeOfBirth,
//         this.placeOfBirth,
//         this.motherToungue,
//         this.jainSampradaya,
//         this.sangh,
//         this.gnyati,
//         this.physicalDisability,
//         this.physicalDisabilityYes,
//         this.maritalStatus,
//         this.status,
//         this.suspendReason,
//         this.currentActivity,
//         this.nativePlace});
//
//   BasicDetail.fromJson(Map<String, dynamic> json) {
//     bioId = json['bio_id'];
//     userId = json['user_id'];
//     biodataPerson = json['biodata_person'];
//     name = json['name'];
//     gender = json['gender'];
//     dateOfBirth = json['date_of_birth'];
//     timeOfBirth = json['time_of_birth'];
//     placeOfBirth = json['place_of_birth'];
//     motherToungue = json['mother_toungue'];
//     jainSampradaya = json['jain_sampradaya'];
//     sangh = json['sangh'];
//     gnyati = json['gnyati'];
//     physicalDisability = json['physical_disability'];
//     physicalDisabilityYes = json['physical_disability_yes'];
//     maritalStatus = json['marital_status'];
//     status = json['status'];
//     suspendReason = json['suspend_reason'];
//     currentActivity = json['current_activity'];
//     nativePlace = json['native_place'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bio_id'] = this.bioId;
//     data['user_id'] = this.userId;
//     data['biodata_person'] = this.biodataPerson;
//     data['name'] = this.name;
//     data['gender'] = this.gender;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['time_of_birth'] = this.timeOfBirth;
//     data['place_of_birth'] = this.placeOfBirth;
//     data['mother_toungue'] = this.motherToungue;
//     data['jain_sampradaya'] = this.jainSampradaya;
//     data['sangh'] = this.sangh;
//     data['gnyati'] = this.gnyati;
//     data['physical_disability'] = this.physicalDisability;
//     data['physical_disability_yes'] = this.physicalDisabilityYes;
//     data['marital_status'] = this.maritalStatus;
//     data['status'] = this.status;
//     data['suspend_reason'] = this.suspendReason;
//     data['current_activity'] = this.currentActivity;
//     data['native_place'] = this.nativePlace;
//     return data;
//   }
// }
//
// class CertificateDetail {
//   String userId;
//   String imgId;
//   String bioId;
//   String photoProof;
//   String birthProof;
//   String addressProof;
//   String eduProof;
//
//   CertificateDetail(
//       {this.userId,
//         this.imgId,
//         this.bioId,
//         this.photoProof,
//         this.birthProof,
//         this.addressProof,
//         this.eduProof});
//
//   CertificateDetail.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     imgId = json['img_id'];
//     bioId = json['bio_id'];
//     photoProof = json['photo_proof'];
//     birthProof = json['birth_proof'];
//     addressProof = json['address_proof'];
//     eduProof = json['edu_proof'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['img_id'] = this.imgId;
//     data['bio_id'] = this.bioId;
//     data['photo_proof'] = this.photoProof;
//     data['birth_proof'] = this.birthProof;
//     data['address_proof'] = this.addressProof;
//     data['edu_proof'] = this.eduProof;
//     return data;
//   }
// }
