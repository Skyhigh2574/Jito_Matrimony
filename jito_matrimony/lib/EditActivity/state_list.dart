
import 'package:json_annotation/json_annotation.dart';

part 'state_list.g.dart';

@JsonSerializable()
class state_list {
  int status;
  String message;
  List<Datainfo> datainfo;

  state_list({this.status, this.message, this.datainfo});

  state_list.fromJson(Map<String, dynamic> json) {
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
  String stateId;
  String stateName;
  String countryId;

  Datainfo({this.stateId, this.stateName, this.countryId});

  Datainfo.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['country_id'] = this.countryId;
    return data;
  }
}
