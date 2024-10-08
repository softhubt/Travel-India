// lib/Model/PackageDetail_Model.dart
class PackageDetailModel {
  final String id;
  final String packageName;
  final String numberOfDays;
  final String bAmount;
  final String payment;
  final String price2;
  final String price3;
  final String price4;
  final String price5;
  final String price6;
  final String file;
  final String description;

  PackageDetailModel({
    required this.id,
    required this.packageName,
    required this.numberOfDays,
    required this.bAmount,
    required this.payment,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.price6,
    required this.file,
    required this.description,
  });

  factory PackageDetailModel.fromJson(Map<String, dynamic> json) {
    return PackageDetailModel(
      id: json['id'],
      packageName: json['package_name'],
      numberOfDays: json['number_of_days'],
      bAmount: json['b_amount'],
      payment: json['payment'],
      price2: json['price2'],
      price3: json['price3'],
      price4: json['price4'],
      price5: json['price5'],
      price6: json['price6'],
      file: json['file'],
      description: json['description'],
    );
  }
}
