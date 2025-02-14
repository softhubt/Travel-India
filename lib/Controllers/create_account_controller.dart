import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Constant/storage_key_constant.dart';
import 'package:travelindia/Models/get_otp_model.dart';
import 'package:travelindia/Models/verify_otp_model.dart';
import 'package:travelindia/Services/http_services.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Dashboard_Section/dashboard_view.dart';
import 'package:travelindia/Widgets/custom_toast.dart';

class CreateAccountController extends GetxController {
  GetOtpModel getOtpModel = GetOtpModel();
  VerifyOtpModel verifyOtpModel = VerifyOtpModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future getOtp() async {
    try {
      if (formKey.currentState!.validate()) {
        Map<String, dynamic> payload = {
          "customer_name": nameController.text,
          "phone": phoneController.text,
          "email": emailController.text,
          "password": passwordController.text
        };

        var response = await HttpServices.postHttpMethod(
            url: EndPointConstant.sendOtp,
            payload: payload,
            message: "Get otp");

        getOtpModel = getOtpModelFromJson(response["body"]);

        if (getOtpModel.statusCode == "200" ||
            getOtpModel.statusCode == "201") {
          verifyOtp(phone: phoneController.text);
        } else {
          customToast(message: "${getOtpModel.message}");
        }
      }
    } catch (error) {
      customToast(message: "Something went wrong");
      log("Something went wrong during getting otp ::: $error");
    }
  }

  Future verifyOtp({required String phone}) async {
    try {
      if (formKey.currentState!.validate()) {
        Map<String, dynamic> payload = {"phone": phone};

        var response = await HttpServices.postHttpMethod(
            url: EndPointConstant.verifyMobile,
            payload: payload,
            message: "Post verify otp");

        verifyOtpModel = verifyOtpModelFromJson(response["body"]);

        if (verifyOtpModel.statusCode == "200" ||
            verifyOtpModel.statusCode == "201") {
          await StorageServices.setData(
              dataType: StorageKeyConstant.boolType,
              prefKey: StorageKeyConstant.isAuthenticate,
              boolData: true);

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerName,
          //     stringData: "${verifyOtpModel.registerDetails?.customerName}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerCode,
          //     stringData: "${verifyOtpModel.registerDetails?.customerCode}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerId,
          //     stringData: "${verifyOtpModel.registerDetails?.id}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerPhone,
          //     stringData: "${verifyOtpModel.registerDetails?.phone}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerEmail,
          //     stringData: "${verifyOtpModel.registerDetails?.email}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.userType,
          //     stringData: "${verifyOtpModel.registerDetails?.userType}");

          customToast(message: "${verifyOtpModel.message}");

          Get.offAll(() => const DashboardView());
        } else {
          customToast(message: "${verifyOtpModel.message}");
        }
      }
    } catch (error) {
      customToast(message: "Something went wrong");
      log("Something went wrong during verifying otp ::: $error");
    }
  }
}
