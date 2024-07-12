import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_button.dart';

class PackageDetailView extends StatelessWidget {
  const PackageDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Gujarat Tour", needBackIcon: true),
      body: ListView(
        children: [
          Container(
            height: Get.height * 0.300,
            width: Get.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Somanath_mandir_%28cropped%29.jpg/1200px-Somanath_mandir_%28cropped%29.jpg"),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidthPadding,
                top: Get.height * 0.010,
                right: screenWidthPadding),
            child: Text("Gujarat Tour", style: TextStyleConstant.medium26()),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthPadding),
            child: Text("Rs. 17500", style: TextStyleConstant.semiBold24()),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidthPadding, top: Get.height * 0.020),
            child:
                Text("Duration: 3 Days", style: TextStyleConstant.medium16()),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidthPadding),
            child:
                Text("Person: 2 Adults", style: TextStyleConstant.medium16()),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: screenWidthPadding, top: Get.height * 0.020),
              child: Text("Check out for more persons",
                  style: TextStyleConstant.medium24())),
          Padding(
              padding: EdgeInsets.only(left: screenWidthPadding),
              child: Text("2 Adults: Rs. 17500",
                  style: TextStyleConstant.medium16())),
          Padding(
              padding: EdgeInsets.only(left: screenWidthPadding),
              child: Text("3 Adults: Rs. 20800",
                  style: TextStyleConstant.medium16())),
          Padding(
              padding: EdgeInsets.only(left: screenWidthPadding),
              child: Text("4 Adults: Rs. 23800",
                  style: TextStyleConstant.medium16())),
          Padding(
              padding: EdgeInsets.only(left: screenWidthPadding),
              child: Text("5 Adults: Rs. 29500",
                  style: TextStyleConstant.medium16())),
          Padding(
              padding: EdgeInsets.only(left: screenWidthPadding),
              child: Text("6 Adults: Rs. 32000",
                  style: TextStyleConstant.medium16())),
          Padding(
              padding: EdgeInsets.only(
                  left: screenWidthPadding, top: Get.height * 0.020),
              child: Text("Check out for more persons",
                  style: TextStyleConstant.medium24())),
          Padding(
              padding: EdgeInsets.only(left: screenWidthPadding),
              child: Text(
                  "Private AC Cars, Breakfast, 3 Star Hotel, All Taxes.",
                  style: TextStyleConstant.medium16())),
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              left: screenWidthPadding,
              right: screenWidthPadding,
              bottom: screenHeightPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(width: Get.width * 0.450, title: "Total Rs. 17500"),
              CustomButton(width: Get.width * 0.400, title: "Pay Now"),
            ],
          )),
    );
  }
}
