import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/endpoint_constant.dart';
import 'package:travelindia/Constant/storage_key_constant.dart';
import 'package:travelindia/Models/post_user_form_model.dart';
import 'package:travelindia/Services/http_services.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Dashboard_Section/dashboard_view.dart';
import 'package:travelindia/Widgets/custom_toast.dart';

class UserFormController extends GetxController {
  PostUserFormModel postUserFormModel = PostUserFormModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController noOfPersonController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  DateTime? fromDate;
  DateTime? toDate;

  Future initialFunctuon() async {
    nameController.text = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey:
                "${StorageKeyConstant.firstName} ${StorageKeyConstant.lastName}") ??
        "";
  }

  Future<void> selectFromDate({required BuildContext context}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != fromDate) {
      fromDate = picked;
      toDate = null; // Reset toDate when fromDate is changed
    }
  }

  Future<void> selectToDate({required BuildContext context}) async {
    if (fromDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please select the From Date first."),
      ));
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate!,
      firstDate: fromDate!,
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != toDate) {
      toDate = picked;
    }
  }

  void validateFields({required String formType}) {
    if (formKey.currentState!.validate()) {
      if (fromDate != null) {
        if (toDate != null) {
          postSubmitUserForm(formType: formType);
        } else {
          customToast(message: "Select the To Date");
        }
      } else {
        customToast(message: "Select the From Date");
      }
    }
  }

  Future postSubmitUserForm({required String formType}) async {
    try {
      Map<String, dynamic> payload = {
        "name": nameController.text,
        "contact": phoneController.text,
        "no_of_person": noOfPersonController.text,
        "date": "$fromDate",
        "no_of_days": "$toDate",
        "location": adressController.text,
        "form_type": formType,
      };

      var response = await HttpServices.postHttpMethod(
          url: EndPointConstant.userForm,
          payload: payload,
          message: "Post submit user form");

      postUserFormModel = postUserFormModelFromJson(response["body"]);

      if (response["status_code"] == 200 || response["status_code"] == 201) {
        customToast(message: "${postUserFormModel.message}");
        Get.offAll(() => const DashboardView());
      } else {
        customToast(message: "${postUserFormModel.message}");
      }
    } catch (error) {
      log("Something went wrong durig posting form  ::: $error");
    }
  }
}
