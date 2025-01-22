import 'dart:convert';

GetCityListModel getCityListModelFromJson(String str) =>
    GetCityListModel.fromJson(json.decode(str));

String getCityListModelToJson(GetCityListModel data) =>
    json.encode(data.toJson());

class GetCityListModel {
  String? dataCode;
  List<Itemlist>? itemlist;

  GetCityListModel({
    this.dataCode,
    this.itemlist,
  });

  factory GetCityListModel.fromJson(Map<String, dynamic> json) =>
      GetCityListModel(
        dataCode: json["data_code"],
        itemlist: json["itemlist"] == null
            ? []
            : List<Itemlist>.from(
                json["itemlist"]!.map((x) => Itemlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data_code": dataCode,
        "itemlist": itemlist == null
            ? []
            : List<dynamic>.from(itemlist!.map((x) => x.toJson())),
      };
}

class Itemlist {
  String? id;
  String? name;

  Itemlist({
    this.id,
    this.name,
  });

  factory Itemlist.fromJson(Map<String, dynamic> json) => Itemlist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
