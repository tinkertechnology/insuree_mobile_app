import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/graphql/gql_queries.dart';
import 'package:card_app/common/env.dart' as env;

class ApiGraphQlServices {
  bool isLoading = false;
  MedicalServices medicalServices = MedicalServices();
  Claims insuree_claims = Claims();
  Claimed claimed = Claimed();

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
var requestbody = {"query":"query{\n  insureeProfile(insureeCHFID: 1){\n    insureeClaim{\n"
    "      id\n      dateClaimed\n      claimed\n      healthFacility{\n        name\n      }\n    }\n  }\n}","variables":null};
  Future<Claims> ClaimsServicesGQL() async {
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
                "Accept" : "application/json"
          },
          body: jsonEncode(requestbody)

          );
        var jsonMap = response.body;
        insuree_claims = Claims.fromJson(jsonDecode(jsonMap));
    } catch (Exception) {
      return insuree_claims;
    }
    return insuree_claims;
  }


  Future<Claimed> ClaimedServicesGQL() async {
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
//                "Accept" : "application/json"
          },
          body: jsonEncode(openimisGqlQueries()
              .openimis_gql_individual_claimed_item_services(1)) //todo map qs filtering
      );
      var jsonMap = json.decode(response.body);
      claimed = Claimed.fromJson(jsonMap);
    } catch (Exception) {
      return claimed;
    }
    return claimed;
  }
}
