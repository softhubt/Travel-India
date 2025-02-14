import 'dart:convert';

GetPackageDetailModel getPackageDetailModelFromJson(String str) =>
    GetPackageDetailModel.fromJson(json.decode(str));

String getPackageDetailModelToJson(GetPackageDetailModel data) =>
    json.encode(data.toJson());

class GetPackageDetailModel {
  String? dataCode;
  List<Packagelist>? packagelist;

  GetPackageDetailModel({this.dataCode, this.packagelist});

  factory GetPackageDetailModel.fromJson(Map<String, dynamic> json) =>
      GetPackageDetailModel(
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
  String? bAmount;
  String? payment;
  String? price2;
  String? price3;
  String? price4;
  String? price5;
  String? price6;
  String? file;
  String? description;
  String? day1;
  String? day2;
  String? day3;
  String? day4;
  String? day5;
  String? day6;

  Packagelist({
    this.id,
    this.packageName,
    this.numberOfDays,
    this.bAmount,
    this.payment,
    this.price2,
    this.price3,
    this.price4,
    this.price5,
    this.price6,
    this.file,
    this.description,
    this.day1,
    this.day2,
    this.day3,
    this.day4,
    this.day5,
    this.day6,
  });

  factory Packagelist.fromJson(Map<String, dynamic> json) => Packagelist(
        id: json["id"],
        packageName: json["package_name"],
        numberOfDays: json["number_of_days"],
        bAmount: json["b_amount"],
        payment: json["payment"],
        price2: json["price2"],
        price3: json["price3"],
        price4: json["price4"],
        price5: json["price5"],
        price6: json["price6"],
        file: json["file"],
        description: json["description"],
        day1: json["day1"],
        day2: json["day2"],
        day3: json["day3"],
        day4: json["day4"],
        day5: json["day5"],
        day6: json["day6"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_name": packageName,
        "number_of_days": numberOfDays,
        "b_amount": bAmount,
        "payment": payment,
        "price2": price2,
        "price3": price3,
        "price4": price4,
        "price5": price5,
        "price6": price6,
        "file": file,
        "description": description,
        "day1": day1,
        "day2": day2,
        "day3": day3,
        "day4": day4,
        "day5": day5,
        "day6": day6,
      };
}
