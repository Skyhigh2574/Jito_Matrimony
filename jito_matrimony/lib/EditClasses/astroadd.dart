import 'package:json_annotation/json_annotation.dart';

part 'astroadd.g.dart';

@JsonSerializable()
class astroadd {
  int status;
  String message;

  astroadd({this.status, this.message});

  astroadd.fromJson(Map<String, dynamic> json) {
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