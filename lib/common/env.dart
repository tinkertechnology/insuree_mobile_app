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







String API_BASE_LOCAL_URL =  "http://imistest.hib.gov.np/api/graphql"; //"http://10.0.2.2/api/graphql";//"http://imistest.hib.gov.np/api/graphql";//"https://oi.tinker.com.np/api/graphql";
String OFFICE_LIST_URL = "";
String FAQ_LIST_URL = "";
String API_HIB_URL = 'http://imistest.hib.gov.np/api/graphql';

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




