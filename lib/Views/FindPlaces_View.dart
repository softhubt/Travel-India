import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travelindia/Model/finddashbordplace_Model.dart';
import 'package:travelindia/Views/LocationDetail_View.dart';

class FindPlacesView extends StatefulWidget {
  final String state;
  final String city;

  const FindPlacesView({
    super.key,
    required this.state,
    required this.city,
  });

  @override
  _FindPlacesViewState createState() => _FindPlacesViewState();
}

class _FindPlacesViewState extends State<FindPlacesView> {
  List<finddashbordplaceModel> locations =
      []; // Create a list to hold location data

  @override
  void initState() {
    super.initState();
    fetchLocations(
        widget.state, widget.city); // Fetch locations on screen initialization
  }

  Future<void> fetchLocations(String state, String city) async {
    final response = await http.post(
      Uri.parse(
          "https://meradaftar.com/travel_admin/travel_india_api/category_locationlist.php"),
      body: {
        'state_name': state,
        'city_name': city,
        'category': '', // You can pass a category if needed
      },
    );
    if (response.statusCode == 200) {
      List<finddashbordplaceModel> fetchedLocations = [];
      final jsonData = jsonDecode(response.body);
      final locationsList = jsonData['category_location_list'];
      for (var location in locationsList) {
        fetchedLocations.add(finddashbordplaceModel.fromJson(location));
      }
      setState(() {
        locations = fetchedLocations;
      });
    } else {
      throw Exception('Failed to load locations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.city}, ${widget.state}'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LocationDetailPage(locationName: locations[index].name),
                  ),
                );
              },
              child: Container(
                height: 150,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(locations[index].imageUrl),
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
                            locations[index].name,
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
