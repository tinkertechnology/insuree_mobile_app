import 'package:card_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/models/affiliate.dart';
import 'dart:async';
import 'dart:convert';
import 'package:card_app/models/affiliate.dart';
import 'package:card_app/common/env.dart' as env;
//  import 'constants.dart';
class Services1 {
  //
  static const String url =  'http://10.0.2.2:8000/affiliate/api/AffiliatesListAPIView/'; //'http://jsonplaceholder.typicode.com/users';
  Affiliate affiliate;
  static Future<Affiliate> getAffiliates() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        final affiliate = affiliateFromJson(response.body);
        return affiliate;
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }
}



 
class Services {
  static Future<List<AffliateModel>> fetchHomeData() async {
    final url = env.API_BASE_URL +'/affiliate/api/AffiliatesListAPIView/';
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        List<AffliateModel> list = parsePostsForHome(response.body);
        return list;
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception('error');
    }
  }
 
  static List<AffliateModel> parsePostsForHome(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<AffliateModel>((json) => AffliateModel.fromJson(json)).toList();
  }
}