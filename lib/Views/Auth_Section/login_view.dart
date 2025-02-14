import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/login_controller.dart';
import 'package:travelindia/Services/form_validation_services.dart';
import 'package:travelindia/Views/Auth_Section/create_account_view.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:travelindia/Widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return Form(
                key: controller.formKey,
                child: Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login", style: TextStyleConstant.bold36()),
                      Text("Welcome Back",
                          style: TextStyleConstant.semiBold16()),
                      Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 40),
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
                              Text("Haven't Account? ",
                                  style: TextStyleConstant.semiBold18()),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(() => const CreateAccountView());
                                  },
                                  child: Text("Create Account",
                                      style: TextStyleConstant.semiBold18(
                                          color: ColorConstant.primary))),
                            ],
                          )),
                      CustomButton(
                          title: "Login", onTap: () => controller.postLogin()),
                      responsiveSizedBoxHeight(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  height: 2, color: ColorConstant.greyAccent)),
                          Padding(
                              padding: screenHorizontalPadding,
                              child: Text("OR",
                                  style: TextStyleConstant.semiBold18(
                                      color: ColorConstant.grey))),
                          Expanded(
                              child: Container(
                                  height: 2, color: ColorConstant.greyAccent)),
                        ],
                      ),
                      responsiveSizedBoxHeight(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Continue as ",
                              style: TextStyleConstant.semiBold18()),
                          GestureDetector(
                              onTap: () => controller.guestLogin(),
                              child: Text("Guest",
                                  style: TextStyleConstant.semiBold18(
                                      color: ColorConstant.primary))),
                        ],
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
