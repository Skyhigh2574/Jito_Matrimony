import 'package:json_annotation/json_annotation.dart';

part 'advertisement.g.dart';

@JsonSerializable()
class advertisement {
  int status;
  String message;
  List<Datainfo> datainfo;
  String inclompete;
  String popopTitle;
  String videoYN;
  String updCmpYN;
  String addBioYN;
  String userType;

  advertisement(
      {this.status,
        this.message,
        this.datainfo,
        this.inclompete,
        this.popopTitle,
        this.videoYN,
        this.updCmpYN,
        this.addBioYN,
        this.userType});

  advertisement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['datainfo'] != null) {
      datainfo = new List<Datainfo>();
      json['datainfo'].forEach((v) {
        datainfo.add(new Datainfo.fromJson(v));
      });
    }
    inclompete = json['inclompete'];
    popopTitle = json['popop_title'];
    videoYN = json['VideoYN'];
    updCmpYN = json['UpdCmpYN'];
    addBioYN = json['AddBioYN'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datainfo != null) {
      data['datainfo'] = this.datainfo.map((v) => v.toJson()).toList();
    }
    data['inclompete'] = this.inclompete;
    data['popop_title'] = this.popopTitle;
    data['VideoYN'] = this.videoYN;
    data['UpdCmpYN'] = this.updCmpYN;
    data['AddBioYN'] = this.addBioYN;
    data['user_type'] = this.userType;
    return data;
  }
}

class Datainfo {
  String adsId;
  String userId;
  String bottomImage;
  String fullImage;
  String websideUrl;
  String type;

  Datainfo(
      {this.adsId,
        this.userId,
        this.bottomImage,
        this.fullImage,
        this.websideUrl,
        this.type});

  Datainfo.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    userId = json['user_id'];
    bottomImage = json['bottom_image'];
    fullImage = json['full_image'];
    websideUrl = json['webside_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_id'] = this.adsId;
    data['user_id'] = this.userId;
    data['bottom_image'] = this.bottomImage;
    data['full_image'] = this.fullImage;
    data['webside_url'] = this.websideUrl;
    data['type'] = this.type;
    return data;
  }
}
