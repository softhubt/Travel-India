class finddashbordplaceModel {
  final String id;
  final String name;
  final String imageUrl;
  final String locationaddby;

  finddashbordplaceModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.locationaddby,
  });

  factory finddashbordplaceModel.fromJson(Map<String, dynamic> json) {
    return finddashbordplaceModel(
      id: json['id'],
      name: json['location'],
      imageUrl: json['file'],
      locationaddby: json['location_add_by'],
    );
  }
}
