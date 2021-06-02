class openimisGqlQueries{

  openimis_gql_medical_services(first) {
    var qs;
     first>0 ? qs = "medicalServicesStr(first:$first)" : "medicalServicesStr";
    return
      {
        "query": "query {\n  ${qs} {\n  edges{\n    node{\n     "
            " id\n      name\n    }\n  }\n    \n  }\n}",
        "variables": null
      };
  }

  openimis_gql_insuree_claims(){ //pass insureeCHFID
    return
      {"query":"query{\n"
          "  insureeProfile(insureeCHFID: 1){\n"
          "    insureeClaim{\n"
          "      id\n"
          "      dateClaimed\n"
          "      claimed\n"
          "      healthFacility{\n"
          "        name\n"
          "      }\n"
          "    }\n"
          "  }\n"
          "}","variables":null};

  }


  openimis_gql_individual_claimed_item_services(claimed_id) {
    return
      {"query":"query{\n  insureeClaim(claimId: ${claimed_id}){\n"
          "    services{"
          "\n      id\n      "
          "service{"
          "\n       "
          " id\n        "
          "name\n      }\n    }\n    "
          "items{\n      "
          "id\n      "
          "item{\n        "
          "id\n       "
          " name\n      }\n    }\n  }\n}","variables":null};
  }

}
