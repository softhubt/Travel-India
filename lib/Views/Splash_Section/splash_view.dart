import 'package:flutter/material.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Travel India", style: TextStyleConstant.semiBold22())),
    );
  }
}
