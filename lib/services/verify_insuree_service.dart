import 'dart:convert';
import 'package:card_app/models/insuree.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/common/env.dart' as env;
class VerifyInsureeService {
bool isLoading=false;

  Future<Map> VerifyInsureeData(Insuree _verifyInsuree) async {
    isLoading = true;
    final response = await http.post(Uri.parse(env.API_BASE_URL),
        headers: {
          "Content-Type": "application/json",
//                "Accept" : "application/json"
        },
        body:
        jsonEncode({"query":"\n\nquery {\n "
            " insureeAuth(insureeCHFID: \"${_verifyInsuree.chfid.toString()}\", familyHeadCHFID: \""
            "${_verifyInsuree.fhchfid.toString()}\", dob:\"${_verifyInsuree.dob}\"){\n    id\n  }\n}","variables":null}));
    print(jsonDecode(response.body));
      isLoading=false;
      var jdr = jsonDecode(response.body);
      return jdr['data']['insureeAuth'];
    }

  }



