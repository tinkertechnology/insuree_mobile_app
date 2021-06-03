import 'dart:convert';

class Insuree { //for auth only
  String chfid;
  String fhchfid;
  String dob;
//  String firstname;
//  String lastname;
  bool isRegisterSuccess;
  Insuree({this.chfid, this.fhchfid, this.dob});

}

// To parse this JSON data, do
//
//     final insureeDetails = insureeDetailsFromJson(jsonString);

//for homepage policy detail and insuree's personal info

InsureeDetails insureeDetailsFromJson(String str) => InsureeDetails.fromJson(json.decode(str));

String insureeDetailsToJson(InsureeDetails data) => json.encode(data.toJson());

class InsureeDetails {
  InsureeDetails({
    this.data,
  });

  Data data;

  factory InsureeDetails.fromJson(Map<String, dynamic> json) => InsureeDetails(
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
    this.insureePolicies,
  });

  String otherNames;
  String lastName;
  List<InsureePolicy> insureePolicies;

  factory InsureeProfile.fromJson(Map<String, dynamic> json) => InsureeProfile(
    otherNames: json["otherNames"],
    lastName: json["lastName"],
    insureePolicies: List<InsureePolicy>.from(json["insureePolicies"].map((x) => InsureePolicy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "otherNames": otherNames,
    "lastName": lastName,
    "insureePolicies": List<dynamic>.from(insureePolicies.map((x) => x.toJson())),
  };
}

class InsureePolicy {
  InsureePolicy({
    this.enrollmentDate,
    this.startDate,
    this.expiryDate,
    this.effectiveDate,
    this.validityFrom,
    this.validityTo,
  });

  DateTime enrollmentDate;
  DateTime startDate;
  DateTime expiryDate;
  DateTime effectiveDate;
  DateTime validityFrom;
  dynamic validityTo;

  factory InsureePolicy.fromJson(Map<String, dynamic> json) => InsureePolicy(
    enrollmentDate: DateTime.parse(json["enrollmentDate"]),
    startDate: DateTime.parse(json["startDate"]),
    expiryDate: DateTime.parse(json["expiryDate"]),
    effectiveDate: DateTime.parse(json["effectiveDate"]),
    validityFrom: DateTime.parse(json["validityFrom"]),
    validityTo: json["validityTo"],
  );

  Map<String, dynamic> toJson() => {
    "enrollmentDate": "${enrollmentDate.year.toString().padLeft(4, '0')}-${enrollmentDate.month.toString().padLeft(2, '0')}-${enrollmentDate.day.toString().padLeft(2, '0')}",
    "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "expiryDate": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
    "effectiveDate": "${effectiveDate.year.toString().padLeft(4, '0')}-${effectiveDate.month.toString().padLeft(2, '0')}-${effectiveDate.day.toString().padLeft(2, '0')}",
    "validityFrom": validityFrom.toIso8601String(),
    "validityTo": validityTo,
  };
}



