library env;
//import  'package:openimis_web_app/common/env.dart' as env;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

bool registerSuccess = false;
int ExpiryDate = 60;

setRegisterSuccessFalse(){
	registerSuccess = false;
}

setRegisterSuccessTrue(){
	registerSuccess = true;
}

getRegisterSuccess(){
	return registerSuccess;
}

getAuthToken(AuthBlock auth1){
	if(auth1==null){
		auth1=auth;
	}
	if(auth1.isLoggedIn){
		print(auth1);
		return auth1.user['token'];
	}
	return "isLoggedIn=false";
}

AuthBlock auth;

setAuth(AuthBlock ab){
	auth =ab;
}

getAuth(){
	if(auth!=null){
		if(auth.isLoggedIn==false){
			return null;
		}
	}
	return auth;
}


String CHFID;

setCHFID(String s){
	CHFID =s;
}
getCHFID(){
	return CHFID;
}



String FirebaseToken;

setFirebaseToken(token){
	FirebaseToken = token;
}

getFirebaseToken(){

	return FirebaseToken;
}


SaveUpdateFirebaseToken() async {
	var url = API_BASE_URL+'/api/SaveUpdateFirebaseToken/';
	http.Response response = await http.post(
		Uri.parse(url),
		headers: <String, String>{
			'Content-Type': 'application/json; charset=UTF-8',
			'Authorization': 'JWT ' + getAuthToken(null),
			//'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozLCJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsInVzZXJuYW1lIjoicm9vdCIsImV4cCI6MTU4ODkwNjY4OSwib3JpZ19pYXQiOjE1ODg4NzY2ODl9.pmXxw9p10Jzfkx0auWglaarDGG0fnEqgC'//
		},
		body: jsonEncode(<String, String>{
			'firebase_token': getFirebaseToken(),
		}),
	);
	print(response.body);
	if (response.statusCode == 200) {
	}

}



bool hasAuthUserObject(){
	var _auth = getAuth();
	if(_auth!=null){
		if(auth.user!=null){
			return true;
		}
	}
	return false;
}


String API_BASE_LOCAL_URL =  "http://imistest.hib.gov.np/api/graphql"; //"http://10.0.2.2/api/graphql";//"http://imistest.hib.gov.np/api/graphql";//"https://oi.tinker.com.np/api/graphql";
String API_IOS_BASE_LOCAL_URL = "http://localhost:8000/api/graphql";
String API_BASE_LOCAL_MOBILE_URL = "http://192.168.31.221:8000/api/graphql";
String OFFICE_LIST_URL = "https://ag.gov.np/dag1/offices.json";
String FAQ_LIST_URL = "https://ag.gov.np/dag1/faqs.json";
String API_HIB_URL = 'https://imistest.hib.gov.np/api/graphql';

String getBaseUrl(){
	if (kReleaseMode) {
		return API_HIB_URL;
	} else {
	}

	if (Platform.isAndroid) {
		return API_HIB_URL;
	} else if (Platform.isIOS) {
		return API_HIB_URL;
	}
}

String API_BASE_URL =  getBaseUrl();



String Currency = "Npr.";




