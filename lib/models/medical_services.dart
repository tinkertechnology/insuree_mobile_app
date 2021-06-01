// To parse this JSON data, do
//
//     final medicalServices = medicalServicesFromJson(jsonString);

import 'dart:convert';

MedicalServices medicalServicesFromJson(String str) => MedicalServices.fromJson(json.decode(str));

String medicalServicesToJson(MedicalServices data) => json.encode(data.toJson());

class MedicalServices {
  MedicalServices({
    this.data,
  });

  Data data;

  factory MedicalServices.fromJson(Map<String, dynamic> json) => MedicalServices(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.medicalServicesStr,
  });

  MedicalServicesStr medicalServicesStr;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    medicalServicesStr: MedicalServicesStr.fromJson(json["medicalServicesStr"]),
  );

  Map<String, dynamic> toJson() => {
    "medicalServicesStr": medicalServicesStr.toJson(),
  };
}

class MedicalServicesStr {
  MedicalServicesStr({
    this.edges,
  });

  List<Edge> edges;

  factory MedicalServicesStr.fromJson(Map<String, dynamic> json) => MedicalServicesStr(
    edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
  };
}

class Edge {
  Edge({
    this.node,
  });

  Node node;

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
    node: Node.fromJson(json["node"]),
  );

  Map<String, dynamic> toJson() => {
    "node": node.toJson(),
  };
}

class Node {
  Node({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
