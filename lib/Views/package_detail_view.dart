import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Controllers/package_detail_controller.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageDetailView extends StatefulWidget {
  final String packageId;
  const PackageDetailView({super.key, required this.packageId});

  @override
  State<PackageDetailView> createState() => _PackageDetailViewState();
}

class _PackageDetailViewState extends State<PackageDetailView> {
  final PackageDetailController controller = Get.put(PackageDetailController());

  @override
  void initState() {
    super.initState();
    controller
        .initialFuncion(id: widget.packageId)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // Grab the data from our controller
    final packagelist = controller.getPackageDetailModel.packagelist;

    // If we have no data, show a loader (or an empty view)
    if (packagelist == null || packagelist.isEmpty) {
      return const Scaffold(
        appBar: CustomAppBar(title: "Loading...", needBackIcon: true),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // For simplicity, let's assume we only care about the *first* package
    final package = packagelist.first;

    return Scaffold(
      appBar: AppBar(
          title: Text(package.packageName ?? "Package Details",
              style: const TextStyle(color: ColorConstant.white))),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP BANNER IMAGE ---
          if (package.file != null && package.file!.isNotEmpty)
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.grey[200],
              child: Image.network(
                package.file!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // If the image fails to load
                  return const Center(child: Text("Image not available"));
                },
              ),
            ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              menuButton("About Site", Icons.info_rounded),
              menuButton("Things TODO", Icons.place_rounded),
              menuButton("Food&Drinks", Icons.food_bank_rounded)
            ],
          ),
          responsiveSizedBoxHeight(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              menuButton("Hotel&Homes", Icons.home_rounded),
              menuButton("Transport", Icons.train_rounded),
              menuButton("Hire Guide", Icons.phone_rounded)
            ],
          ),

          responsiveSizedBoxHeight(height: 20),

          // --- PACKAGE NAME AND BASIC INFO ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              package.packageName ?? "No Name",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (package.numberOfDays != null && package.numberOfDays!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                "${package.numberOfDays} days",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

          // --- DESCRIPTION ---
          if (package.description != null && package.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                package.description!,
                style: const TextStyle(fontSize: 15),
              ),
            ),

          // --- A ROW OF QUICK DETAILS (PAYMENT, AMOUNT, ETC.) ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Payment
                _QuickDetailCard(
                  icon: Icons.payment,
                  label: "Payment",
                  value: package.payment ?? "-",
                ),
                // Booking amount
                _QuickDetailCard(
                  icon: Icons.attach_money,
                  label: "B. Amount",
                  value: package.bAmount ?? "-",
                ),
                // Price2 as an example
                _QuickDetailCard(
                  icon: Icons.monetization_on_outlined,
                  label: "Price2",
                  value: package.price2 ?? "-",
                ),
                // Add more if needed...
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- DAYS ITINERARY ---
          // We'll show the day1...day6 data in a simple expansion or just list them
          _DayDetailTile(title: "Day 1", detail: package.day1),
          _DayDetailTile(title: "Day 2", detail: package.day2),
          _DayDetailTile(title: "Day 3", detail: package.day3),
          _DayDetailTile(title: "Day 4", detail: package.day4),
          _DayDetailTile(title: "Day 5", detail: package.day5),
          _DayDetailTile(title: "Day 6", detail: package.day6),

          // --- EXTRA SPACE / EXTRA CONTENT ---
          const SizedBox(height: 16),

          // Example of a custom button at the bottom
          const Padding(
              padding: EdgeInsets.all(16),
              child: CustomButton(title: "Book Now")),
        ],
      )),
    );
  }

  // UI Widget: Bottom Menu Button
  Widget menuButton(String label, IconData icon) {
    return SizedBox(
      width: responsiveWidth(width: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: ColorConstant.black),
          const SizedBox(height: 5),
          Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // A helper function for launching URLs if needed
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// A small widget to display an icon, label, and some value
class _QuickDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _QuickDetailCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, size: 24, color: Colors.blueAccent),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A small widget to display "Day X" plus the details
class _DayDetailTile extends StatelessWidget {
  final String title;
  final String? detail;

  const _DayDetailTile({
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    if (detail == null || detail!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(detail!),
          ),
        ],
      ),
    );
  }
}
