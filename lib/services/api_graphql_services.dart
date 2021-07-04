import 'dart:convert';
import 'package:card_app/models/feedback.dart';
import 'package:card_app/models/health_facility_coordinates.dart';
import 'package:card_app/models/insuree_info.dart';
import 'package:card_app/models/insuree_policy_information.dart';
import 'package:card_app/models/notices.dart';
import 'package:card_app/models/notifications.dart';
import 'package:card_app/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/claimeditems.dart';
import 'package:card_app/models/claimedservices.dart';
import 'package:card_app/models/policy_information.dart';
import 'package:card_app/graphql/gql_queries.dart';
import 'package:card_app/common/env.dart' as env;
import "package:card_app/graphql/gql_mutations.dart";
import "package:card_app/mock_api/profile.dart";
class ApiGraphQlServices {
    bool isLoading = false;
    MedicalServices medicalServices = MedicalServices();
    Claims insuree_claims = Claims();
    Claimed claimed = Claimed();
    ClaimedServices claimedservices = ClaimedServices();
    ClaimedItems claimeditems = ClaimedItems();
    HealthFacilityCoordinates healthFacilityCoordinates = HealthFacilityCoordinates();
    PolicyInformation policyinformation = PolicyInformation();
    InsureePolicyInformation insureepolicyinformation = InsureePolicyInformation();
    Notice notices = Notice();
    Feedback feedback = Feedback();
    InsureeInfo insureeinfo = InsureeInfo();
    Notifications notifications = Notifications();
    Profile profile = Profile();
    
    
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
    
    Future<Claims> ClaimsServicesGQL(String token, String chfID) async {
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                    "Insuree-Token" : "${token}"
                },
                body: jsonEncode(openimisGqlQueries().openimis_gql_insuree_claims(chfID))
            
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
    
    Future<HealthFacilityCoordinates> HealthFacilityCoordinatesServicesGQL(args) async {
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                },
                body: jsonEncode(openimisGqlQueries().health_facility_coordinate(args))
            );
            var jsonMap = json.decode(response.body);
            healthFacilityCoordinates = HealthFacilityCoordinates.fromJson(jsonMap);
        } catch (Exception) {
            return  healthFacilityCoordinates;
        }
        return healthFacilityCoordinates;
    }
    
    Future<PolicyInformation> PolicyInformationServicesGQL(String token, chfid) async { //todo pass claim id from widget // this is for the homepage
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                    "Insuree-Token" : "${token}"
                },
                body: jsonEncode(openimisGqlQueries()
                    .openimis_gql_insuree_policy_information(chfid)) //todo map qs filtering
            );
            var jsonMap = json.decode(response.body);
            print(openimisGqlQueries().openimis_gql_insuree_policy_information(chfid));

            policyinformation = PolicyInformation.fromJson(jsonMap);
        } catch (Exception) {
            return  policyinformation;//claimeditems;
        }
        return policyinformation;
    }
    
    
    Future<InsureePolicyInformation> InsureePolicyInformationServicesGQL(String token, chfid) async { //todo pass claim id from widget // this is for the list of policies of insuree
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                    "Insuree-Token": "${token}"
                },
                body: jsonEncode(openimisGqlQueries().openimis_insuree_policy_information_lists(chfid)) //todo map qs filtering
            );
            var jsonMap = json.decode(response.body);
            insureepolicyinformation = InsureePolicyInformation.fromJson(jsonMap);
            print(insureepolicyinformation);
            
        } catch (Exception) {
            return  insureepolicyinformation;//claimeditems;
        }
        return insureepolicyinformation;
    }
    
    Future<Notice> NoticesServicesGQL(String token) async {
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                     "Insuree-Token": '${token}'
                },
                body: jsonEncode(openimisGqlQueries().openimis_gql_notices())
            );
            var jsonMap = json.decode(response.body);
            notices = Notice.fromJson(jsonMap);
        } catch (Exception) {
            return  notices;
        }
        return notices;
    }

    Future<InsureeInfo> InsureeInfoServicesGQL(String token, String chfid) async {
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                    "Insuree-Token": '${token}'
                },
                body: jsonEncode(openimisGqlQueries().openimis_gql_insuree_info(chfid))
            );
            var jsonMap = json.decode(response.body);
            insureeinfo = InsureeInfo.fromJson(jsonMap);
        } catch (Exception) {
            return  insureeinfo;
        }
        return insureeinfo;
    }


    Future<Notifications> NotificationsServicesGQL(String token, String chfid) async {
        try {
            final response = await http.post(Uri.parse(env.API_BASE_URL),
                headers: {
                    "Content-Type": "application/json",
                    "Insuree-Token": '${token}'
                },
                body: jsonEncode(openimisGqlQueries().openimis_gql_notifications(chfid))
            );
            var jsonMap = json.decode(response.body);
            notifications = Notifications.fromJson(jsonMap);
        } catch (Exception) {
            return  notifications;
        }
        return notifications;
    }



  //mutation
    Future<Map>  createFeedback(fullname, email, mobile_number, queries) async {
        var jsonmap;
        try {
               final response = await http.post(Uri.parse(env.API_BASE_URL),
                   headers: {
                       "Content-Type": "application/json",
                   },
                   body: jsonEncode(
                       openimisGQLMutation().createFeedbackMutation(
                           fullname, email, mobile_number, queries))

               );
               jsonmap = jsonDecode(response.body);
           } catch (Exception)
            {
               return null;
           }
        return jsonmap ;
    }



  Future<Profile>  getProfileInformation(String chfid) async {
    var jsonmap;
    try {
      final response = await http.post(Uri.parse(env.API_BASE_URL),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              openimisGqlQueries().openimis_gql_profile(chfid))
      );
      jsonmap = jsonDecode(response.body);
      profile =  Profile.fromJson(jsonmap);
    } catch (Exception)

      {

        return profile;

    }
    return profile;
  }
    
}
