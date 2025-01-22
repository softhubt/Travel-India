import 'dart:convert';

GetPackageListModel getPackageListModelFromJson(String str) =>
    GetPackageListModel.fromJson(json.decode(str));

String getPackageListModelToJson(GetPackageListModel data) =>
    json.encode(data.toJson());

class GetPackageListModel {
  String? dataCode;
  List<Packagelist>? packagelist;

  GetPackageListModel({
    this.dataCode,
    this.packagelist,
  });

  factory GetPackageListModel.fromJson(Map<String, dynamic> json) =>
      GetPackageListModel(
        dataCode: json["data_code"],
        packagelist: json["packagelist"] == null
            ? []
            : List<Packagelist>.from(
                json["packagelist"]!.map((x) => Packagelist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data_code": dataCode,
        "packagelist": packagelist == null
            ? []
            : List<dynamic>.from(packagelist!.map((x) => x.toJson())),
      };
}

class Packagelist {
  String? id;
  String? packageName;
  String? numberOfDays;
  String? price2;
  String? file;

  Packagelist({
    this.id,
    this.packageName,
    this.numberOfDays,
    this.price2,
    this.file,
  });

  factory Packagelist.fromJson(Map<String, dynamic> json) => Packagelist(
        id: json["id"],
        packageName: json["package_name"],
        numberOfDays: json["number_of_days"],
        price2: json["price2"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "number_of_days": numberOfDays,
        "price2": price2,
        "file": file,
      };
}
