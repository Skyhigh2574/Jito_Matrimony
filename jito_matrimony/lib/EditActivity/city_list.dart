import 'package:json_annotation/json_annotation.dart';

part 'city_list.g.dart';

@JsonSerializable()
class city_list {
  int status;
  String message;
  List<Datainfo> datainfo;

  city_list({this.status, this.message, this.datainfo});

  city_list.fromJson(Map<String, dynamic> json) {
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
  String cityId;
  String cityName;
  String stateId;

  Datainfo({this.cityId, this.cityName, this.stateId});

  Datainfo.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['state_id'] = this.stateId;
    return data;
  }
}
