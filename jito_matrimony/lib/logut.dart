import 'package:json_annotation/json_annotation.dart';

part 'logut.g.dart';

@JsonSerializable()
class Logut {
  int status;
  String message;
  List<Datainfo> datainfo;

  Logut(this.status, this.message, this.datainfo);

  Logut.fromJson(Map<String, dynamic> json) {
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

@JsonSerializable()
class Datainfo {
  String userId;
  String firstName;
  String lastName;
  String email;
  String contactMo;
  String token;
  String deviceToken;
  String deviceId;
  String code;
  String phoneNo;
  String type;
  int otp;
  int otps;

  Datainfo(
      this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.contactMo,
        this.token,
        this.deviceToken,
        this.deviceId,
        this.code,
        this.phoneNo,
        this.type,
        this.otp,
        this.otps);

  Datainfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    contactMo = json['contact_mo'];
    token = json['token'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    code = json['code'];
    phoneNo = json['phone_no'];
    type = json['type'];
    otp = json['otp'];
    otps = json['otps'];
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
    data['code'] = this.code;
    data['phone_no'] = this.phoneNo;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['otps'] = this.otps;
    return data;
  }
}


