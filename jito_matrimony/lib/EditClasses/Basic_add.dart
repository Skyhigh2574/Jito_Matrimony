import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Basic_add.g.dart';

@JsonSerializable()
class Basic_add {
  int status;
  String message;

  Basic_add({this.status, this.message});

  Basic_add.fromJson(Map<String, dynamic> json) {
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