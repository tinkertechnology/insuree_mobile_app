import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import  'package:card_app/common/env.dart' as env;

final storage = FlutterSecureStorage();
// Create storage
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


Future getToken(token) async {
  final response = await http.post(Uri.parse(env.API_REFRESH_TOKEN),

      headers: <String, String>{

        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ' + token,

      },

      body: jsonEncode(<String, String>{
        'token': token,
//        'quantity': _itemCount.toString(),

      }),


      );

  print(response);


  if (response.statusCode == 200) {
//      print("success");
    print(response);

    // If the call to the server was successful, parse the JSON.
    // return User.fromJson(json.decode(response.body));


    //return true;

    return jsonDecode(response.body);
  }
  else {
//     that call was not successful, throw an error.
//      throw Exception(response.body);
    return jsonDecode(response.body);
  }
}