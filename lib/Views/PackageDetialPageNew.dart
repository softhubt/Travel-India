import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Models/PackageDetails_Model.dart';
import 'package:travelindia/Models/PackgeList_Model.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageDetailViewnew extends StatefulWidget {
  final PackageModel package;

  const PackageDetailViewnew({super.key, required this.package});

  @override
  _PackageDetailViewnewState createState() => _PackageDetailViewnewState();
}

class _PackageDetailViewnewState extends State<PackageDetailViewnew> {
  late Future<PackageDetailModel> _packageDetail;
  Map<String, String> package = {
    'payment': 'https://example.com/payment', // Replace with actual URL
  };
  @override
  void initState() {
    super.initState();
    _packageDetail = fetchPackageDetail(widget.package.id);
  }

  Future<PackageDetailModel> fetchPackageDetail(String id) async {
    final response = await http.post(
      Uri.parse(
          "https://meradaftar.com/travel_admin/travel_india_api/package_details.php"),
      body: {'id': id},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final packageDetails = jsonData['packagelist'][0];
      return PackageDetailModel.fromJson(packageDetails);
    } else {
      throw Exception('Failed to load package details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: widget.package.packageName, needBackIcon: true),
      body: FutureBuilder<PackageDetailModel>(
        future: _packageDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final package = snapshot.data!;

          return ListView(
            children: [
              Container(
                height: Get.height * 0.300,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(package.file),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidthPadding,
                  top: Get.height * 0.010,
                  right: screenWidthPadding,
                ),
                child: Text(package.packageName,
                    style: TextStyleConstant.medium26()),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidthPadding),
                child: Text('Rs. ${package.price2}',
                    style: TextStyleConstant.semiBold24()),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidthPadding,
                  top: Get.height * 0.020,
                ),
                child: Text('Duration: ${package.numberOfDays} Days',
                    style: TextStyleConstant.medium16()),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidthPadding),
                child: Text('Includes: ${package.description}',
                    style: TextStyleConstant.medium16()),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidthPadding,
                  top: Get.height * 0.020,
                ),
                child: Text('Check out for more persons',
                    style: TextStyleConstant.medium24()),
              ),
              if (package.price3.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: screenWidthPadding),
                  child: Text('3 Adults: Rs. ${package.price3}',
                      style: TextStyleConstant.medium16()),
                ),
              if (package.price4.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: screenWidthPadding),
                  child: Text('4 Adults: Rs. ${package.price4}',
                      style: TextStyleConstant.medium16()),
                ),
              if (package.price5.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: screenWidthPadding),
                  child: Text('5 Adults: Rs. ${package.price5}',
                      style: TextStyleConstant.medium16()),
                ),
              if (package.price6.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(left: screenWidthPadding),
                  child: Text('6 Adults: Rs. ${package.price6}',
                      style: TextStyleConstant.medium16()),
                ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidthPadding,
                  top: Get.height * 0.020,
                ),
                child: Text('Additional Details',
                    style: TextStyleConstant.medium24()),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidthPadding),
                child: Text(
                  package.description,
                  style: TextStyleConstant.medium16(),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: screenWidthPadding,
          right: screenWidthPadding,
          bottom: screenHeightPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                width: Get.width * 0.450,
                title: "Total Rs. ${widget.package.price2}"),
            CustomButton(
              width: Get.width * 0.400,
              title: "Pay Now",
              onTap: () {
                launchURL(package['payment']!); // Make sure the URL is valid
              },
            )
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
