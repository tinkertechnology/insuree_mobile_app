// To parse this JSON data, do
//
//     final insureeInfo = insureeInfoFromJson(jsonString);

import 'dart:convert';

InsureeInfo insureeInfoFromJson(String str) => InsureeInfo.fromJson(json.decode(str));

String insureeInfoToJson(InsureeInfo data) => json.encode(data.toJson());

class InsureeInfo {
  InsureeInfo({
    this.data,
  });

  Data data;

  factory InsureeInfo.fromJson(Map<String, dynamic> json) => InsureeInfo(
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
    this.remainingDays,
    this.otherNames,
    this.lastName,
    this.insureePolicies,
  });

  String remainingDays;
  String otherNames;
  String lastName;
  List<InsureePolicy> insureePolicies;

  factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
    remainingDays: json["remainingDays"],
    otherNames: json["otherNames"],
    lastName: json["lastName"],
    insureePolicies: List<InsureePolicy>.from(json["insureePolicies"].map((x) => InsureePolicy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "remainingDays": remainingDays,
    "otherNames": otherNames,
    "lastName": lastName,
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

  dynamic healthFacility;

  factory Insuree.fromJson(Map<String, dynamic> json) => Insuree(
    healthFacility: json["healthFacility"],
  );

  Map<String, dynamic> toJson() => {
    "healthFacility": healthFacility,
  };
}

class Policy {
  Policy({
    this.value,
    this.expiryDate,
  });

  double value;
  DateTime expiryDate;

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
    value: json["value"],
    expiryDate: DateTime.parse(json["expiryDate"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
  };
}
