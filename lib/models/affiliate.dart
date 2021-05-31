// To parse this JSON data, do
//
//     final affiliate = affiliateFromJson(jsonString);

import 'dart:convert';
class Post {
  final String logo;
  final int id;
  final String name;


  Post({this.logo, this.id, this.name});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      logo: json['logo'],
      id: json['id'],
      name: json['name'],
    );
  }
}

class AffliateModel {
  int name;
  int id;
  String logo;
 
  AffliateModel({this.name, this.id, this.logo});
 
  factory AffliateModel.fromJson(Map<String, dynamic> json) {
    return AffliateModel(
        name: json['name'] as int,
        id: json['id'] as int,
        logo: json['logo'] as String);
  }
}



Affiliate affiliateFromJson(String str) => Affiliate.fromJson(json.decode(str));

String affiliateToJson(Affiliate data) => json.encode(data.toJson());

class Affiliate {
    Affiliate({
        this.id,
        this.template,
        this.name,
        this.location,
        this.contact,
        this.isActive,
        this.logo,
        this.subdomain,
        this.user,
    });

    int id;
    List<Template> template;
    String name;
    String location;
    String contact;
    bool isActive;
    String logo;
    String subdomain;
    int user;

    factory Affiliate.fromJson(Map<String, dynamic> json) => Affiliate(
        id: json["id"],
        template: List<Template>.from(json["template"].map((x) => Template.fromJson(x))),
        name: json["name"],
        location: json["location"],
        contact: json["contact"],
        isActive: json["is_active"],
        logo: json["logo"],
        subdomain: json["subdomain"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "template": List<dynamic>.from(template.map((x) => x.toJson())),
        "name": name,
        "location": location,
        "contact": contact,
        "is_active": isActive,
        "logo": logo,
        "subdomain": subdomain,
        "user": user,
    };
}

class Template {
    Template({
        this.id,
        this.template,
        this.fkAffiliate,
    });

    int id;
    String template;
    int fkAffiliate;

    factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["id"],
        template: json["template"],
        fkAffiliate: json["fk_affiliate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "template": template,
        "fk_affiliate": fkAffiliate,
    };
}
