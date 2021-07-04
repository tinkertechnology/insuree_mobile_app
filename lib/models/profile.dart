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
    this.photo,
    this.email,
    this.insuree,
  });

  String phone;
  String photo;
  String email;
  Insuree insuree;

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
    phone: json["phone"],
    photo: json["photo"],
    email: json["email"],
    insuree: Insuree.fromJson(json["insuree"]),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "photo": photo,
    "email": email,
    "insuree": insuree.toJson(),
  };
}

class Insuree {
  Insuree({
    this.lastName,
    this.otherNames,
    this.dob,
    this.validityTo,
  });

  String lastName;
  String otherNames;
  DateTime dob;
  dynamic validityTo;

  factory Insuree.fromJson(Map<String, dynamic> json) => Insuree(
    lastName: json["lastName"],
    otherNames: json["otherNames"],
    dob: DateTime.parse(json["dob"]),
    validityTo: json["validityTo"],
  );

  Map<String, dynamic> toJson() => {
    "lastName": lastName,
    "otherNames": otherNames,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "validityTo": validityTo,
  };
}
