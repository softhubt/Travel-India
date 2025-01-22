import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Controllers/location_detail_controller.dart';

class LocationDetailView extends StatefulWidget {
  final String location;
  const LocationDetailView({super.key, required this.location});

  @override
  State<LocationDetailView> createState() => _LocationDetailViewState();
}

class _LocationDetailViewState extends State<LocationDetailView> {
  LocationDetailController controller = Get.put(LocationDetailController());

  @override
  void initState() {
    super.initState();
    controller
        .initialFunctioun(location: widget.location)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Details',
            style: TextStyle(color: ColorConstant.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(
        () {
          final model = controller.getLocationDetailModel.value;

          log("Category Location List: ${model.itemlist}");

          if (model.itemlist == null || model.itemlist!.isEmpty) {
            return const Center(child: Text('No details available.'));
          }

          final locationDetails = model.itemlist!.first;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image and Title
                Stack(
                  children: [
                    Image.network(
                      locationDetails.file ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Breathtaking\nDestinations",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Book Now'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Place Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Place Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        locationDetails.location ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Location: ${locationDetails.location ?? ''}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'The Eiffel Tower is an iconic symbol of France and a remarkable feat of engineering. Built in 1889, it stands as a testament to the industrial age and offers breathtaking views of Paris. Visitors can explore its history, enjoy the panoramic scenes, and dine in its exquisite restaurants.',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // User Reviews
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150'), // Replace with user image URL
                        ),
                        title: Text('Anna Smith'),
                        subtitle: Text('Posted on Oct 1'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star_half,
                                color: Colors.amber, size: 16),
                          ],
                        ),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150'), // Replace with user image URL
                        ),
                        title: Text('John Doe'),
                        subtitle: Text('Posted on Sep 28'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                          ],
                        ),
                      ),
                      const Divider(),
                      ElevatedButton(
                        onPressed: () {
                          // See all reviews functionality
                        },
                        child: const Text('See All Reviews'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
