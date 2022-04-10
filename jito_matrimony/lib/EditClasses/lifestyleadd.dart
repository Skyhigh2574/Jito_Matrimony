import 'package:json_annotation/json_annotation.dart';

part 'lifestyleadd.g.dart';

@JsonSerializable()
class lifestyleadd {
  int status;
  String message;

  lifestyleadd({this.status, this.message});

  lifestyleadd.fromJson(Map<String, dynamic> json) {
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