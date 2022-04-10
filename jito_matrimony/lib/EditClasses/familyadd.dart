import 'package:json_annotation/json_annotation.dart';

part 'familyadd.g.dart';

@JsonSerializable()
class familyadd {
  int status;
  String message;

  familyadd(this.status, this.message);

  familyadd.fromJson(Map<String, dynamic> json) {
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