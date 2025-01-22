class PackageModel {
  final String id;
  final String packageName;
  final String numberOfDays;
  final String price2;
  final String file;

  PackageModel({
    required this.id,
    required this.packageName,
    required this.numberOfDays,
    required this.price2,
    required this.file,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      packageName: json['package_name'],
      numberOfDays: json['number_of_days'],
      price2: json['price2'],
      file: json['file'],
    );
  }
}