// To parse this JSON data, do
//
//     final policyInformation = policyInformationFromJson(jsonString);
//this model is for homepage of the app

import 'dart:convert';

PolicyInformation policyInformationFromJson(String str) => PolicyInformation.fromJson(json.decode(str));

String policyInformationToJson(PolicyInformation data) => json.encode(data.toJson());

class PolicyInformation {
  PolicyInformation({
    this.data,
  });

  Data data;

  factory PolicyInformation.fromJson(Map<String, dynamic> json) => PolicyInformation(
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
    this.otherNames,
    this.lastName,
    this.chfId,
    this.insureePolicies,
  });

  String otherNames;
  String lastName;
  String chfId;
  List<InsureePolicy> insureePolicies;

  factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
    otherNames: json["otherNames"],
    lastName: json["lastName"],
    chfId: json["chfId"],
    insureePolicies: List<InsureePolicy>.from(json["insureePolicies"].map((x) => InsureePolicy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "otherNames": otherNames,
    "lastName": lastName,
    "chfId": chfId,
    "insureePolicies": List<dynamic>.from(insureePolicies.map((x) => x.toJson())),
  };
}

class InsureePolicy {
  InsureePolicy({
    this.expiryDate,
  });

  DateTime expiryDate;

  factory InsureePolicy.fromJson(Map<String, dynamic> json) => InsureePolicy(
    expiryDate: DateTime.parse(json["expiryDate"]),
  );

  Map<String, dynamic> toJson() => {
    "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
  };
}
