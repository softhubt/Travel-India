import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Constant/storage_key_constant.dart';
import 'package:travelindia/Models/post_login_model.dart';
import 'package:travelindia/Services/http_services.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Dashboard_Section/dashboard_view.dart';
import 'package:travelindia/Widgets/custom_loader.dart';
import 'package:travelindia/Widgets/custom_toast.dart';

class LoginController extends GetxController {
  PostLoginModel postLoginModel = PostLoginModel();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future guestLogin() async {
    await StorageServices.setData(
        dataType: StorageKeyConstant.boolType,
        prefKey: StorageKeyConstant.isAuthenticate,
        boolData: false);

    await StorageServices.setData(
        dataType: StorageKeyConstant.boolType,
        prefKey: StorageKeyConstant.isGuest,
        boolData: true);

    Get.offAll(() => const DashboardView());
  }

  Future postLogin() async {
    try {
      if (formKey.currentState!.validate()) {
        CustomLoader.openCustomLoader();

        Map<String, dynamic> payload = {
          "phone": phoneController.text,
          "password": passwordController.text
        };

        var response = await HttpServices.postHttpMethod(
            url: EndPointConstant.signIn,
            payload: payload,
            message: "Post login");

        postLoginModel = postLoginModelFromJson(response["body"]);

        if (postLoginModel.statusCode == "200" ||
            postLoginModel.statusCode == "201") {
          CustomLoader.closeCustomLoader();
          await StorageServices.setData(
              dataType: StorageKeyConstant.boolType,
              prefKey: StorageKeyConstant.isAuthenticate,
              boolData: true);

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.boolType,
          //     prefKey: StorageKeyConstant.isAddressAdded,
          //     boolData: true);

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerName,
          //     stringData: "${postLoginModel.result?.customerName}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerCode,
          //     stringData: "${postLoginModel.result?.customerCode}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerId,
          //     stringData: "${postLoginModel.result?.id}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerPhone,
          //     stringData: "${postLoginModel.result?.phone}");

          // await StorageServices.setData(
          //     dataType: StorageKeyConstant.stringType,
          //     prefKey: StorageKeyConstant.customerEmail,
          //     stringData: "${postLoginModel.result?.email}");

          await StorageServices.setData(
              dataType: StorageKeyConstant.stringType,
              prefKey: StorageKeyConstant.userType,
              stringData: "${postLoginModel.result?.userType}");

          customToast(message: "${postLoginModel.message}");

          Get.offAll(() => const DashboardView());
        } else {
          CustomLoader.closeCustomLoader();
          customToast(message: "${postLoginModel.message}");
        }
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      customToast(message: "Something went wrong");
      log("Something went wrong during login ::: $error");
    }
  }
}
