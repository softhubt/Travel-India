import 'dart:developer';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Models/get_finded_place_list_model.dart';
import 'package:travelindia/Services/http_services.dart';

class FindPlacesController extends GetxController {
  GetFindedPlaceListModel getFindedPlaceListModel = GetFindedPlaceListModel();

  Future initialFunctioun(
      {required String stateName, required String cityName}) async {
    await getFindedPlaceList(stateName: stateName, cityName: cityName);
  }

  Future getFindedPlaceList(
      {required String stateName, required String cityName}) async {
    try {
      Map<String, dynamic> payload = {
        "state_name": stateName,
        "city_name": cityName,
        "category": ""
      };

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.categoryLocationList,
          payload: payload,
          message: "Get state list");

      getFindedPlaceListModel =
          getFindedPlaceListModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
      } else {
        log("Something went wrong during getting finded place list ::: ${getFindedPlaceListModel.code}");
      }
    } catch (error) {
      log("Something went wrong during getting finded place list ::: $error");
    }
  }
}
