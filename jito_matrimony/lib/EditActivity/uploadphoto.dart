import 'package:json_annotation/json_annotation.dart';

part 'uploadphoto.g.dart';

@JsonSerializable()
class uploadphoto {
  int status;
  String message;

  uploadphoto({this.status, this.message});

  uploadphoto.fromJson(Map<String, dynamic> json) {
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
