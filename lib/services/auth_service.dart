import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:card_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:card_app/blocks/auth_block.dart';
import  'package:card_app/common/env.dart' as env;

class AuthService {

  AuthBlock auth;
  final storage = FlutterSecureStorage();
  // Create storage
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  Future<Map> login(UserCredential userCredential) async {
    final response = await http.post(Uri.parse(env.API_BASE_URL),
        headers: {
          "Content-Type": "application/json",
//                "Accept" : "application/json"
        },
        body:
//        jsonEncode({"query":"\n\nquery{"
//            "\n  insureeAuthOtp(chfid:""  \n   \"${userCredential.chfid}\", otp: \n    \"${userCredential.otp}\"\n  ){\n    id\n    token\n    \n  }\n}","variables":null}));
        jsonEncode({"query":"# {\n#   {\n#     id\n#     token\n#   }\n# }\n\n\n{\n  insureeAuthOtp(chfid:\"${userCredential.chfid}\", otp:\"${userCredential.otp}\"){\n    token\n    insuree{\n      chfId\n    }\n  }\n}\n\n\n# ","variables":null}));
    print(jsonDecode(response.body));

    print('tara baji lai lai');

    if (response.statusCode == 200) {
        var jdr = jsonDecode(response.body);
        if (jdr['data']['insureeAuthOtp']==null)
          {
            Fluttertoast.showToast(
                msg: "Incorrect OTP Details Pls try again ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                fontSize: 16.0);
            return null;
          }

      setUser(response.body);
      Fluttertoast.showToast(
          msg: "Login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return jsonDecode(response.body);
    }
    else{
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          fontSize: 16.0);
    }

  }

  Future<Map> register(UserRegister userRegister) async {
    //String abcd = user.password;
    // user.isRegisterSuccess =false;
  env.setRegisterSuccessFalse();
    //final response = await http.post('$BASE_URL/tradebakerz/wc/v1/register',
    final response = await http.post(Uri.parse(''),
        body: {
          'mobile': userRegister.mobile,//user.username,
          'email': userRegister.email,
          'password': userRegister.password,
          'firstname': userRegister.firstname,
          'lastname': userRegister.lastname
//          'password_confirm': user.password,
        });

    if (response.statusCode == 200) {
      env.setRegisterSuccessTrue();
      // userRegister.isRegisterSuccess=true;
      

      print(response.body);
      // If the call to the server was successful, parse the JSON.
      Fluttertoast.showToast(
          msg: 'Account Created',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          fontSize: 16.0);
      // return User.fromJson(json.decode(response.body));
//      return jsonDecode(response.body);
        var u = jsonDecode(response.body);
         u['isRegisterSuccess'] = true;
//        user.isRegisterSuccess = true;
//  auth.loading = false;
        return u;


    } else {

      if (response.statusCode == 400) {
        //  auth.loading = false;
        Fluttertoast.showToast(
            msg: response.body,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else if (response.statusCode == 500) {
        //  auth.loading = false;
        Fluttertoast.showToast(
            msg: 'Server Error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      else {
        // auth.loading = false;
         Fluttertoast.showToast(
            msg: 'Server Error',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
          return null;
      }
      // If that call was not successful, throw an error.
//      throw Exception(response.body);

      return null;
    }

    
  }

  setUser(String value) async {
    await storage.write(key: 'user', value: value);
  }

  getUser() async {
    String user = await storage.read(key: 'user');
    if (user != null) {
      return jsonDecode(user);
    }
  }
  logout() async {
    await storage.delete(key: 'user');

  }


Future<bool> CheckTokenExpiryIntersepter() async {

  final url = env.API_BASE_URL + '/api/auth/token/refresh/';
  final response = await http.post(Uri.parse(url), body: {
      'token': env.getAuthToken(null)
    });

    if (response.statusCode == 200) {
      setUser(response.body);
     auth.isTokenExpired = false;
    return false;

    }
    else {
      auth.isTokenExpired = true;
      return false;
    }

}
}
