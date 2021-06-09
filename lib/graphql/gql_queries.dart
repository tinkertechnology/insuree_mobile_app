import 'dart:convert';

class openimisGqlQueries {

  openimis_gql_medical_services(first) {
    var qs;
    first > 0 ? qs = "medicalServicesStr(first:$first)" : "medicalServicesStr";
    return
      {
        "query": "query {\n  ${qs} {\n  edges{\n    node{\n     "
            " id\n      name\n    }\n  }\n    \n  }\n}",
        "variables": null
      };
  }

  openimis_gql_insuree_claims(insuree_chfid) {
    //pass insureeCHFID
    return
      {
        "query": "query{\n  insureeProfile(insureeCHFID: ${insuree_chfid}){\n    insureeClaim{\n"
            "      id\n      dateClaimed\n      claimed\n      healthFacility{\n        name\n      }\n    }\n  }\n}",
        "variables": null
      };
  }


  openimis_gql_insuree_claimed_services(claimed_id) {
    return

      //"query":"query{\n  insureeClaim(claimId: ${claimed_id}){\n   \n    services{\n      id\n      service{\n        id\n        name\n      }\n    }\n  }\n}","variables":null
      {
        "query": "query{\n  insureeClaim(claimId: ${claimed_id}){\n   \n    services{\n      id\n      service{\n        id\n        name\n        price\n      }\n    }\n  }\n}",
        "variables": null
      };
  }

  openimis_gql_insuree_claimed_items(claimed_id) {
    return

      {
        "query": "query{\n  insureeClaim(claimId: ${claimed_id}){\n   \n    items{\n      id\n      item{\n        id\n        name\n        price\n      }\n    }\n  }\n}",
        "variables": null
      };
  }

  health_facility_coordinate(args) {
      var query="""
        query {
          healthFacilityCoordinate(inputLatitude:"1", inputLongitude:"1"){
            id,
            distance,
            healthFacility{
              id
            }
          }
        }
      """;
      var _ret= {
        "query": query, //jsonEncode(query),
        "variables": null
      };
      return _ret;
  }


  openimis_gql_insuree_policy_information(chfid) {
    return {

      "query": "query{\n  insureeProfile(insureeCHFID: ${chfid}){\n    otherNames\n    lastName\n    chfId\n    insureePolicies{\n      expiryDate\n    }\n    \n  }\n}",
      "variables": null
    };
  }

  openimis_insuree_policy_information_lists(chfid){ //for policyinformationpage
    var query = """
    query {
        insureeProfile(insureeCHFID:${chfid}){
          insureePolicies{
            policy{
              legacyId
              effectiveDate
              expiryDate
              validityFrom
              validityTo
              status
              value
            }
          }
        }
      }
   """;
    return {
      "query":"query {\n  insureeProfile(insureeCHFID:${chfid}){\n    insureePolicies{\n      policy{\n        legacyId\n        effectiveDate\n        expiryDate\n        validityFrom\n        validityTo\n        status\n        value\n      }\n    }\n  }\n}","variables":null
    };
  }

}

