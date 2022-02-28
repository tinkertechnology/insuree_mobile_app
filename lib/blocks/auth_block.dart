import 'package:flutter/material.dart';
import 'package:openimis_web_app/models/user.dart';
import 'package:openimis_web_app/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBlock extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  AuthBlock() {
    setUser();
  }
  AuthService _authService = AuthService();
  // Index
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }


//getters for token expiry checker
  bool isTokenExpired;
  bool get tokenExpired => isTokenExpired;
  set tokenExpired(bool check){
    isTokenExpired = check;
    notifyListeners();
  }

  // Loading
  bool _loading = false;
  String _loadingType;
  bool get loading => _loading;
  String get loadingType => _loadingType;
  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }
  set loadingType(String loadingType) {
    _loadingType = loadingType;
    notifyListeners();
  }
  // Loading
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool isUserExist) {
    _isLoggedIn = isUserExist;
    notifyListeners();
  }

  bool _isRegisterSuccess = false;
  bool get isRegisterSuccess => _isRegisterSuccess;

  // user
  Map _user = {};
  Map get user => _user;
  setUser() async {
    _user = await _authService.getUser();
    isLoggedIn = _user == null ? false : true;
    notifyListeners();

  }

  login(UserCredential userCredential) async {
    loading = true;
    loadingType = 'login';
    await _authService.login(userCredential);
    setUser();
    loading = false;
    notifyListeners();
  }



  register(UserRegister userRegister) async {
    loading = true;
    loadingType = 'register';
    var a = await _authService.register(userRegister);
    if(a==null)
    {
      loading = false;
    }
      else{
      _isRegisterSuccess = true;
      }
    notifyListeners();

  }


    validateOtp(UserRegister userRegister) async {
    loading = true;
    loadingType = 'register';
    var a = await _authService.register(userRegister);
    if(a==null)
    {
      loading = false;
    }
      else{
      _isRegisterSuccess = true;
      }
    notifyListeners();

  }

  logout() async {
    await _authService.logout();
    isLoggedIn = false;
    await storage.deleteAll();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    notifyListeners();
  }
}
