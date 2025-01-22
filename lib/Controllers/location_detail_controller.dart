import 'dart:developer';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Models/get_finded_place_list_model.dart';
import 'package:travelindia/Models/get_location_detail_model.dart';
import 'package:travelindia/Services/http_services.dart';

class LocationDetailController extends GetxController {
  Rx<GetLocationDetailModel> getLocationDetailModel =
      GetLocationDetailModel().obs;

  Future initialFunctioun({required String location}) async {
    await getFindedPlaceList(location: location);
  }

  Future getFindedPlaceList({required String location}) async {
    try {
      Map<String, dynamic> payload = {"location_name": location};

      var response = await HttpServices.postHttpMethod(
        url: EndPointConstant.locationDetails,
        payload: payload,
        message: "Get location details",
      );

      getLocationDetailModel.value =
          getLocationDetailModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
        log("Data fetched successfully!");
      } else {
        log("Error code: ${getLocationDetailModel.value.dataCode}");
      }
    } catch (error) {
      log("Something went wrong during getting finded place list ::: $error");
    }
  }
}
