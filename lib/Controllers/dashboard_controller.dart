import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Models/get_category_list_model.dart';
import 'package:travelindia/Models/get_city_list_model.dart';
import 'package:travelindia/Models/get_package_list_model.dart';
import 'package:travelindia/Models/get_state_list_model.dart';
import 'package:travelindia/Services/http_services.dart';

class DashboardController extends GetxController {
  GetStateListModel getStateListModel = GetStateListModel();
  GetCityListModel getCityListModel = GetCityListModel();
  GetPackageListModel getPackageListModel = GetPackageListModel();
  Rx<GetCategoryListModel> getCategoryListModel = GetCategoryListModel().obs;

  RxList<String> stateList = <String>[].obs;
  RxList<String> cityList = <String>[].obs;

  RxString currentAddress = "".obs;
  RxString currentState = "".obs;
  RxString currentCity = "".obs;
  RxString selectedState = "".obs;
  RxString selectedCity = "".obs;

  Future initialFunctioun() async {
    await getCurrentLocation();
    await getStateList();
    await getPackageList();
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

      getPackageListModel = getPackageListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
      } else {
        log("Something went wrong during getting package list ::: ${getPackageListModel.dataCode}");
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
}
