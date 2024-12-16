import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Views/Dashboard_Section/dashboard_view.dart';

class BottomBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxList<Widget> screenList = <Widget>[
    const DashboardView(), // Home
    const SizedBox(), // Explore
    const SizedBox(), // Notifications
    const SizedBox(), // Messages
    const SizedBox(), // Profile
  ].obs;
}
