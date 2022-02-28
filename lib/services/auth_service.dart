import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:openimis_web_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openimis_web_app/blocks/auth_block.dart';
import  'package:openimis_web_app/common/env.dart' as env;
import 'package:openimis_web_app/graphql/gql_queries.dart';

class AuthService {

  AuthBlock auth;
  final storage = FlutterSecureStorage();
  // Create storage
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  Future<Map> login(UserCredential userCredential) async {
    var q = openimisGqlQueries().otp_verify({"chfid":"${userCredential.chfid}", "otp": "${userCredential.otp}" });
    final response = await http.post(Uri.parse(env.API_BASE_URL),
        headers: {
          "Content-Type": "application/json",
        },
        body:
        jsonEncode(q));
    print(jsonDecode(response.body));


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
        var u = jsonDecode(response.body);
         u['isRegisterSuccess'] = true;
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


}
