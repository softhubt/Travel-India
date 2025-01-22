import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Controllers/find_places_controller.dart';
import 'package:travelindia/Views/Dashboard_Section/location_detail_view.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';

class FindPlacesView extends StatefulWidget {
  final String state;
  final String city;
  const FindPlacesView({super.key, required this.state, required this.city});

  @override
  State<FindPlacesView> createState() => _FindPlacesViewState();
}

class _FindPlacesViewState extends State<FindPlacesView> {
  FindPlacesController controller = Get.put(FindPlacesController());

  @override
  void initState() {
    super.initState();
    controller
        .initialFunctioun(stateName: widget.state, cityName: widget.city)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.cloudWhite,
      appBar: CustomAppBar(
          backGroundColor: ColorConstant.primary,
          centerTitle: true,
          textColor: ColorConstant.white,
          backIconColor: ColorConstant.white,
          title: '${widget.city}, ${widget.state}',
          needBackIcon: true),
      body: ListView.builder(
        itemCount:
            controller.getFindedPlaceListModel.categoryLocationList?.length,
        itemBuilder: (context, index) {
          final element =
              controller.getFindedPlaceListModel.categoryLocationList?[index];

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationDetailView(
                            location: element?.location ?? "")));
              },
              child: Container(
                height: 150,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(element?.file ?? ""),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            element?.location ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
