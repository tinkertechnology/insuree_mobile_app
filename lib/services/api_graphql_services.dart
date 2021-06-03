import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/claimeditems.dart';
import 'package:card_app/models/claimedservices.dart';
import 'package:card_app/graphql/gql_queries.dart';
import 'package:card_app/common/env.dart' as env;

class ApiGraphQlServices {
  bool isLoading = false;
  MedicalServices medicalServices = MedicalServices();
  Claims insuree_claims = Claims();
  Claimed claimed = Claimed();
//  ClaimedServicesItems claimedServicesItems = ClaimedServicesItems();
  ClaimedServices claimedservices = ClaimedServices();
  ClaimedItems claimeditems = ClaimedItems();


  Future<MedicalServices> MedicalServicesGQL(String args) async {
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
//                "Accept" : "application/json"
          },
          body: jsonEncode(openimisGqlQueries()
              .openimis_gql_medical_services(5)) //todo map qs filtering
          );
      var jsonMap = json.decode(response.body);
      medicalServices = MedicalServices.fromJson(jsonMap);
    } catch (Exception) {
      return medicalServices;
    }
    return medicalServices;
  }

  Future<Claims> ClaimsServicesGQL() async {
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
                "Accept" : "application/json"
          },
          body: jsonEncode(openimisGqlQueries().openimis_gql_insuree_claims(1))

          );
        var jsonMap = response.body;
        insuree_claims = Claims.fromJson(jsonDecode(jsonMap));
    } catch (Exception) {
      return insuree_claims;
    }
    return insuree_claims;
  }


//  Future<Claimed> ClaimedServicesGQL() async {
//    try {
//      final response = await http.post(Uri.parse(env.API_BASE_URL),
//          headers: {
//            "Content-Type": "application/json",
////                "Accept" : "application/json"
//          },
//          body: jsonEncode(openimisGqlQueries()
//              .openimis_gql_individual_claimed_item_services(1)) //todo map qs filtering
//      );
//      var jsonMap = json.decode(response.body);
//      claimed = Claimed.fromJson(jsonMap);
//    } catch (Exception) {
//      return claimed;
//    }
//    return claimed;
//  }
//

//  Future<ClaimedServicesItems> ClaimedServicesItemsServicesGQL(int claimid) async { //todo pass claim id from widget
//    try {
//      final response = await http.post(Uri.parse(env.API_BASE_URL),
//          headers: {
//            "Content-Type": "application/json",
////                "Accept" : "application/json"
//          },
//          body: jsonEncode(openimisGqlQueries()
//              .openimis_gql_individual_claimed_item_services(claimid)) //todo map qs filtering
//      );
//      var jsonMap = json.decode(response.body);
//      claimedServicesItems = ClaimedServicesItems.fromJson(jsonMap);
//    } catch (Exception) {
//      return claimedServicesItems;
//    }
//    return claimedServicesItems;
//  }
 // Services api
  Future<ClaimedServices> ClaimedServicesServicesGQL(int claimid) async { //todo pass claim id from widget
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
//                "Accept" : "application/json"
          },
          body: jsonEncode(openimisGqlQueries()
              .openimis_gql_insuree_claimed_services(claimid)) //todo map qs filtering
      );
      var jsonMap = json.decode(response.body);
      claimedservices = ClaimedServices.fromJson(jsonMap);
    } catch (Exception) {
      return claimedservices;
    }
    return claimedservices;
  }

  Future<ClaimedItems> ClaimedItemServicesGQL(int claimid) async { //todo pass claim id from widget
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
//                "Accept" : "application/json"
          },
          body: jsonEncode(openimisGqlQueries()
              .openimis_gql_insuree_claimed_items(claimid)) //todo map qs filtering
      );
      var jsonMap = json.decode(response.body);
      claimeditems = ClaimedItems.fromJson(jsonMap);


    } catch (Exception) {
      return  claimeditems;//claimeditems;
    }
    return claimeditems;
  }
}
