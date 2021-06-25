// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  Notifications({
    this.data,
  });

  Data data;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.notifications,
  });

  NotificationsClass notifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: NotificationsClass.fromJson(json["notifications"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications.toJson(),
  };
}

class NotificationsClass {
  NotificationsClass({
    this.edges,
  });

  List<Edge> edges;

  factory NotificationsClass.fromJson(Map<String, dynamic> json) => NotificationsClass(
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
    this.message,
    this.createdAt,
  });

  String message;
  DateTime createdAt;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "createdAt": createdAt.toIso8601String(),
  };
}
