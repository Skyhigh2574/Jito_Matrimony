import 'package:json_annotation/json_annotation.dart';

part 'partneradd.g.dart';

@JsonSerializable()
class partneradd {
  int status;
  String message;

  partneradd({this.status, this.message});

  partneradd.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}