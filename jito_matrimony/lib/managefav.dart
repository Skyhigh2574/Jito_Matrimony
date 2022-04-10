import 'package:json_annotation/json_annotation.dart';

part 'managefav.g.dart';

@JsonSerializable()
class managefav {
  int status;
  String message;
  List<Datainfo> datainfo;

  managefav({this.status, this.message, this.datainfo});

  managefav.fromJson(Map<String, dynamic> json) {
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
  String favouriteId;
  String userId;
  String senderId;
  String addedId;
  String profileId;
  String requestType;
  String addedName;
  String addedImage;
  String img1;
  String img2;
  String img3;
  String imgmed1;
  String imgmed2;
  String imgmed3;
  String imgsmall1;
  String imgsmall2;
  String imgsmall3;
  String sendDate;
  String sendTime;
  String name;
  String gender;
  String motherToungue;
  String jainSampradaya;
  String height;
  String age;
  String country;
  String state;
  String city;

  Datainfo(
      {this.favouriteId,
        this.userId,
        this.senderId,
        this.addedId,
        this.profileId,
        this.requestType,
        this.addedName,
        this.addedImage,
        this.img1,
        this.img2,
        this.img3,
        this.imgmed1,
        this.imgmed2,
        this.imgmed3,
        this.imgsmall1,
        this.imgsmall2,
        this.imgsmall3,
        this.sendDate,
        this.sendTime,
        this.name,
        this.gender,
        this.motherToungue,
        this.jainSampradaya,
        this.height,
        this.age,
        this.country,
        this.state,
        this.city});

  Datainfo.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favourite_id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    addedId = json['added_id'];
    profileId = json['profile_id'];
    requestType = json['request_type'];
    addedName = json['added_name'];
    addedImage = json['added_image'];
    img1 = json['img_1'];
    img2 = json['img_2'];
    img3 = json['img_3'];
    imgmed1 = json['imgmed_1'];
    imgmed2 = json['imgmed_2'];
    imgmed3 = json['imgmed_3'];
    imgsmall1 = json['imgsmall_1'];
    imgsmall2 = json['imgsmall_2'];
    imgsmall3 = json['imgsmall_3'];
    sendDate = json['send_date'];
    sendTime = json['send_time'];
    name = json['name'];
    gender = json['gender'];
    motherToungue = json['mother_toungue'];
    jainSampradaya = json['jain_sampradaya'];
    height = json['height'];
    age = json['age'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favourite_id'] = this.favouriteId;
    data['user_id'] = this.userId;
    data['sender_id'] = this.senderId;
    data['added_id'] = this.addedId;
    data['profile_id'] = this.profileId;
    data['request_type'] = this.requestType;
    data['added_name'] = this.addedName;
    data['added_image'] = this.addedImage;
    data['img_1'] = this.img1;
    data['img_2'] = this.img2;
    data['img_3'] = this.img3;
    data['imgmed_1'] = this.imgmed1;
    data['imgmed_2'] = this.imgmed2;
    data['imgmed_3'] = this.imgmed3;
    data['imgsmall_1'] = this.imgsmall1;
    data['imgsmall_2'] = this.imgsmall2;
    data['imgsmall_3'] = this.imgsmall3;
    data['send_date'] = this.sendDate;
    data['send_time'] = this.sendTime;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['mother_toungue'] = this.motherToungue;
    data['jain_sampradaya'] = this.jainSampradaya;
    data['height'] = this.height;
    data['age'] = this.age;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}
