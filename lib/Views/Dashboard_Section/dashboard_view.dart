// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/image_path_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/dashboard_controller.dart';
import 'package:travelindia/Models/get_state_list_model.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Auth_Section/login_view.dart';
import 'package:travelindia/Views/Dashboard_Section/location_detail_view.dart';
import 'package:travelindia/Views/package_detail_view.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_textfield.dart';
import 'package:travelindia/Widgets/custom_toast.dart';

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
        needChildWidget: true,
        childWidget: Row(
          children: [
            const Icon(Icons.map_rounded, color: ColorConstant.black),
            responsiveSizedBoxWidth(width: 20),
            GestureDetector(
                onTap: () => selectStateDialog(),
                child: Obx(
                  () {
                    return (controller.selectedState.value.isNotEmpty)
                        ? Text(controller.selectedState.value)
                        : const Text("Select State");
                  },
                )),
          ],
        ),
        action: [
          IconButton(
              onPressed: () {
                StorageServices.clearData();
                Get.offAll(() => const LoginView());
              },
              icon: const Icon(Icons.notifications_outlined,
                  color: ColorConstant.grey)),
          const CircleAvatar(
              child: Icon(Icons.person_rounded, color: ColorConstant.primary)),
          responsiveSizedBoxWidth(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.showFoundPlaces.value == false &&
                    controller.getFindedPlaceListModel.value
                            .categoryLocationList ==
                        null)
                  SizedBox(
                      height: responsiveHeight(height: 260),
                      width: Get.width,
                      child: Image.asset(ImagePathConstant.getStart,
                          fit: BoxFit.fill, gaplessPlayback: true)),

                // Show Found Places List when data is available
                Obx(() {
                  if (controller.showFoundPlaces.value &&
                      controller.getFindedPlaceListModel.value
                              .categoryLocationList !=
                          null &&
                      controller.getFindedPlaceListModel.value
                          .categoryLocationList!.isNotEmpty) {
                    return Padding(
                        padding: screenHorizontalPadding,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.getFindedPlaceListModel.value
                              .categoryLocationList!.length,
                          itemBuilder: (context, index) {
                            final element = controller.getFindedPlaceListModel
                                .value.categoryLocationList![index];

                            return Padding(
                                padding: EdgeInsets.only(
                                    top: responsiveHeight(height: 16)),
                                child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => LocationDetailView(
                                          location: "${element.location}"));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                            alignment: Alignment.bottomLeft,
                                            height:
                                                responsiveHeight(height: 200),
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${element.file}"),
                                                    fit: BoxFit.fill),
                                                boxShadow: const [
                                                  BoxShadow()
                                                ])),
                                        Container(
                                            height:
                                                responsiveHeight(height: 200),
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                    Colors.transparent,
                                                  ],
                                                ))),
                                        Positioned(
                                            bottom: 10,
                                            left: contentWidthPadding,
                                            child: Text("${element.location}",
                                                style:
                                                    TextStyleConstant.medium18(
                                                        color: ColorConstant
                                                            .white))),
                                      ],
                                    )));
                          },
                        ));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 60),
                              left: screenWidthPadding,
                              bottom: responsiveHeight(height: 20)),
                          child: Text("Best Categories",
                              style: TextStyleConstant.semiBold20()),
                        ),

                        // Categories List
                        Obx(() => controller
                                    .getCategoryListModel.value.categoryList !=
                                null
                            ? SizedBox(
                                height: responsiveHeight(height: 190),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.getCategoryListModel
                                      .value.categoryList?.length,
                                  itemBuilder: (context, index) {
                                    final element = controller
                                        .getCategoryListModel
                                        .value
                                        .categoryList?[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: responsiveWidth(width: 30)),
                                      child: SizedBox(
                                        width: responsiveWidth(width: 240),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            "${element?.image}"),
                                                        fit: BoxFit.fill))),
                                            responsiveSizedBoxHeight(
                                                height: 10),
                                            Text("${element?.categoryName}",
                                                style: TextStyleConstant
                                                    .semiBold18(),
                                                maxLines: 2,
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ))
                            : const SizedBox()),

                        Padding(
                          padding: EdgeInsets.only(
                            top: responsiveHeight(height: 40),
                            left: screenWidthPadding,
                            bottom: responsiveHeight(height: 20),
                          ),
                          child: Text("Value for Money Packages",
                              style: TextStyleConstant.semiBold20()),
                        ),

                        Obx(() => controller
                                    .getPackageListModel.value.packagelist !=
                                null
                            ? SizedBox(
                                height: responsiveHeight(height: 190),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.getPackageListModel
                                      .value.packagelist?.length,
                                  itemBuilder: (context, index) {
                                    final element = controller
                                        .getPackageListModel
                                        .value
                                        .packagelist?[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: responsiveWidth(width: 30)),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => PackageDetailView(
                                              packageId: element?.id ?? ""));
                                        },
                                        child: SizedBox(
                                          width: responsiveWidth(width: 240),
                                          child: Column(
                                            children: [
                                              Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${element?.file}"),
                                                          fit: BoxFit.fill))),
                                              responsiveSizedBoxHeight(
                                                  height: 10),
                                              Text("${element?.packageName}",
                                                  style: TextStyleConstant
                                                      .semiBold18(),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ))
                            : const SizedBox()),
                      ],
                    );
                  }
                })
              ],
            ),

            // City Dropdown
            if (controller.showFoundPlaces.value == false &&
                controller.getFindedPlaceListModel.value.categoryLocationList ==
                    null)
              Padding(
                padding: EdgeInsets.only(
                    top: responsiveHeight(height: 230),
                    left: screenWidthPadding,
                    right: screenWidthPadding),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16)),
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Select City",
                        fillColor: ColorConstant.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          controller
                              .getFindedPlaceList()
                              .whenComplete(() => setState(() {}));
                        } else {
                          customToast(message: "Selec State First");
                          selectStateDialog();
                        }
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  selectStateDialog() {
    // Create a temporary observable list for filtering states
    RxList<Itemlist> filteredStateList = RxList<Itemlist>();

    // Initialize the filtered list with all states
    filteredStateList.assignAll(controller.getStateListModel.itemlist ?? []);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select State"),
          content: SizedBox(
            height: responsiveHeight(height: 600),
            width: double.maxFinite,
            child: Column(
              children: [
                // Search Field
                CustomTextField(
                  controller: controller.searchStateController,
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: "Search State",
                  onChanged: (value) {
                    // Filter states based on search input
                    filteredStateList.assignAll(
                      (controller.getStateListModel.itemlist ?? []).where(
                        (state) => state.name!
                            .toLowerCase()
                            .contains(value.toLowerCase()),
                      ),
                    );
                  },
                ),

                // List of States
                Expanded(
                  child: Obx(() => ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredStateList.length,
                        itemBuilder: (context, index) {
                          final element = filteredStateList[index];
                          return Padding(
                            padding: EdgeInsets.only(top: contentHeightPadding),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectedState.value =
                                    element.name ?? "";
                                controller.selectedCity.value = "";
                                controller.cityList.clear();
                                controller.getCityList(
                                    state: controller.selectedState.value);
                                Get.back(); // Close the Dialog
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: screenWidthPadding,
                                    top: screenHeightPadding,
                                    bottom: screenHeightPadding),
                                decoration: BoxDecoration(
                                    color: ColorConstant.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    if (element.name ==
                                        controller.selectedState.value)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: screenWidthPadding),
                                        child: const Icon(Icons.check_rounded,
                                            color: ColorConstant.primary),
                                      ),
                                    Expanded(
                                      child: Text(
                                        element.name ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
