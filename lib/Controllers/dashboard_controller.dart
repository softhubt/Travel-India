import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Model/Post_City_List_Model.dart';
import 'package:travelindia/Model/StateList_Model.dart';
import 'package:travelindia/Model/Get_CategorypkgList_Model.dart';
import 'package:travelindia/Services/http_services.dart';
import 'package:travelindia/Widgets/custom_loader.dart';

class DashboardController extends GetxController {
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  GetPackageListModel getPackageListModel = GetPackageListModel();
  StateListModel stateListModel = StateListModel();
  GetcityListModel getcityListModel = GetcityListModel();

  var currentState = ''.obs;
  var currentCity = ''.obs;
  RxString currentAddress = "".obs;
  //RxString selectedStateName = RxString("");
  RxString selectedStateName = "".obs;

  Future initialFunctioun() async {
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        currentAddress.value =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.isoCountryCode}";
        currentState.value = place.administrativeArea ?? '';
        currentCity.value = place.locality ?? '';
      } else {
        log("No place mark available");
      }
    } catch (error) {
      log("Something went wrong during getting current location ::: $error");
    }
  }

  Future<void> StateListView() async {
    try {
      CustomLoader.openCustomLoader();

      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.statelist);

      log("Post product category response ::: $response");
      stateListModel = stateListModelFromJson(response["body"]);

      if (stateListModel.dataCode == "200") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong ::: ${stateListModel.dataCode}");
      }
    } catch (error, st) {
      CustomLoader.closeCustomLoader();
      log("Exception occurred ::: $error");
      log("Stack trace ::: $st");
    }
  }

  Future CityListView(String stateName) async {
    try {
      CustomLoader.openCustomLoader();

      Map<String, dynamic> payload = {"state_name": stateName};

      log("Get profile payload ::: $payload");
      getcityListModel = getcityListModelFromJson(payload["body"]);

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.citylist, payload: payload);

      log("Get profile response ::: $response");

      getcityListModel = getcityListModelFromJson(response["body"]);

      if (getcityListModel.dataCode == "200" ||
          getcityListModel.dataCode == "201") {
        CustomLoader.closeCustomLoader();
      } else {
        CustomLoader.closeCustomLoader();
        log("Something went wrong during getting profile :: ${getcityListModel.dataCode}");
      }
    } catch (error) {
      CustomLoader.closeCustomLoader();
      debugPrint("Something went wrong during getting profile ::: $error");
    }
  }

  Future<void> PackageListView() async {
    try {
      CustomLoader.openCustomLoader();

      var response =
          await HttpServices.getHttpMethod(url: EndPointConstant.packagelist);

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
