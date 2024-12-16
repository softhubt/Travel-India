import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';
import 'package:travelindia/Widgets/custom_button.dart';

class DifferentPlacesView extends StatelessWidget {
  const DifferentPlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Travel Different Places"),
      body: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          pattern: [
            const WovenGridTile(1),
            const WovenGridTile(
              5 / 7,
              crossAxisRatio: 0.9,
              alignment: AlignmentDirectional.centerEnd,
            ),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) => GestureDetector(
            onTap: () => showSearchDialog(context: context),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstant.primary.withOpacity(0.2),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Somanath_mandir_%28cropped%29.jpg/1200px-Somanath_mandir_%28cropped%29.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
        ),
      ),
    );
  }

  showSearchDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_rounded)),
              const Text("Search Places")
            ],
          ),
          content: SizedBox(
            height: Get.height * 0.300,
            width: Get.width,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: const ListTile(
                    leading: Icon(Icons.travel_explore_rounded),
                    title: Text("Find Your State"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Get.height * 0.020, bottom: Get.height * 0.060),
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
                const CustomButton(title: "Find Places"),
              ],
            ),
          ),
        );
      },
    );
  }
}
