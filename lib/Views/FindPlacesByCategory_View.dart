import 'package:flutter/material.dart';

class FindPlacesByCategoryView extends StatefulWidget {
  final String state;
  final String city;
  final String category;

  const FindPlacesByCategoryView({
    super.key,
    required this.state,
    required this.city,
    required this.category,
  });

  @override
  _FindPlacesByCategoryViewState createState() =>
      _FindPlacesByCategoryViewState();
}

class _FindPlacesByCategoryViewState extends State<FindPlacesByCategoryView> {
  // List<finddashbordplaceModel> locations =
  //     []; // Create a list to hold location data

  // @override
  // void initState() {
  //   super.initState();
  //   fetchLocations(widget.state, widget.city,
  //       widget.category); // Fetch locations on screen initialization
  // }

  // Future<void> fetchLocations(
  //     String state, String city, String category) async {
  //   final response = await http.post(
  //     Uri.parse(
  //         "https://meradaftar.com/travel_admin/travel_india_api/category_locationlist.php"),
  //     body: {
  //       'state_name': state,
  //       'city_name': city,
  //       'category': category, // Passing the category
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     final List<dynamic> locationsList = jsonData['category_location_list'];

  //     setState(() {
  //       locations = locationsList
  //           .map((json) => finddashbordplaceModel.fromJson(json))
  //           .toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load locations');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.city}, ${widget.state} - ${widget.category}'),
      ),

      // body: ListView.builder(
      //   itemCount: locations.length,
      //   itemBuilder: (context, index) {
      //     final location = locations[index];
      //     return Padding(
      //       padding:
      //           const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) =>
      //                   LocationDetailPage(locationName: location.name),
      //             ),
      //           );
      //         },
      //         child: Container(
      //           height: 150,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(8.0),
      //             image: DecorationImage(
      //               fit: BoxFit.cover,
      //               image: NetworkImage(location.imageUrl),
      //             ),
      //           ),
      //           child: Stack(
      //             children: [
      //               Positioned(
      //                 top: 8.0,
      //                 left: 8.0,
      //                 child: Row(
      //                   children: [
      //                     const Icon(Icons.location_on,
      //                         color: Colors.white, size: 20.0),
      //                     const SizedBox(width: 4.0),
      //                     Text(
      //                       location.name,
      //                       style: const TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 16.0,
      //                         fontWeight: FontWeight.bold,
      //                         shadows: [
      //                           Shadow(
      //                             blurRadius: 5.0,
      //                             color: Colors.black,
      //                             offset: Offset(1.0, 1.0),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
