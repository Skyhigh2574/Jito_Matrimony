import 'package:json_annotation/json_annotation.dart';

part 'Hobbies_list.g.dart';

@JsonSerializable()
class Hobbies_list {
  int status;
  String message;
  List<Datainfo> datainfo;

  Hobbies_list({this.status, this.message, this.datainfo});

  Hobbies_list.fromJson(Map<String, dynamic> json) {
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
  String hobbiesId;
  String hobbiesName;

  Datainfo({this.hobbiesId, this.hobbiesName});

  Datainfo.fromJson(Map<String, dynamic> json) {
    hobbiesId = json['hobbies_id'];
    hobbiesName = json['hobbies_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobbies_id'] = this.hobbiesId;
    data['hobbies_name'] = this.hobbiesName;
    return data;
  }
}
