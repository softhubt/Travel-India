import 'dart:convert';

PostUserFormModel postUserFormModelFromJson(String str) =>
    PostUserFormModel.fromJson(json.decode(str));

String postUserFormModelToJson(PostUserFormModel data) =>
    json.encode(data.toJson());

class PostUserFormModel {
  String? code;
  String? message;

  PostUserFormModel({
    this.code,
    this.message,
  });

  factory PostUserFormModel.fromJson(Map<String, dynamic> json) =>
      PostUserFormModel(
        code: json["code"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "Message": message,
      };
}
