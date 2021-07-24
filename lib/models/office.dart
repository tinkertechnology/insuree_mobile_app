// To parse this JSON data, do
//
//     final offices = officesFromJson(jsonString);

import 'dart:convert';

Offices officesFromJson(String str) => Offices.fromJson(json.decode(str));

String officesToJson(Offices data) => json.encode(data.toJson());

class Offices {
    Offices({
        this.branchOfficeDetails,
    });

    List<BranchOfficeDetail> branchOfficeDetails;

    factory Offices.fromJson(Map<String, dynamic> json) => Offices(
        branchOfficeDetails: List<BranchOfficeDetail>.from(json["BranchOfficeDetails"].map((x) => BranchOfficeDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "BranchOfficeDetails": List<dynamic>.from(branchOfficeDetails.map((x) => x.toJson())),
    };
}

class BranchOfficeDetail {
    BranchOfficeDetail({
        this.name,
        this.address,
        this.email,
        this.phone,
    });

    String name;
    String address;
    String email;
    List<String> phone;

    factory BranchOfficeDetail.fromJson(Map<String, dynamic> json) => BranchOfficeDetail(
        name: json["Name"],
        address: json["Address"],
        email: json["Email"],
        phone: List<String>.from(json["Phone"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Address": address,
        "Email": email,
        "Phone": List<dynamic>.from(phone.map((x) => x)),
    };
}
