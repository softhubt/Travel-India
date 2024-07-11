import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/dashboard_controller.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_button.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    controller.initialFunctioun().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        needChildWidget: true,
        childWidget: ListTile(
          leading: const Icon(Icons.home_rounded),
          title: const Text("Home"),
          subtitle: Text(controller.currentAddress.value),
        ),
      ),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: screenHeightPadding,
                  bottom: Get.height * 0.020,
                  left: screenWidthPadding,
                  right: screenWidthPadding),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    borderRadius: BorderRadius.circular(16)),
                child: const ListTile(
                  leading: Icon(Icons.travel_explore_rounded),
                  title: Text("Find Your State"),
                ),
              )),
          Padding(
            padding: screenHorizontalPadding,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstant.white,
                  borderRadius: BorderRadius.circular(16)),
              child: const ListTile(
                leading: Icon(Icons.mode_of_travel_rounded),
                title: Text("Find Your City"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.040,
                bottom: Get.height * 0.040,
                left: screenWidthPadding,
                right: screenWidthPadding),
            child: const CustomButton(title: "Find Places"),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthPadding),
            child: Text("India's Top Packages",
                style: TextStyleConstant.medium24()),
          ),
          SizedBox(
            height: Get.height * 0.300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.030),
                  child: Container(
                    width: Get.width * 0.600,
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Get.height * 0.200,
                          decoration: BoxDecoration(
                              color: ColorConstant.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Somanath_mandir_%28cropped%29.jpg/1200px-Somanath_mandir_%28cropped%29.jpg"),
                                  fit: BoxFit.fill)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.010,
                              left: contentWidthPadding,
                              right: contentWidthPadding,
                              bottom: Get.height * 0.010),
                          child: Text("Gujarat tour for 3 days",
                              style: TextStyleConstant.medium20()),
                        ),
                        Padding(
                          padding: contentHorizontalPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rs. 17500",
                                  style: TextStyleConstant.semiBold18()),
                              Text("2 Adults",
                                  style: TextStyleConstant.semiBold18()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: Get.height * 0.300,
            width: Get.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/736x/ac/81/6e/ac816e3d850c796406278250ee4ce059.jpg"),
                    fit: BoxFit.fill)),
          ),
        ],
      ),
    );
  }
}
