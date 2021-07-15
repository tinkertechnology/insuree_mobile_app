// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.data,
  });

  Data data;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.profile,
  });

  ProfileClass profile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    profile: ProfileClass.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
  };
}

class ProfileClass {
  ProfileClass({
    this.phone,
    this.email,
    this.photo,
    this.insuree,
  });

  String phone;
  String email;
  String photo;
  Insuree insuree;

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
    phone: json["phone"],
    email: json["email"],
    photo: json["photo"],
    insuree: Insuree.fromJson(json["insuree"]),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "photo": photo,
    "insuree": insuree.toJson(),
  };
}

class Insuree {
  Insuree({
    this.otherNames,
    this.lastName,
    this.dob,
    this.currentAddress,
    this.validityTo,
  });

  String otherNames;
  String lastName;
  DateTime dob;
  String currentAddress;
  dynamic validityTo;

  factory Insuree.fromJson(Map<String, dynamic> json) => Insuree(
    otherNames: json["otherNames"],
    lastName: json["lastName"],
    dob: DateTime.parse(json["dob"]),
    currentAddress: json["currentAddress"],
    validityTo: json["validityTo"],
  );

  Map<String, dynamic> toJson() => {
    "otherNames": otherNames,
    "lastName": lastName,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "currentAddress": currentAddress,
    "validityTo": validityTo,
  };
}
