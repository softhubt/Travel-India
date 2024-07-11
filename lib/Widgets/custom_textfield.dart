import 'package:flutter/material.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function()? onTap;
  final int? maxLength;
  final bool? enable;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  String? Function(String?)? validator;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onTap,
      this.maxLength,
      this.enable,
      this.fillColor,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputType,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      maxLength: maxLength,
      cursorColor: ColorConstant.blue,
      keyboardType: textInputType ?? TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleConstant.regular14(color: ColorConstant.grey),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: ColorConstant.grey)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: ColorConstant.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(width: 1.5, color: ColorConstant.blue)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1.5)),
        enabled: enable ?? true,
        filled: true,
        fillColor: fillColor ?? ColorConstant.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
