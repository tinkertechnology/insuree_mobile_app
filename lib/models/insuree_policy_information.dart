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
    this.insureePolicies,
  });

  List<InsureePolicy> insureePolicies;

  factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
    insureePolicies: List<InsureePolicy>.from(json["insureePolicies"].map((x) => InsureePolicy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "insureePolicies": List<dynamic>.from(insureePolicies.map((x) => x.toJson())),
  };
}

class InsureePolicy {
  InsureePolicy({
    this.policy,
  });

  Policy policy;

  factory InsureePolicy.fromJson(Map<String, dynamic> json) => InsureePolicy(
    policy: Policy.fromJson(json["policy"]),
  );

  Map<String, dynamic> toJson() => {
    "policy": policy.toJson(),
  };
}

class Policy {
  Policy({
    this.legacyId,
    this.effectiveDate,
    this.expiryDate,
    this.validityFrom,
    this.validityTo,
    this.status,
    this.value,
  });

  dynamic legacyId;
  DateTime effectiveDate;
  DateTime expiryDate;
  DateTime validityFrom;
  dynamic validityTo;
  int status;
  double value;

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
    legacyId: json["legacyId"],
    effectiveDate: DateTime.parse(json["effectiveDate"]),
    expiryDate: DateTime.parse(json["expiryDate"]),
    validityFrom: DateTime.parse(json["validityFrom"]),
    validityTo: json["validityTo"],
    status: json["status"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "legacyId": legacyId,
    "effectiveDate": "${effectiveDate.year.toString().padLeft(4, '0')}-${effectiveDate.month.toString().padLeft(2, '0')}-${effectiveDate.day.toString().padLeft(2, '0')}",
    "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
    "validityFrom": validityFrom.toIso8601String(),
    "validityTo": validityTo,
    "status": status,
    "value": value,
  };
}
