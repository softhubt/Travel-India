import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _visitTimeController = TextEditingController();
  final _openDaysController = TextEditingController();
  final _closeDaysController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<String?> _convertImageToBase64() async {
    if (_image == null) return null;
    try {
      final imageBytes = await _image!.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e) {
      print('Error converting image to Base64: $e');
      return null;
    }
  }

  Future<void> submitLocationDetails() async {
    final name = _nameController.text;
    final locationName = _locationController.text;
    final state = _stateController.text;
    final city = _cityController.text;
    final description = _descriptionController.text;
    final visitTime = _visitTimeController.text;
    final openDays = _openDaysController.text;
    final closeDays = _closeDaysController.text;

    if (state.isEmpty || city.isEmpty || locationName.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
        ),
      );
      return;
    }

    try {
      final imageBase64 = await _convertImageToBase64();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://meradaftar.com/travel_admin/travel_india_api/location_api.php'),
      )
        ..fields['state'] = state
        ..fields['city'] = city
        ..fields['location'] = locationName
        ..fields['description'] = description
        ..fields['vtime'] = visitTime
        ..fields['open_day'] = openDays
        ..fields['close_day'] = closeDays
        ..fields['location_add_by'] = name
        ..fields['status_approved'] = 'N';

      if (imageBase64 != null) {
        request.fields['image'] = imageBase64; // Add the Base64 image string
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      if (data['code'] == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location details submitted successfully'),
          ),
        );
        Navigator.of(context).pop(); // Close the dialog on successful submission
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit location details: ${data['Message']}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey.shade100, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Location Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _stateController,
                            decoration: const InputDecoration(
                              labelText: 'State',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _locationController,
                            decoration: const InputDecoration(
                              labelText: 'Location Address',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _visitTimeController,
                            decoration: const InputDecoration(
                              labelText: 'Visit Time',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _openDaysController,
                            decoration: const InputDecoration(
                              labelText: 'Open Days',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _closeDaysController,
                            decoration: const InputDecoration(
                              labelText: 'Close Days',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _image == null
                              ? Center(child: Text('No image selected.', style: TextStyle(color: Colors.grey)))
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  _image = File(pickedFile.path);
                                });
                              }
                            },
                            icon: Icon(Icons.photo_library),
                            label: Text('Pick Image'),
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      submitLocationDetails();
                    },
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
