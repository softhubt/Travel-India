import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:travelindia/Views/Profile_View.dart';

class LocationDetailPage extends StatefulWidget {
  final String locationName;

  const LocationDetailPage({super.key, required this.locationName});

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  Future<Map<String, dynamic>> fetchLocationDetails() async {
    final response = await http.post(
      Uri.parse(
          "https://meradaftar.com/travel_admin/travel_india_api/location_details.php"),
      body: {
        'location_name': widget.locationName,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load location details');
    }
  }

  // State variables to track the selected icon
  bool _isLocationSelected = false;
  bool _isVisitTimeSelected = false;
  bool _isShareSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.locationName),
      ),
      body: FutureBuilder(
        future: fetchLocationDetails(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          } else {
            var item = snapshot.data!['itemlist'][0];

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Image.network(item['file']),
                const SizedBox(height: 16.0),
                // Row with icons and labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.location_on),
                          color:
                              _isLocationSelected ? Colors.blue : Colors.black,
                          onPressed: () {
                            setState(() {
                              _isLocationSelected = !_isLocationSelected;
                              _isVisitTimeSelected = false;
                              _isShareSelected = false;
                              // Implement location action here
                            });
                          },
                        ),
                        const Text('Location'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          color:
                              _isVisitTimeSelected ? Colors.blue : Colors.black,
                          onPressed: () {
                            setState(() {
                              _isVisitTimeSelected = !_isVisitTimeSelected;
                              _isLocationSelected = false;
                              _isShareSelected = false;
                            });
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Visiting Time Details'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Visiting Time: ${item['vtime']}'),
                                    Text('Open Day: ${item['open_day']}'),
                                    Text('Close Day: ${item['close_day']}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const Text('Visit Time'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share),
                          color: _isShareSelected ? Colors.blue : Colors.black,
                          onPressed: () {
                            setState(() {
                              _isShareSelected = !_isShareSelected;
                              _isLocationSelected = false;
                              _isVisitTimeSelected = false;
                            });
                            Share.share(
                              'Check out this location: ${item['description']} \nVisiting Time: ${item['vtime']} \nOpen Day: ${item['open_day']} \nClose Day: ${item['close_day']}',
                              subject: 'Share Location Details',
                            );
                          },
                        ),
                        const Text('Share'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  item['description'],
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trip_origin),
            label: 'Plan Trip',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Navigate to Home
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              ); // Navigate to Profile
              break;
          }
        },
      ),
    );
  }
}
