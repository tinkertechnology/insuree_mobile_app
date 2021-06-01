class openimisGqlQueries{

  openimis_gql_medical_services(first) {
    var qs;
     first>0 ? qs = "medicalServicesStr(first:$first)" : "medicalServicesStr";
    return
      {
        "query": "query {\n  ${qs} {\n  edges{\n    node{\n      id\n      name\n    }\n  }\n    \n  }\n}",
        "variables": null
      };
  }
}