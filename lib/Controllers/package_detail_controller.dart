import 'dart:developer';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Models/get_package_detail_model.dart';
import 'package:travelindia/Services/http_services.dart';

class PackageDetailController extends GetxController {
  GetPackageDetailModel getPackageDetailModel = GetPackageDetailModel();

  Future initialFuncion({required String id}) async {
    await getPackageDetails(id: id);
  }

  Future getPackageDetails({required String id}) async {
    try {
      Map<String, dynamic> payload = {"id": id};

      final response = await HttpServices.postHttpMethod(
          url: EndPointConstant.packageDetails,
          payload: payload,
          message: "Get package details");

      getPackageDetailModel = getPackageDetailModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
      } else {
        log("Something went wrong during getting package details ::: ${getPackageDetailModel.dataCode}");
      }
    } catch (error) {
      log("Something went wrong during getting package details ::: $error");
    }
  }
}
