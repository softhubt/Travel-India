import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';

/*
w100 - thin
w200 - extraLight
w300 - light
w400 - regular
w500 - medium
w600 - semiBold
w700 - bold
w800 - extraBold
w900 - black

973 448
 */

class TextStyleConstant {
  static TextStyle _getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return TextStyle(
        fontSize: Get.width * fontSize,
        color: color ?? ColorConstant.black,
        fontWeight: fontWeight);
  }

  static TextStyle thin({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w100, color: color);
  static TextStyle extraLight({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w200, color: color);
  static TextStyle light({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w300, color: color);
  static TextStyle regular({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w400, color: color);
  static TextStyle medium({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w500, color: color);
  static TextStyle semiBold({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w600, color: color);
  static TextStyle bold({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w700, color: color);
  static TextStyle extraBold({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w800, color: color);
  static TextStyle black({required double fontSize, Color? color}) =>
      _getTextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w900, color: color);

  static TextStyle thin8({Color? color}) => thin(fontSize: 0.018, color: color);
  static TextStyle thin10({Color? color}) =>
      thin(fontSize: 0.022, color: color);
  static TextStyle thin12({Color? color}) =>
      thin(fontSize: 0.026, color: color);
  static TextStyle thin14({Color? color}) =>
      thin(fontSize: 0.031, color: color);
  static TextStyle thin16({Color? color}) =>
      thin(fontSize: 0.035, color: color);
  static TextStyle thin18({Color? color}) =>
      thin(fontSize: 0.040, color: color);
  static TextStyle thin20({Color? color}) =>
      thin(fontSize: 0.044, color: color);
  static TextStyle thin22({Color? color}) =>
      thin(fontSize: 0.049, color: color);
  static TextStyle thin24({Color? color}) =>
      thin(fontSize: 0.053, color: color);
  static TextStyle thin26({Color? color}) =>
      thin(fontSize: 0.058, color: color);
  static TextStyle thin28({Color? color}) =>
      thin(fontSize: 0.062, color: color);
  static TextStyle thin30({Color? color}) =>
      thin(fontSize: 0.066, color: color);
  static TextStyle thin32({Color? color}) =>
      thin(fontSize: 0.071, color: color);
  static TextStyle thin34({Color? color}) =>
      thin(fontSize: 0.075, color: color);
  static TextStyle thin36({Color? color}) =>
      thin(fontSize: 0.080, color: color);
  static TextStyle thin38({Color? color}) =>
      thin(fontSize: 0.084, color: color);
  static TextStyle thin40({Color? color}) =>
      thin(fontSize: 0.089, color: color);
  static TextStyle thin42({Color? color}) =>
      thin(fontSize: 0.093, color: color);

  static TextStyle extraLight8({Color? color}) =>
      extraLight(fontSize: 0.018, color: color);
  static TextStyle extraLight10({Color? color}) =>
      extraLight(fontSize: 0.022, color: color);
  static TextStyle extraLight12({Color? color}) =>
      extraLight(fontSize: 0.026, color: color);
  static TextStyle extraLight14({Color? color}) =>
      extraLight(fontSize: 0.031, color: color);
  static TextStyle extraLight16({Color? color}) =>
      extraLight(fontSize: 0.035, color: color);
  static TextStyle extraLight18({Color? color}) =>
      extraLight(fontSize: 0.040, color: color);
  static TextStyle extraLight20({Color? color}) =>
      extraLight(fontSize: 0.044, color: color);
  static TextStyle extraLight22({Color? color}) =>
      extraLight(fontSize: 0.049, color: color);
  static TextStyle extraLight24({Color? color}) =>
      extraLight(fontSize: 0.053, color: color);
  static TextStyle extraLight26({Color? color}) =>
      extraLight(fontSize: 0.058, color: color);
  static TextStyle extraLight28({Color? color}) =>
      extraLight(fontSize: 0.062, color: color);
  static TextStyle extraLight30({Color? color}) =>
      extraLight(fontSize: 0.066, color: color);
  static TextStyle extraLight32({Color? color}) =>
      extraLight(fontSize: 0.071, color: color);
  static TextStyle extraLight34({Color? color}) =>
      extraLight(fontSize: 0.075, color: color);
  static TextStyle extraLight36({Color? color}) =>
      extraLight(fontSize: 0.080, color: color);
  static TextStyle extraLight38({Color? color}) =>
      extraLight(fontSize: 0.084, color: color);
  static TextStyle extraLight40({Color? color}) =>
      extraLight(fontSize: 0.089, color: color);
  static TextStyle extraLight42({Color? color}) =>
      extraLight(fontSize: 0.093, color: color);

  static TextStyle light8({Color? color}) =>
      light(fontSize: 0.018, color: color);
  static TextStyle light10({Color? color}) =>
      light(fontSize: 0.022, color: color);
  static TextStyle light12({Color? color}) =>
      light(fontSize: 0.026, color: color);
  static TextStyle light14({Color? color}) =>
      light(fontSize: 0.031, color: color);
  static TextStyle light16({Color? color}) =>
      light(fontSize: 0.035, color: color);
  static TextStyle light18({Color? color}) =>
      light(fontSize: 0.040, color: color);
  static TextStyle light20({Color? color}) =>
      light(fontSize: 0.044, color: color);
  static TextStyle light22({Color? color}) =>
      light(fontSize: 0.049, color: color);
  static TextStyle light24({Color? color}) =>
      light(fontSize: 0.053, color: color);
  static TextStyle light26({Color? color}) =>
      light(fontSize: 0.058, color: color);
  static TextStyle light28({Color? color}) =>
      light(fontSize: 0.062, color: color);
  static TextStyle light30({Color? color}) =>
      light(fontSize: 0.066, color: color);
  static TextStyle light32({Color? color}) =>
      light(fontSize: 0.071, color: color);
  static TextStyle light34({Color? color}) =>
      light(fontSize: 0.075, color: color);
  static TextStyle light36({Color? color}) =>
      light(fontSize: 0.080, color: color);
  static TextStyle light38({Color? color}) =>
      light(fontSize: 0.084, color: color);
  static TextStyle light40({Color? color}) =>
      light(fontSize: 0.089, color: color);
  static TextStyle light42({Color? color}) =>
      light(fontSize: 0.093, color: color);

  static TextStyle regular8({Color? color}) =>
      regular(fontSize: 0.018, color: color);
  static TextStyle regular10({Color? color}) =>
      regular(fontSize: 0.022, color: color);
  static TextStyle regular12({Color? color}) =>
      regular(fontSize: 0.026, color: color);
  static TextStyle regular14({Color? color}) =>
      regular(fontSize: 0.031, color: color);
  static TextStyle regular16({Color? color}) =>
      regular(fontSize: 0.035, color: color);
  static TextStyle regular18({Color? color}) =>
      regular(fontSize: 0.040, color: color);
  static TextStyle regular20({Color? color}) =>
      regular(fontSize: 0.044, color: color);
  static TextStyle regular22({Color? color}) =>
      regular(fontSize: 0.049, color: color);
  static TextStyle regular24({Color? color}) =>
      regular(fontSize: 0.053, color: color);
  static TextStyle regular26({Color? color}) =>
      regular(fontSize: 0.058, color: color);
  static TextStyle regular28({Color? color}) =>
      regular(fontSize: 0.062, color: color);
  static TextStyle regular30({Color? color}) =>
      regular(fontSize: 0.066, color: color);
  static TextStyle regular32({Color? color}) =>
      regular(fontSize: 0.071, color: color);
  static TextStyle regular34({Color? color}) =>
      regular(fontSize: 0.075, color: color);
  static TextStyle regular36({Color? color}) =>
      regular(fontSize: 0.080, color: color);
  static TextStyle regular38({Color? color}) =>
      regular(fontSize: 0.084, color: color);
  static TextStyle regular40({Color? color}) =>
      regular(fontSize: 0.089, color: color);
  static TextStyle regular42({Color? color}) =>
      regular(fontSize: 0.093, color: color);

  static TextStyle medium8({Color? color}) =>
      medium(fontSize: 0.018, color: color);
  static TextStyle medium10({Color? color}) =>
      medium(fontSize: 0.022, color: color);
  static TextStyle medium12({Color? color}) =>
      medium(fontSize: 0.026, color: color);
  static TextStyle medium14({Color? color}) =>
      medium(fontSize: 0.031, color: color);
  static TextStyle medium16({Color? color}) =>
      medium(fontSize: 0.035, color: color);
  static TextStyle medium18({Color? color}) =>
      medium(fontSize: 0.040, color: color);
  static TextStyle medium20({Color? color}) =>
      medium(fontSize: 0.044, color: color);
  static TextStyle medium22({Color? color}) =>
      medium(fontSize: 0.049, color: color);
  static TextStyle medium24({Color? color}) =>
      medium(fontSize: 0.053, color: color);
  static TextStyle medium26({Color? color}) =>
      medium(fontSize: 0.058, color: color);
  static TextStyle medium28({Color? color}) =>
      medium(fontSize: 0.062, color: color);
  static TextStyle medium30({Color? color}) =>
      medium(fontSize: 0.066, color: color);
  static TextStyle medium32({Color? color}) =>
      medium(fontSize: 0.071, color: color);
  static TextStyle medium34({Color? color}) =>
      medium(fontSize: 0.075, color: color);
  static TextStyle medium36({Color? color}) =>
      medium(fontSize: 0.080, color: color);
  static TextStyle medium38({Color? color}) =>
      medium(fontSize: 0.084, color: color);
  static TextStyle medium40({Color? color}) =>
      medium(fontSize: 0.089, color: color);
  static TextStyle medium42({Color? color}) =>
      medium(fontSize: 0.093, color: color);

  static TextStyle semiBold8({Color? color}) =>
      semiBold(fontSize: 0.018, color: color);
  static TextStyle semiBold10({Color? color}) =>
      semiBold(fontSize: 0.022, color: color);
  static TextStyle semiBold12({Color? color}) =>
      semiBold(fontSize: 0.026, color: color);
  static TextStyle semiBold14({Color? color}) =>
      semiBold(fontSize: 0.031, color: color);
  static TextStyle semiBold16({Color? color}) =>
      semiBold(fontSize: 0.035, color: color);
  static TextStyle semiBold18({Color? color}) =>
      semiBold(fontSize: 0.040, color: color);
  static TextStyle semiBold20({Color? color}) =>
      semiBold(fontSize: 0.044, color: color);
  static TextStyle semiBold22({Color? color}) =>
      semiBold(fontSize: 0.049, color: color);
  static TextStyle semiBold24({Color? color}) =>
      semiBold(fontSize: 0.053, color: color);
  static TextStyle semiBold26({Color? color}) =>
      semiBold(fontSize: 0.058, color: color);
  static TextStyle semiBold28({Color? color}) =>
      semiBold(fontSize: 0.062, color: color);
  static TextStyle semiBold30({Color? color}) =>
      semiBold(fontSize: 0.066, color: color);
  static TextStyle semiBold32({Color? color}) =>
      semiBold(fontSize: 0.071, color: color);
  static TextStyle semiBold34({Color? color}) =>
      semiBold(fontSize: 0.075, color: color);
  static TextStyle semiBold36({Color? color}) =>
      semiBold(fontSize: 0.080, color: color);
  static TextStyle semiBold38({Color? color}) =>
      semiBold(fontSize: 0.084, color: color);
  static TextStyle semiBold40({Color? color}) =>
      semiBold(fontSize: 0.089, color: color);
  static TextStyle semiBold42({Color? color}) =>
      semiBold(fontSize: 0.093, color: color);

  static TextStyle bold8({Color? color}) => bold(fontSize: 0.018, color: color);
  static TextStyle bold10({Color? color}) =>
      bold(fontSize: 0.022, color: color);
  static TextStyle bold12({Color? color}) =>
      bold(fontSize: 0.026, color: color);
  static TextStyle bold14({Color? color}) =>
      bold(fontSize: 0.031, color: color);
  static TextStyle bold16({Color? color}) =>
      bold(fontSize: 0.035, color: color);
  static TextStyle bold18({Color? color}) =>
      bold(fontSize: 0.040, color: color);
  static TextStyle bold20({Color? color}) =>
      bold(fontSize: 0.044, color: color);
  static TextStyle bold22({Color? color}) =>
      bold(fontSize: 0.049, color: color);
  static TextStyle bold24({Color? color}) =>
      bold(fontSize: 0.053, color: color);
  static TextStyle bold26({Color? color}) =>
      bold(fontSize: 0.058, color: color);
  static TextStyle bold28({Color? color}) =>
      bold(fontSize: 0.062, color: color);
  static TextStyle bold30({Color? color}) =>
      bold(fontSize: 0.066, color: color);
  static TextStyle bold32({Color? color}) =>
      bold(fontSize: 0.071, color: color);
  static TextStyle bold34({Color? color}) =>
      bold(fontSize: 0.075, color: color);
  static TextStyle bold36({Color? color}) =>
      bold(fontSize: 0.080, color: color);
  static TextStyle bold38({Color? color}) =>
      bold(fontSize: 0.084, color: color);
  static TextStyle bold40({Color? color}) =>
      bold(fontSize: 0.089, color: color);
  static TextStyle bold42({Color? color}) =>
      bold(fontSize: 0.093, color: color);

  static TextStyle extraBold8({Color? color}) =>
      extraBold(fontSize: 0.018, color: color);
  static TextStyle extraBold10({Color? color}) =>
      extraBold(fontSize: 0.022, color: color);
  static TextStyle extraBold12({Color? color}) =>
      extraBold(fontSize: 0.026, color: color);
  static TextStyle extraBold14({Color? color}) =>
      extraBold(fontSize: 0.031, color: color);
  static TextStyle extraBold16({Color? color}) =>
      extraBold(fontSize: 0.035, color: color);
  static TextStyle extraBold18({Color? color}) =>
      extraBold(fontSize: 0.040, color: color);
  static TextStyle extraBold20({Color? color}) =>
      extraBold(fontSize: 0.044, color: color);
  static TextStyle extraBold22({Color? color}) =>
      extraBold(fontSize: 0.049, color: color);
  static TextStyle extraBold24({Color? color}) =>
      extraBold(fontSize: 0.053, color: color);
  static TextStyle extraBold26({Color? color}) =>
      extraBold(fontSize: 0.058, color: color);
  static TextStyle extraBold28({Color? color}) =>
      extraBold(fontSize: 0.062, color: color);
  static TextStyle extraBold30({Color? color}) =>
      extraBold(fontSize: 0.066, color: color);
  static TextStyle extraBold32({Color? color}) =>
      extraBold(fontSize: 0.071, color: color);
  static TextStyle extraBold34({Color? color}) =>
      extraBold(fontSize: 0.075, color: color);
  static TextStyle extraBold36({Color? color}) =>
      extraBold(fontSize: 0.080, color: color);
  static TextStyle extraBold38({Color? color}) =>
      extraBold(fontSize: 0.084, color: color);
  static TextStyle extraBold40({Color? color}) =>
      extraBold(fontSize: 0.089, color: color);
  static TextStyle extraBold42({Color? color}) =>
      extraBold(fontSize: 0.093, color: color);

  static TextStyle black8({Color? color}) =>
      black(fontSize: 0.018, color: color);
  static TextStyle black10({Color? color}) =>
      black(fontSize: 0.022, color: color);
  static TextStyle black12({Color? color}) =>
      black(fontSize: 0.026, color: color);
  static TextStyle black14({Color? color}) =>
      black(fontSize: 0.031, color: color);
  static TextStyle black16({Color? color}) =>
      black(fontSize: 0.035, color: color);
  static TextStyle black18({Color? color}) =>
      black(fontSize: 0.040, color: color);
  static TextStyle black20({Color? color}) =>
      black(fontSize: 0.044, color: color);
  static TextStyle black22({Color? color}) =>
      black(fontSize: 0.049, color: color);
  static TextStyle black24({Color? color}) =>
      black(fontSize: 0.053, color: color);
  static TextStyle black26({Color? color}) =>
      black(fontSize: 0.058, color: color);
  static TextStyle black28({Color? color}) =>
      black(fontSize: 0.062, color: color);
  static TextStyle black30({Color? color}) =>
      black(fontSize: 0.066, color: color);
  static TextStyle black32({Color? color}) =>
      black(fontSize: 0.071, color: color);
  static TextStyle black34({Color? color}) =>
      black(fontSize: 0.075, color: color);
  static TextStyle black36({Color? color}) =>
      black(fontSize: 0.080, color: color);
  static TextStyle black38({Color? color}) =>
      black(fontSize: 0.084, color: color);
  static TextStyle black40({Color? color}) =>
      black(fontSize: 0.089, color: color);
  static TextStyle black42({Color? color}) =>
      black(fontSize: 0.093, color: color);
}
