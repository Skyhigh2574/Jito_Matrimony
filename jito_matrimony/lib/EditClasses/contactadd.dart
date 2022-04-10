import 'package:json_annotation/json_annotation.dart';

part 'contactadd.g.dart';

@JsonSerializable()
class contactadd {
  int status;
  String message;

  contactadd({this.status, this.message});

  contactadd.fromJson(Map<String, dynamic> json) {
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