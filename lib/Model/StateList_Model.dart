import 'dart:convert';

StateListModel stateListModelFromJson(String str) => StateListModel.fromJson(json.decode(str));

String stateListModelToJson(StateListModel data) => json.encode(data.toJson());

class StateListModel {
  String? dataCode;
  List<Item>? itemList;

  StateListModel({this.dataCode, this.itemList});

  factory StateListModel.fromJson(Map<String, dynamic> json) {
    return StateListModel(
      dataCode: json['data_code'],
      itemList: List<Item>.from(json['itemlist'].map((x) => Item.fromJson(x))),
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

class Item {
  String? id;
  String? name;

  Item({this.id, this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
