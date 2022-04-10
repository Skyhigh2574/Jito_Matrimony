import 'package:json_annotation/json_annotation.dart';

part 'feedbacklist.g.dart';

@JsonSerializable()
class feedbacklist {
  int status;
  String message;

  feedbacklist({this.status, this.message});

  feedbacklist.fromJson(Map<String, dynamic> json) {
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