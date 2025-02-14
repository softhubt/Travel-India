import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Views/Splash_Section/onboarding_view.dart';
import 'package:travelindia/Widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/Images/get_started_video.mp4")
          ..initialize().then((_) {
            log("Playing the video");
            setState(() {});
            _controller.play();
            _controller.setLooping(true);
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : const SizedBox()),
          Positioned(
            bottom: responsiveHeight(height: 100),
            left: screenWidthPadding,
            right: screenWidthPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome to Travel India",
                    style:
                        TextStyleConstant.bold30(color: ColorConstant.white)),
                const SizedBox(height: 10),
                Text("Explore the beauty of India like never before.",
                    style:
                        TextStyleConstant.medium18(color: ColorConstant.white)),
                const SizedBox(height: 20),
                CustomButton(
                  title: "Get Started",
                  onTap: () {
                    Get.to(() => const OnboardingView());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
