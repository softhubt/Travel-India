import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Controllers/dashboard_controller.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardController controller = Get.put(DashboardController());

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
    );
  }
}
