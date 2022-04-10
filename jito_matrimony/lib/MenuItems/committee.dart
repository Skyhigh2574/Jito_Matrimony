
import 'package:json_annotation/json_annotation.dart';

part 'committee.g.dart';

@JsonSerializable()
class committee {
  int status;
  String message;
  Datainfo datainfo;

  committee({this.status, this.message, this.datainfo});

  committee.fromJson(Map<String, dynamic> json) {
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
  String cmsId;
  String name;
  String slug;
  String details;

  Datainfo({this.cmsId, this.name, this.slug, this.details});

  Datainfo.fromJson(Map<String, dynamic> json) {
    cmsId = json['cms_id'];
    name = json['name'];
    slug = json['slug'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cms_id'] = this.cmsId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['details'] = this.details;
    return data;
  }
}
