import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Model/Get_CategorypkgList_Model.dart';
import 'package:travelindia/Services/http_services.dart';
import 'package:travelindia/Widgets/custom_loader.dart';

class PackageListController extends GetxController {
  GetPackageListModel getPackageListModel = GetPackageListModel();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    PackageListView();
  }

  Future<void> PackageListView() async {
    try {
      CustomLoader.openCustomLoader();

      var response = await HttpServices.getHttpMethod(url: EndPointConstant.packagelist);

      log("Post product category response ::: $response");
      getPackageListModel = getPackageListModelFromJson(response["body"]);

        if (getPackageListModel.dataCode == "200") {
          CustomLoader.closeCustomLoader();
        } else {
          CustomLoader.closeCustomLoader();
          log("Something went wrong ::: ${getPackageListModel.dataCode}");
        }

    } catch (error, st) {
      CustomLoader.closeCustomLoader();
      log("Exception occurred ::: $error");
      log("Stack trace ::: $st");
    }
  }
}
