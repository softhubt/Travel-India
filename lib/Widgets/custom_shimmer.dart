import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travelindia/Constant/color_constant.dart';

class CustomShimmer extends StatelessWidget {
  final bool? neeChildWidget;
  final Widget? childWidget;
  final double? height;
  final double? width;
  final double? radius;

  const CustomShimmer(
      {super.key,
      this.height,
      this.width,
      this.radius,
      this.neeChildWidget,
      this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstant.grey.withOpacity(0.1),
      highlightColor: ColorConstant.grey.withOpacity(0.3),
      child: (neeChildWidget == true)
          ? childWidget!
          : Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: ColorConstant.black,
                  borderRadius: BorderRadius.circular(radius ?? 10)),
            ),
    );
  }
}
