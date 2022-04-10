

import 'package:json_annotation/json_annotation.dart';

part 'occupation_list.g.dart';

@JsonSerializable()
class occupation_list {
  int status;
  String message;
  List<Datainfo> datainfo;

  occupation_list({this.status, this.message, this.datainfo});

  occupation_list.fromJson(Map<String, dynamic> json) {
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
  String businessTypeId;
  String businessName;

  Datainfo({this.businessTypeId, this.businessName});

  Datainfo.fromJson(Map<String, dynamic> json) {
    businessTypeId = json['business_type_id'];
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_type_id'] = this.businessTypeId;
    data['business_name'] = this.businessName;
    return data;
  }
}
