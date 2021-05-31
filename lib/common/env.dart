library env;
//import  'package:card_app/common/env.dart' as env;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:card_app/blocks/auth_block.dart';
import 'package:flutter/foundation.dart';
import 'package:card_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

bool registerSuccess = false;

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
		print('updated');
		// If the server did return a 201 CREATED response,
		// then parse the JSON.
		// return Album.fromJson(json.decode(response.body));

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


bool isWaterSupplyUser() {
	var ret = false;
	var _auth = getAuth();
	if (_auth!=null)
	{
		if (auth.isLoggedIn) {
			if (_auth.user != null) {
				var _value = _auth.user['is_supply_company'];
				if (_value != null) {
					if (_value == true) {
						ret = true;
					}
				}
			}
		}

	}

	return ret;

}

bool isDeliveryPerson() {
	var ret = false;
	var _auth = getAuth();
	if (_auth!=null)
	{
		if(_auth.user!=null) {
			if (auth.isLoggedIn) {
				var _value = _auth.user['is_delivery_user'];
				if (_value != null) {
					if (_value == true) {
						ret = true;
					}
				}
			}
		}
	}

	return ret;

}

bool isDepoUser() {
	var ret = false;
	var a = getAuth();
	if (a!=null)
	{
		if (auth.isLoggedIn) {
			var v = a.user['is_depo'];
			if (v != null) {
				if (v == true) {
					ret = true;
				}
			}
		}

	}

	return ret;

}

bool isDepo;


String USER_MOBILE_NO = "";




String API_BASE_LOCAL_URL = "http://10.0.2.2:8000";
String API_IOS_BASE_LOCAL_URL = "http://localhost:8000";
String API_BASE_LOCAL_MOBILE_URL = "http://192.168.31.221:8000";
String API_INLINETECH_URL = 'https://cardapp.inlinetech.com.np';


String getBaseUrl(){
	if (kReleaseMode) {
		return API_INLINETECH_URL;
	} else {
	}

	if (Platform.isAndroid) {
		return API_BASE_LOCAL_URL;
	} else if (Platform.isIOS) {
		return API_IOS_BASE_LOCAL_URL;
	}
}

String API_BASE_URL =  API_BASE_LOCAL_URL;//API_BASE_LOCAL_MOBILE_URL;//getBaseUrl();
String API_LOGIN_URL = API_BASE_URL+"/api/auth/token/";
String API_REFRESH_TOKEN = API_BASE_URL + '/api/auth/token/refresh/';



//http://localhost:8000/api/store_orders/
String API_VALIDATE_MOBILE = API_BASE_URL + '/api/validate_mobile/';
String API_VALIDATE_OTP = API_BASE_URL + '/api/validate_otp/';
String API_REGISTER_AFTER_OTP_VERIFICATION = API_BASE_URL+ '/api/register/';
String API_RESET_PASSWORD_PHONE = API_BASE_URL + '/api/reset_password/';
String API_CHANGE_PASSWORD = API_BASE_URL + '/api/change_password/';






