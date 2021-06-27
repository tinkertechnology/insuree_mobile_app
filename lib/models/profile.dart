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
  });

  String phone;
  String email;
  String photo;

  factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
    phone: json["phone"],
    email: json["email"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "photo": photo,
  };
}
