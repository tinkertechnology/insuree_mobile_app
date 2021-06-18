// To parse this JSON data, do
//
//     final notice = noticeFromJson(jsonString);

import 'dart:convert';

Notice noticeFromJson(String str) => Notice.fromJson(json.decode(str));

String noticeToJson(Notice data) => json.encode(data.toJson());

class Notice {
    Notice({
        this.data,
    });
    
    Data data;
    
    factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        data: Data.fromJson(json["data"]),
    );
    
    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.notices,
    });
    
    Notices notices;
    
    factory Data.fromJson(Map<String, dynamic> json) => Data(
        notices: Notices.fromJson(json["notices"]),
    );
    
    Map<String, dynamic> toJson() => {
        "notices": notices.toJson(),
    };
}

class Notices {
    Notices({
        this.edges,
    });
    
    List<Edge> edges;
    
    factory Notices.fromJson(Map<String, dynamic> json) => Notices(
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
        this.title,
        this.description,
    });
    
    String id;
    String title;
    String description;
    
    factory Node.fromJson(Map<String, dynamic> json) => Node(
        id: json["id"],
        title: json["title"],
        description: json["description"],
    );
    
    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
    };
}
