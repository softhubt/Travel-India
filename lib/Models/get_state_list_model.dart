import 'dart:convert';

GetStateListModel getStateListModelFromJson(String str) =>
    GetStateListModel.fromJson(json.decode(str));

String getStateListModelToJson(GetStateListModel data) =>
    json.encode(data.toJson());

class GetStateListModel {
  String? dataCode;
  List<Itemlist>? itemlist;

  GetStateListModel({
    this.dataCode,
    this.itemlist,
  });

  factory GetStateListModel.fromJson(Map<String, dynamic> json) =>
      GetStateListModel(
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
