class LocationDetailsModel {
  final String id;
  final String location;
  final String imageUrl;
  final String description;
  final String visitingTime;
  final String openDay;
  final String closeDay;

  LocationDetailsModel({
    required this.id,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.visitingTime,
    required this.openDay,
    required this.closeDay,
  });

  factory LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    return LocationDetailsModel(
      id: json['id'],
      location: json['location'],
      imageUrl: json['file'],
      description: json['description'],
      visitingTime: json['vtime'],
      openDay: json['open_day'],
      closeDay: json['close_day'],
    );
  }
}
