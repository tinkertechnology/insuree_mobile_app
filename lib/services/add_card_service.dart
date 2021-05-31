import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:card_app/models/affiliate.dart';
import 'package:card_app/models/card.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/services/auth_service.dart';



AuthService auth;
Future<List<Post>> fetchAllAffiliates() async {  //this api fetches lists of affiliates
final String url = env.API_BASE_URL+ '/affiliate/api/AffiliatesListAPIView/';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    final result = json.decode(response.body);

    List<Post> posts =
        result.map<Post>((model) => new Post.fromJson(model)).toList();
    return posts;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future RetriveLinkedCard(linkedId) async {  //Retrive User Linked Card details like qr code, barcode , name etc.
final String url = env.API_BASE_URL+ '/api/card/LinkedCardRetriveAPIView/'+ linkedId.toString() + '/';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    final result = json.decode(response.body);
    var carddetails = CardDetail.fromJson(result);
    return carddetails;

     //var card =result.map<Card>((model) => new Card.fromJson(model));
    // return result;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}


