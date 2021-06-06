// To parse this JSON data, do
//
//     final claimedItems = claimedItemsFromJson(jsonString);
import 'dart:convert';

abstract class IDataModel {
  IDataModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}