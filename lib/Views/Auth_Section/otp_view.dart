import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/otp_controller.dart';
import 'package:travelindia/Services/form_validation_services.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:travelindia/Widgets/custom_textfield.dart';

class OtpView extends StatefulWidget {
  final String phone;

  const OtpView({super.key, required this.phone});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OtpController>(
          init: OtpController(),
          builder: (controller) {
            return Form(
                key: controller.formKey,
                child: Padding(
                  padding: screenHorizontalPadding,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.124, bottom: Get.height * 0.06),
                        child: Text("Verify Otp",
                            style: TextStyleConstant.medium36()),
                      ),
                      Text("Otp", style: TextStyleConstant.medium16()),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.010,
                            bottom: Get.height * 0.030),
                        child: CustomTextField(
                          controller: controller.otpController,
                          hintText: "Otp",
                          validator: FormValidationServices.validateField(
                              fieldName: "Otp"),
                          textInputType: TextInputType.number,
                        ),
                      ),
                      CustomButton(
                        title: "Verify Otp",
                        onTap: () => controller.verifyOtp(phone: widget.phone),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
