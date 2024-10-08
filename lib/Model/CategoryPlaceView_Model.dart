class Place {
  final String name;
  final String description;

  Place({required this.name, required this.description});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      description: json['description'],
    );
  }
}
