import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/graphql/gql_queries.dart';
import 'package:card_app/common/env.dart' as env;

class ApiGraphQlServices {


bool isLoading = false;
MedicalServices medicalServices = MedicalServices();
Edge edge = Edge();

Future<MedicalServices> MedicalServicesGQL(String args) async {
  try {
    final response = await http.post(
        Uri.parse(env.API_BASE_URL),
        headers: {
          "Content-Type": "application/json",
//                "Accept" : "application/json"
        },
        body:
        jsonEncode(openimisGqlQueries().openimis_gql_medical_services(80)) //todo map qs filtering
    );
    var jsonMap = json.decode(response.body);
    medicalServices = MedicalServices.fromJson(jsonMap);
  }
  catch (Exception) {
    return medicalServices;
  }
  return medicalServices;
}}
