import 'package:json_annotation/json_annotation.dart';

part 'favouriteadd.g.dart';

@JsonSerializable()
class favouriteadd {
  int status;
  String message;

  favouriteadd({this.status, this.message});

  favouriteadd.fromJson(Map<String, dynamic> json) {
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