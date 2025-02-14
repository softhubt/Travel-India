import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Constant/image_path_constant.dart';
import 'package:travelindia/Constant/layout_constant.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Views/Auth_Section/login_view.dart';
import 'package:travelindia/Widgets/custom_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": ImagePathConstant.onboardingOne,
      "title": "Discover New Places",
      "description": "Explore beautiful destinations and hidden gems."
    },
    {
      "image": ImagePathConstant.onboardingTwo,
      "title": "Plan Your Trips",
      "description": "Organize your travels with ease and comfort."
    },
    {
      "image": ImagePathConstant.onboardingThree,
      "title": "Enjoy Your Journey",
      "description": "Make unforgettable memories on every adventure."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(_pages[index]["image"]!, fit: BoxFit.fill),
                Positioned(
                    bottom: responsiveHeight(height: 140),
                    left: screenWidthPadding,
                    right: screenWidthPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_pages[index]["title"]!,
                            style: TextStyleConstant.bold26(
                                color: ColorConstant.white)),
                        const SizedBox(height: 8),
                        Text(_pages[index]["description"]!,
                            style: TextStyleConstant.medium16(
                                color: ColorConstant.white)),
                      ],
                    )),
              ],
            );
          },
        ),
        Positioned(
            bottom: responsiveHeight(height: 40),
            left: screenWidthPadding,
            right: screenWidthPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: ColorConstant.primary,
                        dotColor: ColorConstant.white,
                        dotHeight: 12,
                        dotWidth: 12)),
                SizedBox(height: responsiveHeight(height: 160)),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                      title: _currentIndex == _pages.length - 1
                          ? "Get Started"
                          : "Next",
                      onTap: () {
                        if (_currentIndex < _pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else {
                          Get.to(() => const LoginView());
                        }
                      },
                      width: responsiveWidth(width: 300)),
                ),
              ],
            )),
      ],
    ));
  }
}
