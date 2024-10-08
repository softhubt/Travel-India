import 'dart:convert';

GetPackageListModel getPackageListModelFromJson(String str) => GetPackageListModel.fromJson(json.decode(str));

String getPackageListModelToJson(GetPackageListModel data) => json.encode(data.toJson());

class GetPackageListModel {
  String? dataCode;
  List<PackageList>? packageList;

  GetPackageListModel({this.dataCode, this.packageList});

  factory GetPackageListModel.fromJson(Map<String, dynamic> json) {
    return GetPackageListModel(
      dataCode: json['data_code'],
      packageList: List<PackageList>.from(json['packagelist'].map((x) => PackageList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_code'] = dataCode;
    if (packageList != null) {
      data['packagelist'] = packageList!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}

class PackageList {
  String? id;
  String? packageName;
  String? numberOfDays;
  String? price2;
  String? file;

  PackageList({this.id, this.packageName, this.numberOfDays, this.price2, this.file});

  factory PackageList.fromJson(Map<String, dynamic> json) {
    return PackageList(
      id: json['id'],
      packageName: json['package_name'],
      numberOfDays: json['number_of_days'],
      price2: json['price2'],
      file: json['file'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_name": packageName,
    "number_of_days": numberOfDays,
    "price2": price2,
    "file": file,
  };
}
