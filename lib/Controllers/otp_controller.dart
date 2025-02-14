import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Constant/storage_key_constant.dart';
import 'package:travelindia/Models/verify_otp_model.dart';
import 'package:travelindia/Services/http_services.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Dashboard_Section/dashboard_view.dart';
import 'package:travelindia/Widgets/custom_toast.dart';

class OtpController extends GetxController {
  VerifyOtpModel verifyOtpModel = VerifyOtpModel();

  TextEditingController otpController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxString customerName = "".obs;
  RxString customerCode = "".obs;
  RxString customerId = "".obs;
  RxString customerPhone = "".obs;
  RxString customerEmail = "".obs;
  RxString userType = "".obs;

  Future verifyOtp({required String phone}) async {
    try {
      if (formKey.currentState!.validate()) {
        Map<String, dynamic> payload = {
          "phone": phone,
          "otp": otpController.text
        };

        var response = await HttpServices.postHttpMethod(
            url: EndPointConstant.verifyOtp,
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

          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.userType,
              stringData: "${verifyOtpModel.registerDetails?.userType}");

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
