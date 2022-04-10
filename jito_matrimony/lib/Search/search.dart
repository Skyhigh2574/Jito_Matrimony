import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable()
class search {
  int status;
  String message;
  String fltCnt;
  String totCnt;
  List<Datainfo> datainfo;

  search(
      {this.status, this.message, this.fltCnt, this.totCnt, this.datainfo});

  search.fromJson(Map<String, dynamic> json) {
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
  String name;
  String motherToungue;
  String jainSampradaya;
  String height;
  String age;
  String country;
  String state;
  String city;
  String img1;
  String img2;
  String img3;
  String imgmed1;
  String imgmed2;
  String imgmed3;
  String imgsmall1;
  String imgsmall2;
  String imgsmall3;
  String profileId;
  String video1;

  Datainfo(
      {this.id,
        this.name,
        this.motherToungue,
        this.jainSampradaya,
        this.height,
        this.age,
        this.country,
        this.state,
        this.city,
        this.img1,
        this.img2,
        this.img3,
        this.imgmed1,
        this.imgmed2,
        this.imgmed3,
        this.imgsmall1,
        this.imgsmall2,
        this.imgsmall3,
        this.profileId,
        this.video1});

  Datainfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    motherToungue = json['mother_toungue'];
    jainSampradaya = json['jain_sampradaya'];
    height = json['height'];
    age = json['age'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    img1 = json['img_1'];
    img2 = json['img_2'];
    img3 = json['img_3'];
    imgmed1 = json['imgmed_1'];
    imgmed2 = json['imgmed_2'];
    imgmed3 = json['imgmed_3'];
    imgsmall1 = json['imgsmall_1'];
    imgsmall2 = json['imgsmall_2'];
    imgsmall3 = json['imgsmall_3'];
    profileId = json['profile_id'];
    video1 = json['video1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mother_toungue'] = this.motherToungue;
    data['jain_sampradaya'] = this.jainSampradaya;
    data['height'] = this.height;
    data['age'] = this.age;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['img_1'] = this.img1;
    data['img_2'] = this.img2;
    data['img_3'] = this.img3;
    data['imgmed_1'] = this.imgmed1;
    data['imgmed_2'] = this.imgmed2;
    data['imgmed_3'] = this.imgmed3;
    data['imgsmall_1'] = this.imgsmall1;
    data['imgsmall_2'] = this.imgsmall2;
    data['imgsmall_3'] = this.imgsmall3;
    data['profile_id'] = this.profileId;
    data['video1'] = this.video1;
    return data;
  }
}
