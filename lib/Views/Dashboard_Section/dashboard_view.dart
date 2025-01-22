// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Controllers/dashboard_controller.dart';
import 'package:travelindia/Views/Dashboard_Section/AddLocationForm_View.dart';
import 'package:travelindia/Views/Dashboard_Section/find_places_view.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_shimmer.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    controller.initialFunctioun().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.cloudWhite,
        appBar: CustomAppBar(
          title: "Travel Recommendation",
          action: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined,
                    color: ColorConstant.grey)),
            const CircleAvatar(
                child:
                    Icon(Icons.person_rounded, color: ColorConstant.primary)),
            responsiveSizedBoxWidth(width: 20)
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // State Dropdown
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: "Select State",
                              fillColor: ColorConstant.transparent,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            value: controller.selectedState.value.isEmpty
                                ? null
                                : controller.selectedState.value,
                            items: controller.stateList
                                .toSet()
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedState.value = value ?? "";
                              controller.selectedCity.value = "";
                              controller.cityList.clear();
                              controller.getCityList(
                                  state: controller.selectedState.value);
                            },
                          ),
                        ),
                      ),
                    ),

                    // City Dropdown
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: "Select City",
                              fillColor: ColorConstant.transparent,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            value: controller.selectedCity.value.isEmpty
                                ? null
                                : controller.selectedCity.value,
                            items: controller.cityList
                                .toSet()
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (controller.selectedState.value.isNotEmpty) {
                                controller.selectedCity.value = value ?? "";
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please select a state first'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    // Find Places Button
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.selectedState.value.isNotEmpty &&
                                  controller.selectedCity.value.isNotEmpty) {
                                Get.to(() => FindPlacesView(
                                    state: controller.selectedState.value,
                                    city: controller.selectedCity.value));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please select both state and city')));
                              }
                            },
                            child: const Text('Find Places'))),
                  ],
                ))),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddLocationScreen()));
            },
            child: const Icon(Icons.pin_drop_rounded,
                color: ColorConstant.primary)));
  }
}
