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
        "query":"query{\n  insureeClaim(claimId: ${claimed_id}){\n   \n    services{\n      id\n      service{\n        id\n        name\n        price\n      }\n    }\n  }\n}","variables":null
      };
  }

  openimis_gql_insuree_claimed_items(claimed_id) {
    return

      {
        "query": "query{\n  insureeClaim(claimId: ${claimed_id}){\n   \n    items{\n      id\n      item{\n        id\n        name\n        price\n      }\n    }\n  }\n}",
        "variables": null
      };
  }
}
