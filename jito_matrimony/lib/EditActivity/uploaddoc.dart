import 'package:json_annotation/json_annotation.dart';

part 'uploaddoc.g.dart';

@JsonSerializable()
class uploaddoc {
  int status;
  String message;

  uploaddoc({this.status, this.message});

  uploaddoc.fromJson(Map<String, dynamic> json) {
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