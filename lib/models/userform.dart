// class UserForm {
//   static const String PassionCooking = 'cooking';
//   static const String PassionHiking = 'hiking';
//   static const String PassionTraveling = 'traveling';

//   String firstcard_id = '';
//   String lastcard_id = '';
//   Map<String, bool> passions = {
//     PassionCooking: false,
//     PassionHiking: false,
//     PassionTraveling: false
//   };
//   bool newsletter = false;

//   save() {
//     print('saving user using a web service');
//   }
// }


// To parse this JSON data, do
//
//     final UserForm = UserFormFromJson(jsonString);

import 'dart:convert';

UserForm UserFormFromJson(String str) => UserForm.fromJson(json.decode(str));

String UserFormToJson(UserForm data) => json.encode(data.toJson());

class UserForm {
  String card_id;
  String affiliate_id;
  String cardHolderName;
  String valid_from;
  String valid_to;

  UserForm({
    this.card_id,
    this.affiliate_id,
    this.cardHolderName,
    this.valid_from,
    this.valid_to,
  });

  factory UserForm.fromJson(Map<String, dynamic> json) => UserForm(
    card_id: json["card_id"],
    affiliate_id: json["affiliate_id"],
    cardHolderName: json["cardHolderName"],
    valid_from:   json['valid_from'],
    valid_to : json['valid_to'],

  );

  Map<String, dynamic> toJson() => {
    "card_id": card_id,
    "affiliate_id": affiliate_id,
    'cardHolderName' : cardHolderName,
    "valid_from" : valid_from,
    "valid_to" : valid_to
  };

  save() {}

}