import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? needChildWidget;
  final Widget? childWidget;
  final List<Widget>? action;
  final Widget? leading;
  final bool? centerTitle;
  final bool? needBackIcon;
  final Color? backGroundColor;
  final Color? backIconColor;
  final Color? textColor;
  final Widget? extraWidget;

  const CustomAppBar({
    super.key,
    this.title,
    this.centerTitle,
    this.needBackIcon,
    this.leading,
    this.action,
    this.backGroundColor,
    this.textColor,
    this.needChildWidget,
    this.childWidget,
    this.extraWidget,
    this.backIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor ?? ColorConstant.cloudWhite,
      title: (needChildWidget == true)
          ? childWidget
          : Text(
              "$title",
              style: TextStyle(color: textColor ?? ColorConstant.black),
            ),
      leading: (needBackIcon == true)
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_rounded,
                  color: backIconColor ?? ColorConstant.black))
          : leading,
      actions: action,
      centerTitle: centerTitle ?? false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
