import 'package:json_annotation/json_annotation.dart';

part 'registeration.g.dart';

@JsonSerializable()
class registeration {
  int status;
  String message;
  Datainfo datainfo;

  registeration({this.status, this.message, this.datainfo});

  registeration.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    datainfo = json['datainfo'] != null
        ? new Datainfo.fromJson(json['datainfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.datainfo != null) {
      data['datainfo'] = this.datainfo.toJson();
    }
    return data;
  }
}

class Datainfo {
  String userId;
  String firstName;
  String lastName;
  String email;
  String contactMo;
  String token;
  String deviceToken;
  String deviceId;

  Datainfo(
      {this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.contactMo,
        this.token,
        this.deviceToken,
        this.deviceId});

  Datainfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    contactMo = json['contact_mo'];
    token = json['token'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['contact_mo'] = this.contactMo;
    data['token'] = this.token;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    return data;
  }
}