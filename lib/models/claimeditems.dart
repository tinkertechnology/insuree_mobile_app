// To parse this JSON data, do
//
//     final claimedItems = claimedItemsFromJson(jsonString);

import 'dart:convert';

ClaimedItems claimedItemsFromJson(String str) => ClaimedItems.fromJson(json.decode(str));

String claimedItemsToJson(ClaimedItems data) => json.encode(data.toJson());

class ClaimedItems {
  ClaimedItems({
    this.data,
  });

  Data data;

  factory ClaimedItems.fromJson(Map<String, dynamic> json) => ClaimedItems(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.insureeClaim,
  });

  List<InsureeClaim> insureeClaim;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    insureeClaim: List<InsureeClaim>.from(json["insureeClaim"].map((x) => InsureeClaim.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "insureeClaim": List<dynamic>.from(insureeClaim.map((x) => x.toJson())),
  };
}

class InsureeClaim {
  InsureeClaim({
    this.items,
  });

  List<ItemElement> items;

  factory InsureeClaim.fromJson(Map<String, dynamic> json) => InsureeClaim(
    items: List<ItemElement>.from(json["items"].map((x) => ItemElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ItemElement {
  ItemElement({
    this.id,
    this.item,
  });

  String id;
  ItemItem item;

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
    id: json["id"],
    item: ItemItem.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item.toJson(),
  };
}

class ItemItem {
  ItemItem({
    this.id,
    this.name,
    this.price,
  });

  String id;
  String name;
  double price;

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
    id: json["id"],
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
  };
}
