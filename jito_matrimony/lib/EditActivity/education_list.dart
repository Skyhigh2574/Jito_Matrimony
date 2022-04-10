import 'package:json_annotation/json_annotation.dart';

part 'education_list.g.dart';

@JsonSerializable()
class education_list {
  int status;
  String message;
  List<Datainfo> datainfo;

  education_list(this.status, this.message, this.datainfo);

  education_list.fromJson(Map<String, dynamic> json) {
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
  String catId;
  String catName;
  List<Details> details;

  Datainfo(this.catId, this.catName, this.details);

  Datainfo.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String educationId;
  String educationName;
  String catId;
  String catName;

  Details(this.educationId, this.educationName, this.catId, this.catName);

  Details.fromJson(Map<String, dynamic> json) {
    educationId = json['education_id'];
    educationName = json['education_name'];
    catId = json['cat_id'];
    catName = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education_id'] = this.educationId;
    data['education_name'] = this.educationName;
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    return data;
  }
}
