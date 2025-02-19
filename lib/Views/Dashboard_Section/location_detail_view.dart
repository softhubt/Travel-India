import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/location_detail_controller.dart';
import 'package:travelindia/Views/Dashboard_Section/user_form_view.dart';

class LocationDetailView extends StatefulWidget {
  final String location;
  const LocationDetailView({super.key, required this.location});

  @override
  State<LocationDetailView> createState() => _LocationDetailViewState();
}

class _LocationDetailViewState extends State<LocationDetailView> {
  LocationDetailController controller = Get.put(LocationDetailController());

  @override
  void initState() {
    super.initState();
    controller
        .initialFunctioun(location: widget.location)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.white,
        appBar: AppBar(
          title: Text(widget.location,
              style: const TextStyle(color: ColorConstant.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        body: Obx(
          () {
            final model = controller.getLocationDetailModel.value;

            log("Category Location List: ${model.itemlist}");

            if (model.itemlist == null || model.itemlist!.isEmpty) {
              return const Center(child: Text('No details available.'));
            }

            final locationDetails = model.itemlist!.first;

            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image and Title
                Stack(
                  children: [
                    Image.network(
                      locationDetails.file ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Breathtaking\nDestinations",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Book Now'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    menuButton(
                      "About Site",
                      Icons.info_rounded,
                      () {},
                    ),
                    menuButton(
                      "Things TODO",
                      Icons.place_rounded,
                      () {},
                    ),
                    menuButton(
                      "Food&Drinks",
                      Icons.food_bank_rounded,
                      () {
                        Get.to(
                            () => const UserFormView(formType: "Food&Drinks"));
                      },
                    )
                  ],
                ),
                responsiveSizedBoxHeight(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    menuButton(
                      "Hotel&Homes",
                      Icons.home_rounded,
                      () {
                        Get.to(() => const UserFormView(formType: "Hotel"));
                      },
                    ),
                    menuButton(
                      "Transport",
                      Icons.train_rounded,
                      () {
                        Get.to(() => const UserFormView(formType: "Transport"));
                      },
                    ),
                    menuButton(
                      "Hire Guide",
                      Icons.phone_rounded,
                      () {
                        Get.to(() => const UserFormView(formType: "Guide"));
                      },
                    )
                  ],
                ),

                responsiveSizedBoxHeight(height: 20),

                // Place Description
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 20),
                              bottom: contentHeightPadding),
                          child: Text('Visit Timing',
                              style: TextStyleConstant.bold18()),
                        ),
                        Text(locationDetails.vtime ?? '',
                            style: TextStyleConstant.medium16(
                                color: ColorConstant.primary)),
                        Padding(
                          padding: EdgeInsets.only(
                              top: responsiveHeight(height: 20),
                              bottom: contentHeightPadding),
                          child: Text('About Place',
                              style: TextStyleConstant.bold18()),
                        ),
                        Text(locationDetails.description ?? '',
                            style: TextStyleConstant.regular14(
                                color: ColorConstant.grey)),
                      ],
                    )),
              ],
            ));
          },
        ));
  }

  // UI Widget: Bottom Menu Button
  Widget menuButton(String label, IconData icon, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: responsiveWidth(width: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: ColorConstant.black),
            const SizedBox(height: 5),
            Text(label,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
