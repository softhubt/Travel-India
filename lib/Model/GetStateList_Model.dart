import 'dart:convert';

GetStateListModel getStateListModelFromJson(String str) => GetStateListModel.fromJson(json.decode(str));

String getStateListModelToJson(GetStateListModel data) => json.encode(data.toJson());

class GetStateListModel {
  String? dataCode;
  List<ItemList>? itemList;

  GetStateListModel({this.dataCode, this.itemList});

  factory GetStateListModel.fromJson(Map<String, dynamic> json) {
    return GetStateListModel(
      dataCode: json['data_code'],
      itemList: List<ItemList>.from(json['itemlist'].map((x) => ItemList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_code'] = dataCode;
    if (itemList != null) {
      data['itemlist'] = itemList!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}

class ItemList {
  String? id;
  String? name;

  ItemList({this.id, this.name});

  factory ItemList.fromJson(Map<String, dynamic> json) {
    return ItemList(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
