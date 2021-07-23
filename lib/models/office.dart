// To parse this JSON data, do
//
//     final offices = officesFromJson(jsonString);

import 'dart:convert';

Offices officesFromJson(String str) => Offices.fromJson(json.decode(str));

String officesToJson(Offices data) => json.encode(data.toJson());

class Offices {
    Offices({
        this.branch,
        this.email,
        this.address,
        this.phone,
    });

    String branch;
    String email;
    String address;
    String phone;

    factory Offices.fromJson(Map<String, dynamic> json) => Offices(
        branch: json["branch"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "branch": branch,
        "email": email,
        "address": address,
        "phone": phone,
    };
}
