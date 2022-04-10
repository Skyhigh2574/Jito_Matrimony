import 'package:json_annotation/json_annotation.dart';

part 'professionaladd.g.dart';

@JsonSerializable()
class professionaladd {
  int status;
  String message;

  professionaladd({this.status, this.message});

  professionaladd.fromJson(Map<String, dynamic> json) {
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