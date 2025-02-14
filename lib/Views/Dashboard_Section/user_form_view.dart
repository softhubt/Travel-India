import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/user_form_controller.dart';
import 'package:travelindia/Services/form_validation_services.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:travelindia/Widgets/custom_textfield.dart';

class UserFormView extends StatefulWidget {
  final String formType;
  const UserFormView({super.key, required this.formType});

  @override
  State<UserFormView> createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  UserFormController controller = Get.put(UserFormController());

  @override
  void initState() {
    super.initState();
    controller.initialFunctuon().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
          title: const Text('Place Details',
              style: TextStyle(color: ColorConstant.white))),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeightPadding),
              Text("Name", style: TextStyleConstant.medium16()),
              CustomTextField(
                  controller: controller.nameController,
                  hintText: "Enter Name",
                  prefixIcon: const Icon(Icons.person_rounded),
                  textInputType: TextInputType.name,
                  validator:
                      FormValidationServices.validateField(fieldName: "Name")),
              responsiveSizedBoxHeight(height: 14),
              Text("Phone", style: TextStyleConstant.medium16()),
              CustomTextField(
                  controller: controller.phoneController,
                  hintText: "Enter phone",
                  prefixIcon: const Icon(Icons.phone_rounded),
                  textInputType: TextInputType.phone,
                  validator: FormValidationServices.validatePhone()),
              responsiveSizedBoxHeight(height: 14),
              Text("No of Person", style: TextStyleConstant.medium16()),
              CustomTextField(
                  controller: controller.noOfPersonController,
                  hintText: "Enter No of Person",
                  prefixIcon: const Icon(Icons.groups_rounded),
                  textInputType: TextInputType.number,
                  validator: FormValidationServices.validateField(
                      fieldName: "No of Person")),
              responsiveSizedBoxHeight(height: 14),
              Text("Address", style: TextStyleConstant.medium16()),
              CustomTextField(
                  controller: controller.adressController,
                  hintText: "Enter address",
                  prefixIcon: const Icon(Icons.pin_drop_rounded),
                  textInputType: TextInputType.streetAddress,
                  validator: FormValidationServices.validateField(
                      fieldName: "Address")),
              Container(
                  height: Get.height * 0.073,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            controller
                                .selectFromDate(context: context)
                                .whenComplete(() => setState(() {}));
                          },
                          child: Container(
                              height: Get.height * 0.062,
                              width: Get.width * 0.365,
                              decoration: BoxDecoration(
                                  color: ColorConstant.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.center,
                              child: Text(
                                  (controller.fromDate == null)
                                      ? "From"
                                      : "${controller.fromDate!.day}-${controller.fromDate!.month}-${controller.fromDate!.year}",
                                  style: TextStyleConstant.medium18(
                                      color: ColorConstant.white)))),
                      Text("to", style: TextStyleConstant.semiBold20()),
                      InkWell(
                          onTap: () {
                            controller
                                .selectToDate(context: context)
                                .whenComplete(() => setState(() {}));
                          },
                          child: Container(
                              height: Get.height * 0.062,
                              width: Get.width * 0.365,
                              decoration: BoxDecoration(
                                  color: ColorConstant.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.center,
                              child: Text(
                                  controller.toDate == null
                                      ? "To"
                                      : "${controller.toDate!.day}-${controller.toDate!.month}-${controller.toDate!.year}",
                                  style: TextStyleConstant.medium18(
                                      color: ColorConstant.white)))),
                    ],
                  )),
              const Spacer(),
              CustomButton(
                title: "Submit",
                onTap: () =>
                    controller.validateFields(formType: widget.formType),
              )
            ],
          ),
        ),
      ),
    );
  }
}
