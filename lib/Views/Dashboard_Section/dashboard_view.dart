import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelindia/Constant/textstyle_constant.dart';
import 'package:travelindia/Controllers/dashboard_controller.dart';
import 'package:travelindia/Model/Get_CategoryList_Model.dart';
import 'package:travelindia/Model/Location_Model.dart';
import 'package:travelindia/Model/PackgeList_Model.dart';
import 'package:travelindia/Views/Dashboard_Section/AddLocationForm_View.dart';
import 'package:travelindia/Views/FindPlacesByCategory_View.dart';
import 'package:travelindia/Views/FindPlaces_View.dart';
import 'package:travelindia/Views/PackageDetialPageNew.dart';
import 'package:travelindia/Widgets/custom_appbar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<LocationModel> states = [];
  List<LocationModel> cities = [];
  LocationModel? selectedState;
  LocationModel? selectedCity;
  Category? selectedCategory;
  List<PackageModel> packages = [];
  final DashboardController controller = Get.put(DashboardController());

  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _visitTimeController = TextEditingController();
  final _openDaysController = TextEditingController();
  final _closeDaysController = TextEditingController();

  // Variables to hold selected state and city

  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    fetchStates();
    fetchPackages();
    controller.initialFunctioun().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _visitTimeController.dispose();
    _openDaysController.dispose();
    _closeDaysController.dispose();
    super.dispose();
  }

  Future<void> fetchStates() async {
    final response = await http.get(Uri.parse(
        "http://meradaftar.com/travel_admin/travel_india_api/state_list.php"));
    if (response.statusCode == 200) {
      List<LocationModel> fetchedStates = [];
      final jsonData = jsonDecode(response.body);
      final statesList = jsonData['itemlist'];
      for (var state in statesList) {
        fetchedStates.add(LocationModel.fromJson(state));
      }
      setState(() {
        states = fetchedStates;
      });
    } else {
      throw Exception('Failed to load states');
    }
  }

  Future<void> fetchCities(String stateName) async {
    final response = await http.post(
        Uri.parse(
            "http://meradaftar.com/travel_admin/travel_india_api/city_list.php"),
        body: {'state_name': stateName});
    if (response.statusCode == 200) {
      List<LocationModel> fetchedCities = [];
      final jsonData = jsonDecode(response.body);
      final citiesList = jsonData['itemlist'];
      for (var city in citiesList) {
        fetchedCities.add(LocationModel.fromJson(city));
      }
      setState(() {
        cities = fetchedCities;
      });
      if (selectedCategory != null) {
        // showCityPickerDialog();
      }
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<void> fetchPackages() async {
    final response = await http.get(Uri.parse(
        "https://meradaftar.com/travel_admin/travel_india_api/package_list.php"));
    if (response.statusCode == 200) {
      List<PackageModel> fetchedPackages = [];
      final jsonData = jsonDecode(response.body);
      final packagesList = jsonData['packagelist'];
      for (var package in packagesList) {
        fetchedPackages.add(PackageModel.fromJson(package));
      }
      setState(() {
        packages = fetchedPackages;
      });
    } else {
      throw Exception('Failed to load packages');
    }
  }

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://meradaftar.com/travel_admin/travel_india_api/category_list.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> categoryList = data['category_list'];

      return categoryList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
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

    if (state.isEmpty ||
        city.isEmpty ||
        locationName.isEmpty ||
        description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
        ),
      );
      return;
    }

    try {
      final request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://meradaftar.com/travel_admin/travel_india_api/location_api.php'))
        ..fields['state'] = state
        ..fields['city'] = city
        ..fields['location'] = locationName
        ..fields['description'] = description
        ..fields['vtime'] = visitTime
        ..fields['open_day'] = openDays
        ..fields['close_day'] = closeDays
        ..fields['location_add_by'] = name
        ..fields['status_approved'] = 'N';

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('file', _image!.path));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      if (data['code'] == '200') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location details submitted successfully')));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Failed to submit location details: ${data['Message']}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          needChildWidget: true,
          childWidget: ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const Text("Home"),
              subtitle: Obx(() => Text(controller.currentAddress.value)),
              trailing: IconButton(
                icon: const Icon(Icons.location_on),
                onPressed: () {
                  if (controller.currentState.value.isNotEmpty &&
                      controller.currentCity.value.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindPlacesView(
                                state: controller.currentState.value,
                                city: controller.currentCity.value)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Current state or city is not available')));
                  }
                },
              ))),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/Images/beach.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.travel_explore_rounded),
                      title: Text(selectedState?.name ?? "Find Your State"),
                      onTap: () {
                        showStatePickerDialog();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.mode_of_travel_rounded),
                      title: Text(selectedCity?.name ?? "Find Your City"),
                      onTap: () {
                        if (selectedState != null) {
                          showCityPickerDialog();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a state first'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedState != null && selectedCity != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FindPlacesView(
                              state: selectedState!.name,
                              city: selectedCity!.name,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please select both state and city')),
                        );
                      }
                    },
                    child: const Text('Find Places'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("Travel by Categories",
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold))),
          SizedBox(
            height: 160,
            child: FutureBuilder<List<Category>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No categories found'));
                } else {
                  final categories = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory =
                                  category; // Set the selected category
                            });
                            showSearchDialog(context,
                                category); // Pass the selected category
                          },
                          child: Container(
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(14),
                                    image: DecorationImage(
                                      image: NetworkImage(category.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category.categoryName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "India's Top Packages",
              style: TextStyleConstant.medium24(),
            ),
          ),
          SizedBox(
            height: 300, // Constrains the ListView's height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: packages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PackageDetailViewnew(package: packages[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: 250, // Fixed width for each card
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height:
                                150, // Limit the image height to fit within the SizedBox
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                image: NetworkImage(packages[index].file),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                            child: Text(
                              packages[index].packageName,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 1, // Prevent overflow by limiting lines
                              overflow: TextOverflow
                                  .ellipsis, // Adds "..." if overflow occurs
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rs. ${packages[index].price2}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${packages[index].numberOfDays} Days',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddLocationScreen(),
                      ),
                    );
                  },
                  child: Image.asset('assets/Images/Location.png'),
                ),
                const SizedBox(height: 8), // Space between icon and text
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Add Favorite Spots',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showStatePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select State"),
          content: SizedBox(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: states.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(states[index].name),
                  onTap: () {
                    setState(() {
                      selectedState = states[index];
                      selectedCity =
                          null; // Reset city selection when state changes
                      fetchCities(selectedState!.name);
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showCityPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select City"),
          content: SizedBox(
            height: 200,
            width: 300,
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cities[index].name),
                  onTap: () {
                    setState(() {
                      selectedCity = cities[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showSearchDialog(BuildContext context, Category selectedCategory) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const Text("Search Places"),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              // Ensure cities list is initialized
              if (selectedState != null && cities.isEmpty) {
                fetchCities(selectedState!.name).then((_) {
                  setState(() {}); // Update UI after fetching cities
                });
              }

              return SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/Images/spash.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // State Dropdown
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButton<LocationModel>(
                            isExpanded: true,
                            hint: Text(selectedState?.name ?? "Select State"),
                            value: selectedState,
                            onChanged: (LocationModel? newState) {
                              setState(() {
                                selectedState = newState;
                                selectedCity = null; // Reset city selection
                                cities =
                                    []; // Clear cities until new ones are fetched
                                if (selectedState != null) {
                                  fetchCities(selectedState!.name);
                                }
                              });
                            },
                            items: states.map((LocationModel state) {
                              return DropdownMenuItem<LocationModel>(
                                value: state,
                                child: Text(state.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      // City Dropdown
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButton<LocationModel>(
                            isExpanded: true,
                            hint: Text(selectedCity?.name ?? "Select City"),
                            value: selectedCity,
                            onChanged: (LocationModel? newCity) {
                              setState(() {
                                selectedCity = newCity;
                              });
                            },
                            items: cities.map((LocationModel city) {
                              return DropdownMenuItem<LocationModel>(
                                value: city,
                                child: Text(city.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Search Button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedState != null && selectedCity != null) {
                              Navigator.of(context)
                                  .pop(); // Close the dialog first
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FindPlacesByCategoryView(
                                    state: selectedState!.name,
                                    city: selectedCity!.name,
                                    category: selectedCategory
                                        .categoryName, // Pass category here
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please select both state and city'),
                                ),
                              );
                            }
                          },
                          child: const Text('Find Places'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // void showAddLocationForm() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Add Location'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: _nameController,
  //                 decoration: const InputDecoration(labelText: 'Location Name'),
  //               ),
  //               TextField(
  //                 controller: _stateController,
  //                 decoration: const InputDecoration(labelText: 'State'),
  //               ),
  //               TextField(
  //                 controller: _cityController,
  //                 decoration: const InputDecoration(labelText: 'City'),
  //               ),
  //               TextField(
  //                 controller: _locationController,
  //                 decoration: const InputDecoration(labelText: 'Location Address'),
  //               ),
  //               TextField(
  //                 controller: _descriptionController,
  //                 decoration: const InputDecoration(labelText: 'Description'),
  //               ),
  //               TextField(
  //                 controller: _visitTimeController,
  //                 decoration: const InputDecoration(labelText: 'Visit Time'),
  //               ),
  //               TextField(
  //                 controller: _openDaysController,
  //                 decoration: const InputDecoration(labelText: 'Open Days'),
  //               ),
  //               TextField(
  //                 controller: _closeDaysController,
  //                 decoration: const InputDecoration(labelText: 'Close Days'),
  //               ),
  //               SizedBox(
  //                 height: 100,
  //                 child: _image == null
  //                     ? const Text('No image selected.')
  //                     : Image.file(_image!),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //                   if (pickedFile != null) {
  //                     setState(() {
  //                       _image = File(pickedFile.path);
  //                     });
  //                   }
  //                 },
  //                 child: const Text('Pick Image'),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               submitLocationDetails();
  //             },
  //             child: const Text('Submit'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
