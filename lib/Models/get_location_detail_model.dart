import 'dart:convert';

GetLocationDetailModel getLocationDetailModelFromJson(String str) =>
    GetLocationDetailModel.fromJson(json.decode(str));

String getLocationDetailModelToJson(GetLocationDetailModel data) =>
    json.encode(data.toJson());

class GetLocationDetailModel {
  String? dataCode;
  List<Itemlist>? itemlist;

  GetLocationDetailModel({
    this.dataCode,
    this.itemlist,
  });

  factory GetLocationDetailModel.fromJson(Map<String, dynamic> json) =>
      GetLocationDetailModel(
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
  String? location;
  String? file;
  String? description;
  String? vtime;
  String? openDay;
  String? closeDay;

  Itemlist({
    this.id,
    this.location,
    this.file,
    this.description,
    this.vtime,
    this.openDay,
    this.closeDay,
  });

  factory Itemlist.fromJson(Map<String, dynamic> json) => Itemlist(
        id: json["id"],
        location: json["location"],
        file: json["file"],
        description: json["description"],
        vtime: json["vtime"],
        openDay: json["open_day"],
        closeDay: json["close_day"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "file": file,
        "description": description,
        "vtime": vtime,
        "open_day": openDay,
        "close_day": closeDay,
      };
}
