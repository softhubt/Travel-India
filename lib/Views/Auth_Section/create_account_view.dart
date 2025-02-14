import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/create_account_controller.dart';
import 'package:travelindia/Services/form_validation_services.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:travelindia/Widgets/custom_textfield.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.white,
      body: GetBuilder<CreateAccountController>(
          init: CreateAccountController(),
          builder: (controller) {
            return Form(
                key: controller.formKey,
                child: Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create Account", style: TextStyleConstant.bold36()),
                      Text("Let's explore the World",
                          style: TextStyleConstant.semiBold16()),
                      Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 40),
                              bottom: responsiveHeight(height: 8)),
                          child: Text("Full Name",
                              style: TextStyleConstant.semiBold16())),
                      CustomTextField(
                          controller: controller.nameController,
                          hintText: "Full Name",
                          prefixIcon: const Icon(Icons.person_rounded),
                          validator: FormValidationServices.validateField(
                              fieldName: "Full Name"),
                          textInputType: TextInputType.name),
                      Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 16),
                              bottom: responsiveHeight(height: 8)),
                          child: Text("Email",
                              style: TextStyleConstant.semiBold16())),
                      CustomTextField(
                          controller: controller.emailController,
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email_rounded),
                          validator: FormValidationServices.validateEmail(),
                          textInputType: TextInputType.emailAddress),
                      Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 16),
                              bottom: responsiveHeight(height: 8)),
                          child: Text("Phone",
                              style: TextStyleConstant.semiBold16())),
                      CustomTextField(
                          controller: controller.phoneController,
                          hintText: "Phone",
                          prefixIcon: const Icon(Icons.phone_rounded),
                          validator: FormValidationServices.validatePhone(),
                          textInputType: TextInputType.phone),
                      Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 16),
                              bottom: responsiveHeight(height: 8)),
                          child: Text("Password",
                              style: TextStyleConstant.semiBold16())),
                      CustomTextField(
                          controller: controller.passwordController,
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_rounded),
                          validator: FormValidationServices.validateField(
                              fieldName: "Password"),
                          textInputType: TextInputType.visiblePassword),
                      Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 40),
                              bottom: responsiveHeight(height: 60)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an Account? ",
                                  style: TextStyleConstant.semiBold18()),
                              GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Text("Login",
                                      style: TextStyleConstant.semiBold18(
                                          color: ColorConstant.primary))),
                            ],
                          )),
                      CustomButton(
                          title: "Create Account",
                          onTap: () => controller.getOtp()),
                    ],
                  ),
                ));
          }),
    );
  }
}
