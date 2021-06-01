import 'dart:convert';
import 'package:card_app/models/insuree.dart';
import 'package:http/http.dart' as http;
class VerifyInsureeService {
bool isLoading=false;

  Future<Map> VerifyInsureeData(Insuree _verifyInsuree) async {
    isLoading = true;
    final response = await http.post(Uri.parse('http://10.0.2.2:8000/api/graphql'),
        headers: {
          "Content-Type": "application/json",
//                "Accept" : "application/json"
        },
        body:
        jsonEncode({"query":"\n\nquery {\n "
            " insureeAuth(insureeCHFID: \"${_verifyInsuree.chfid.toString()}\", familyHeadCHFID: \""
            "${_verifyInsuree.fhchfid.toString()}\", dob:\"${_verifyInsuree.dob}\"){\n    id\n  }\n}","variables":null}));
    print(jsonDecode(response.body));
    print('tara baji lai lai');
      isLoading=false;
      var jdr = jsonDecode(response.body);
      return jdr['data']['insureeAuth'];
    }

  }



