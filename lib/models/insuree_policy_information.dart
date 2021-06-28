// To parse this JSON data, do
//
//     final insureePolicyInformation = insureePolicyInformationFromJson(jsonString);

import 'dart:convert';

InsureePolicyInformation insureePolicyInformationFromJson(String str) => InsureePolicyInformation.fromJson(json.decode(str));

String insureePolicyInformationToJson(InsureePolicyInformation data) => json.encode(data.toJson());

class InsureePolicyInformation {
    InsureePolicyInformation({
        this.data,
    });

    Data data;

    factory InsureePolicyInformation.fromJson(Map<String, dynamic> json) => InsureePolicyInformation(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.insureeProfile,
    });

    InsureeProfile insureeProfile;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        insureeProfile: InsureeProfile.fromJson(json["insureeProfile"]),
    );

    Map<String, dynamic> toJson() => {
        "insureeProfile": insureeProfile.toJson(),
    };
}

class InsureeProfile {
    InsureeProfile({
        this.chfId,
        this.insureePolicies,
    });

    String chfId;
    List<InsureePolicy> insureePolicies;

    factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
        chfId: json["chfId"],
        insureePolicies: List<InsureePolicy>.from(json["insureePolicies"].map((x) => InsureePolicy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chfId": chfId,
        "insureePolicies": List<dynamic>.from(insureePolicies.map((x) => x.toJson())),
    };
}

class InsureePolicy {
    InsureePolicy({
        this.policy,
        this.insuree,
    });

    Policy policy;
    Insuree insuree;

    factory InsureePolicy.fromJson(Map<String, dynamic> json) => InsureePolicy(
        policy: Policy.fromJson(json["policy"]),
        insuree: Insuree.fromJson(json["insuree"]),
    );

    Map<String, dynamic> toJson() => {
        "policy": policy.toJson(),
        "insuree": insuree.toJson(),
    };
}

class Insuree {
    Insuree({
        this.healthFacility,
    });

    HealthFacility healthFacility;

    factory Insuree.fromJson(Map<String, dynamic> json) => Insuree(
        healthFacility: HealthFacility.fromJson(json["healthFacility"]),
    );

    Map<String, dynamic> toJson() => {
        "healthFacility": healthFacility.toJson(),
    };
}

class HealthFacility {
    HealthFacility({
        this.code,
        this.name,
    });

    String code;
    String name;

    factory HealthFacility.fromJson(Map<String, dynamic> json) => HealthFacility(
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
    };
}

class Policy {
    Policy({
        this.value,
        this.expiryDate,
        this.status,
    });

    double value;
    DateTime expiryDate;
    int status;

    factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        value: json["value"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "status": status,
    };
}
