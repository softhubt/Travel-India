import 'dart:convert';

GetFindedPlaceListModel getFindedPlaceListModelFromJson(String str) =>
    GetFindedPlaceListModel.fromJson(json.decode(str));

String getFindedPlaceListModelToJson(GetFindedPlaceListModel data) =>
    json.encode(data.toJson());

class GetFindedPlaceListModel {
  String? code;
  List<CategoryLocationList>? categoryLocationList;

  GetFindedPlaceListModel({
    this.code,
    this.categoryLocationList,
  });

  factory GetFindedPlaceListModel.fromJson(Map<String, dynamic> json) =>
      GetFindedPlaceListModel(
        code: json["code"],
        categoryLocationList: json["category_location_list"] == null
            ? []
            : List<CategoryLocationList>.from(json["category_location_list"]!
                .map((x) => CategoryLocationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "category_location_list": categoryLocationList == null
            ? []
            : List<dynamic>.from(categoryLocationList!.map((x) => x.toJson())),
      };
}

class CategoryLocationList {
  String? id;
  String? location;
  String? file;
  String? locationAddBy;

  CategoryLocationList({
    this.id,
    this.location,
    this.file,
    this.locationAddBy,
  });

  factory CategoryLocationList.fromJson(Map<String, dynamic> json) =>
      CategoryLocationList(
        id: json["id"],
        location: json["location"],
        file: json["file"],
        locationAddBy: json["location_add_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "file": file,
        "location_add_by": locationAddBy,
      };
}
