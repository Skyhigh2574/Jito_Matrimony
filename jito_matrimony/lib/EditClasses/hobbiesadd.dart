import 'package:json_annotation/json_annotation.dart';

part 'hobbiesadd.g.dart';

@JsonSerializable()
class hobbiesadd {
  int status;
  String message;

  hobbiesadd({this.status, this.message});

  hobbiesadd.fromJson(Map<String, dynamic> json) {
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