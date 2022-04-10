import 'package:json_annotation/json_annotation.dart';

part 'educationadd.g.dart';

@JsonSerializable()
class educationadd {
  int status;
  String message;

  educationadd({this.status, this.message});

  educationadd.fromJson(Map<String, dynamic> json) {
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