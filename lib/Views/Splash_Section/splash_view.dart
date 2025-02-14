import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    controller.changeView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return SizedBox(
              height: Get.height,
              width: Get.width,
              // child: Image.asset(ImagePathConstant., fit: BoxFit.fill)
            );
          }),
    );
  }
}
