import 'package:json_annotation/json_annotation.dart';

part 'country_list.g.dart';

@JsonSerializable()
class country_list {
  int status;
  String message;
  List<Datainfo> datainfo;

  country_list({this.status, this.message, this.datainfo});

  country_list.fromJson(Map<String, dynamic> json) {
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
  String countryId;
  String countryName;

  Datainfo({this.countryId, this.countryName});

  Datainfo.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    return data;
  }
}
