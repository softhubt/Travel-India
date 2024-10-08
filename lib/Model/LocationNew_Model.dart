class LocationNewModel {
  final String id;
  final String name;

  LocationNewModel({required this.id, required this.name});

  factory LocationNewModel.fromJson(Map<String, dynamic> json) {
    return LocationNewModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
