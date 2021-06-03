// To parse this JSON data, do
//
//     final claimedServices = claimedServicesFromJson(jsonString);

import 'dart:convert';

ClaimedServices claimedServicesFromJson(String str) => ClaimedServices.fromJson(json.decode(str));

String claimedServicesToJson(ClaimedServices data) => json.encode(data.toJson());

class ClaimedServices {
  ClaimedServices({
    this.data,
  });

  Data data;

  factory ClaimedServices.fromJson(Map<String, dynamic> json) => ClaimedServices(
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
  });

  List<ServiceElement> services;

  factory InsureeClaim.fromJson(Map<String, dynamic> json) => InsureeClaim(
    services: List<ServiceElement>.from(json["services"].map((x) => ServiceElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class ServiceElement {
  ServiceElement({
    this.id,
    this.service,
  });

  String id;
  ServiceService service;

  factory ServiceElement.fromJson(Map<String, dynamic> json) => ServiceElement(
    id: json["id"],
    service: ServiceService.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service": service.toJson(),
  };
}

class ServiceService {
  ServiceService({
    this.id,
    this.name,
    this.price,
  });

  String id;
  String name;
  double price;

  factory ServiceService.fromJson(Map<String, dynamic> json) => ServiceService(
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
