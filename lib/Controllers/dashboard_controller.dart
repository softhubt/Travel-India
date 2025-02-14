import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Models/get_category_list_model.dart';
import 'package:travelindia/Models/get_city_list_model.dart';
import 'package:travelindia/Models/get_finded_place_list_model.dart';
import 'package:travelindia/Models/get_package_list_model.dart';
import 'package:travelindia/Models/get_state_list_model.dart';
import 'package:travelindia/Services/http_services.dart';

class DashboardController extends GetxController {
  GetStateListModel getStateListModel = GetStateListModel();
  GetCityListModel getCityListModel = GetCityListModel();
  Rx<GetPackageListModel> getPackageListModel = GetPackageListModel().obs;
  Rx<GetCategoryListModel> getCategoryListModel = GetCategoryListModel().obs;
  Rx<GetFindedPlaceListModel> getFindedPlaceListModel =
      GetFindedPlaceListModel().obs;

  TextEditingController searchStateController = TextEditingController();
  TextEditingController searchCityController = TextEditingController();

  RxList<String> stateList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;

  late Position currentLocation;

  RxString currentAddress = "".obs;
  RxString currentState = "".obs;
  RxString currentCity = "".obs;
  RxString selectedState = "".obs;
  RxString selectedCity = "".obs;

  RxBool showFoundPlaces = false.obs;

  Future initialFunctioun() async {
    await getCurrentLocation();
    await getStateList();
    await getPackageList();
    await getCategoryList();
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
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        currentLocation = position;
        log("----------------------------------------------------------------------------------------------------");
        log("Name ::: ${place.name}");
        log("Administrative area ::: ${place.administrativeArea}");
        log("Country ::: ${place.country}");
        log("Iso country code ::: ${place.isoCountryCode}");
        log("Locality ::: ${place.locality}");
        log("Postal code ::: ${place.postalCode}");
        log("Street ::: ${place.street}");
        log("SubAdministrative Area ::: ${place.subAdministrativeArea}");
        log("SubLocality ::: ${place.subLocality}");
        log("SubThoroughfare ::: ${place.subThoroughfare}");
        log("Thoroughfare ::: ${place.thoroughfare}");
        log("----------------------------------------------------------------------------------------------------");

        // cityController.text = "${place.subAdministrativeArea}";
        // stateController.text = "${place.administrativeArea}";
        // postalCodeController.text = "${place.postalCode}";
        // addressController.text =
        //     "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.isoCountryCode}";
        // selectedLatLong.value = "${position.latitude}, ${position.longitude}";
      } else {
        log("No place mark available");
      }
    } catch (error) {
      log("Something went wrong during getting current location ::: $error");
    }
  }

  Future getStateList() async {
    try {
      var response = await HttpServices.getHttpMethod(
          url: EndPointConstant.statelist, message: "Get state list");

      getStateListModel = getStateListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
        getStateListModel.itemlist?.forEach(
          (element) {
            stateList.add(element.name ?? "");
          },
        );
      } else {
        log("Something went wrong during getting state list ::: ${getStateListModel.dataCode}");
      }
    } catch (error) {
      log("Something went wrong during getting state list ::: $error");
    }
  }

  Future getCityList({required String state}) async {
    try {
      cityList.clear(); // Clear the city list before fetching new cities
      Map<String, dynamic> payload = {"state_name": state};

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.citylist,
          payload: payload,
          message: "Get city list");

      getCityListModel = getCityListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
        getCityListModel.itemlist?.forEach(
          (element) {
            cityList.add(element.name ?? "");
          },
        );
      } else {
        log("Something went wrong during getting city list ::: ${getCityListModel.dataCode}");
      }
    } catch (error) {
      log("Something went wrong during getting city list ::: $error");
    }
  }

  Future getPackageList() async {
    try {
      var response = await HttpServices.getHttpMethod(
          url: EndPointConstant.packagelist, message: "Get package list");

      getPackageListModel.value = getPackageListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
      } else {
        log("Something went wrong during getting package list ::: ${getPackageListModel.value.dataCode}");
      }
    } catch (error) {
      log("Something went wrong during getting package list ::: $error");
    }
  }

  Future getCategoryList() async {
    try {
      var response = await HttpServices.getHttpMethod(
          url: EndPointConstant.categoryList, message: "Get category list");

      getCategoryListModel.value =
          getCategoryListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
      } else {
        log("Something went wrong during getting category list ::: ${getCategoryListModel.value.dataCode}");
      }
    } catch (error) {
      log("Something went wrong during getting category list ::: $error");
    }
  }

  Future getFindedPlaceList() async {
    try {
      Map<String, dynamic> payload = {
        "state_name": selectedState.value,
        "city_name": selectedCity.value,
        "category": ""
      };

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.categoryLocationList,
          payload: payload,
          message: "Get state list");

      getFindedPlaceListModel.value =
          getFindedPlaceListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
        showFoundPlaces.value = true;
      } else {
        log("Something went wrong during getting finded place list ::: ${getFindedPlaceListModel.value.code}");
      }
    } catch (error) {
      log("Something went wrong during getting finded place list ::: $error");
    }
  }
}
