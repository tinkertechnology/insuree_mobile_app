// To parse this JSON data, do
//
//     final policyInformation = policyInformationFromJson(jsonString);

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
    this.chfId,
    this.lastName,
    this.otherNames,
    this.insureePolicies,
  });
  
  String chfId;
  String lastName;
  String otherNames;
  List<InsureePolicy> insureePolicies;
  
  factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
    chfId: json["chfId"],
    lastName: json["lastName"],
    otherNames: json["otherNames"],
    insureePolicies: List<InsureePolicy>.from(json["insureePolicies"].map((x) => InsureePolicy.fromJson(x))),
  );
  
  Map<String, dynamic> toJson() => {
    "chfId": chfId,
    "lastName": lastName,
    "otherNames": otherNames,
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
    this.gender,
    this.dob,
    this.healthFacility,
  });
  
  Gender gender;
  DateTime dob;
  dynamic healthFacility;
  
  factory Insuree.fromJson(Map<String, dynamic> json) => Insuree(
    gender: Gender.fromJson(json["gender"]),
    dob: DateTime.parse(json["dob"]),
    healthFacility: json["healthFacility"],
  );
  
  Map<String, dynamic> toJson() => {
    "gender": gender.toJson(),
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "healthFacility": healthFacility,
  };
}

class Gender {
  Gender({
    this.code,
    this.gender,
  });
  
  String code;
  String gender;
  
  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    code: json["code"],
    gender: json["gender"],
  );
  
  Map<String, dynamic> toJson() => {
    "code": code,
    "gender": gender,
  };
}

class Policy {
  Policy({
    this.expiryDate,
  });
  
  DateTime expiryDate;
  
  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
    expiryDate: DateTime.parse(json["expiryDate"]),
  );
  
  Map<String, dynamic> toJson() => {
    "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
  };
}
