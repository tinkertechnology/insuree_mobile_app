# Insuree_APP

This application is intended for insuree's profile based on openIMIS project

# Basic usage
clone openimis_be_py from openimis github as base django application.
clone this  repository (https://github.com/tinkertechnology/openimis_web_app) 
and install it in your pip package manager as an app.
 pip install -e "location to the webapp or app"


##Configuration to run the application
create env.dart (not .env) in project inside common directory if it does not exists and configure as below.
     library env;
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
     

     
     String API_BASE_LOCAL_URL =  "localhost url for testing /api/graphql";
     String OFFICE_LIST_URL = "List of Insuree Organization branches";
     String FAQ_LIST_URL = "Faq list url";
     String API_HIB_URL = 'production live url/api/graphql'; 
     
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
     
     
     
     String Currency = "Npr."; //set your country currency
     
     





## file upload curl request example in graphql from flutter (insuree images)
Multipart file upload for graphql api
curl -X POST http://localhost:8000/api/graphql \
     -H 'content-type: multipart/form-data; boundary=----GraphQlFileUpload' \
     -F 'query=mutation {createVoucherPayment(file: "file"){   ok  }  }' \
     -F 'file=@selfie.jpg'



