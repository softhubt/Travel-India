import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final Alignment? alignment;
  final EdgeInsetsGeometry? padding;
  final bool? needChildWidget;
  final BoxBorder? border;
  final Widget? childWidget;

  const CustomButton(
      {super.key,
      this.title,
      this.onTap,
      this.height,
      this.width,
      this.backgroundColor,
      this.textColor,
      this.alignment,
      this.padding,
      this.needChildWidget,
      this.childWidget,
      this.border});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        alignment: alignment ?? Alignment.center,
        height: height ?? Get.height * 0.051,
        width: width ?? Get.width,
        decoration: BoxDecoration(
            color: backgroundColor ?? ColorConstant.primary,
            border: border,
            borderRadius: BorderRadius.circular(30)),
        child: (needChildWidget == true)
            ? childWidget
            : Text("$title",
                style: TextStyleConstant.medium18(
                    color: textColor ?? ColorConstant.white)),
      ),
    );
  }
}
