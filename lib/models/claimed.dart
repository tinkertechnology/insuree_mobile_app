// To parse this JSON data, do
//
//     final claimed = claimedFromJson(jsonString);

import 'dart:convert';

Claimed claimedFromJson(String str) => Claimed.fromJson(json.decode(str));

String claimedToJson(Claimed data) => json.encode(data.toJson());

class Claimed {
  Claimed({
    this.data,
  });

  Data data;

  factory Claimed.fromJson(Map<String, dynamic> json) => Claimed(
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
    this.services,
    this.items,
  });

  List<Service> services;
  List<ItemElement> items;

  factory InsureeClaim.fromJson(Map<String, dynamic> json) => InsureeClaim(
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    items: List<ItemElement>.from(json["items"].map((x) => ItemElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ItemElement {
  ItemElement({
    this.id,
    this.item,
  });

  String id;
  ServiceClass item;

  factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
    id: json["id"],
    item: ServiceClass.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item.toJson(),
  };
}

class ServiceClass {
  ServiceClass({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory ServiceClass.fromJson(Map<String, dynamic> json) => ServiceClass(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Service {
  Service({
    this.id,
    this.service,
  });

  String id;
  ServiceClass service;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    service: ServiceClass.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service.toJson(),
  };
}
