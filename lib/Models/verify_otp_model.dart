// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? statusCode;
  String? status;
  String? message;
  RegisterDetails? registerDetails;

  VerifyOtpModel({
    this.statusCode,
    this.status,
    this.message,
    this.registerDetails,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        statusCode: json["status_code"],
        status: json["status"],
        message: json["message"],
        registerDetails: json["register_details"] == null
            ? null
            : RegisterDetails.fromJson(json["register_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status": status,
        "message": message,
        "register_details": registerDetails?.toJson(),
      };
}

class RegisterDetails {
  String? id;
  String? customerName;
  String? customerCode;
  String? email;
  String? phone;
  String? userType;

  RegisterDetails({
    this.id,
    this.customerName,
    this.customerCode,
    this.email,
    this.phone,
    this.userType,
  });

  factory RegisterDetails.fromJson(Map<String, dynamic> json) =>
      RegisterDetails(
        id: json["id"],
        customerName: json["customer_name"],
        customerCode: json["customer_code"],
        email: json["email"],
        phone: json["phone"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "customer_code": customerCode,
        "email": email,
        "phone": phone,
        "user_type": userType,
      };
}
