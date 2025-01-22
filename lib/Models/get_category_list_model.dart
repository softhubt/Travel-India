import 'dart:convert';

GetCategoryListModel getCategoryListModelFromJson(String str) =>
    GetCategoryListModel.fromJson(json.decode(str));

String getCategoryListModelToJson(GetCategoryListModel data) =>
    json.encode(data.toJson());

class GetCategoryListModel {
  String? dataCode;
  List<CategoryList>? categoryList;

  GetCategoryListModel({
    this.dataCode,
    this.categoryList,
  });

  factory GetCategoryListModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryListModel(
        dataCode: json["data_code"],
        categoryList: json["category_list"] == null
            ? []
            : List<CategoryList>.from(
                json["category_list"]!.map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data_code": dataCode,
        "category_list": categoryList == null
            ? []
            : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
      };
}

class CategoryList {
  String? id;
  String? categoryName;
  String? image;

  CategoryList({
    this.id,
    this.categoryName,
    this.image,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        categoryName: json["category_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "image": image,
      };
}
