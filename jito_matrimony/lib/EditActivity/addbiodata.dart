
import 'package:json_annotation/json_annotation.dart';

part 'addbiodata.g.dart';

@JsonSerializable()
class addbiodata {
  int status;
  String message;
  Datainfo datainfo;

  addbiodata({this.status, this.message, this.datainfo});

  addbiodata.fromJson(Map<String, dynamic> json) {
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
  String bioId;

  Datainfo({this.bioId});

  Datainfo.fromJson(Map<String, dynamic> json) {
    bioId = json['bio_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bio_id'] = this.bioId;
    return data;
  }
}
