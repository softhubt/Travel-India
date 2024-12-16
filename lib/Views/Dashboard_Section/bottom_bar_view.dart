import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/bottom_bar_controller.dart';

class BottomBarView extends StatefulWidget {
  final int? currentIndex;
  const BottomBarView({super.key, this.currentIndex});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  final BottomBarController controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.screenList[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: Icon((controller.selectedIndex.value == 0)
                      ? Icons.home_rounded
                      : Icons.home_outlined),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon((controller.selectedIndex.value == 1)
                      ? Icons.travel_explore_rounded
                      : Icons.travel_explore_outlined),
                  label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon((controller.selectedIndex.value == 2)
                      ? Icons.barcode_reader
                      : Icons.barcode_reader),
                  label: 'Trip Plan'),
              BottomNavigationBarItem(
                  icon: Icon((controller.selectedIndex.value == 3)
                      ? Icons.recommend_rounded
                      : Icons.recommend_outlined),
                  label: 'Recommend'),
              BottomNavigationBarItem(
                  icon: Icon((controller.selectedIndex.value == 4)
                      ? Icons.person_rounded
                      : Icons.person_outline),
                  label: 'Profile'),
            ],
          ),
        ));
  }
}
