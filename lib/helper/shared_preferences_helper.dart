import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//class SessionManager {
//  final String auth_token = "auth_token";
//
////set data into shared preferences like this
//  Future<void> setAuthToken(String auth_token) async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString(this.auth_token, auth_token);
//  }
//
////get value from shared preferences
//  Future<String> getAuthToken() async {
//    final SharedPreferences pref = await SharedPreferences.getInstance();
//    String auth_token;
//    auth_token = pref.getString(this.auth_token) ?? null;
//    return auth_token;
//  }
//}


class SessionManager {
  final String fullname = "";
  final String image_url = null;

//set data into shared preferences like this
  Future<void> setFullname(String fullname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.fullname, fullname);
  }

//get value from shared preferences
  Future<String> getFullname() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String fullname;
    fullname = pref.getString(this.fullname) ?? "";
    return fullname;
  }

  Future<String>setImage(String image_url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.image_url, image_url);
  }

    Future<String> getImage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String image_url;
    image_url = pref.getString(this.image_url) ?? "";
    return image_url;
  }


  Future<void> setUserInfo(String fullname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.fullname, fullname);
  }
}

