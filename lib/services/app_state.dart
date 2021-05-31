import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:card_app/common/env.dart' as env;

class AppState with ChangeNotifier {
  String _dataUrl = env.API_BASE_URL+'/api/card/';//"https://reqres.in/api/users?per_page=20";

  AppState();

  // String _displayText = "";
  String cardId;
  String qrImage;
  bool isVerified;
  bool isPending;
  bool isCancelled;
  bool isRejected;


  String _jsonResonse = "";
  bool _isFetching = false;
  bool _isApiLoaded = false;

  void setCardIDText(String text) {
    cardId = text;
    notifyListeners();
  }

  String get getCardID => cardId;

  bool get isFetching => _isFetching;
  bool get isApiLoading => _isApiLoaded;

  isApiServiceLoading(arg){
      if(arg==true)
      _isApiLoaded =true;
    notifyListeners();
  }

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();

    var response = await http.get(Uri.parse(_dataUrl) ,
    headers: {"Authorization" :  'JWT '+ env.getAuthToken(null)}
    );
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
    }
      if (response.statusCode == 500) {
      Fluttertoast.showToast(msg: 'Failed to connect with server');
    }

    _isFetching = false;
    notifyListeners();
  }

  // String get getResponseText => _jsonResonse;

  List<dynamic> getResponseJson() {
    if (_jsonResonse.isNotEmpty) {
      List<dynamic> json = jsonDecode(_jsonResonse);
      // print(json['data']['avatar']);
      return json;
    }
    return null;
  }
  //retrive user card's qr code 
  Future<void> fetchUserQRCode() async {
    _isFetching = true;
    notifyListeners();

    var response = await http.get(Uri.parse(_dataUrl) ,
    headers: {"Authorization" :  env.getAuthToken(null)}
    );
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
    }
      if (response.statusCode == 500) {
      Fluttertoast.showToast(msg: 'Failed to connect with server');
    }

    _isFetching = false;
    notifyListeners();
  }

}

