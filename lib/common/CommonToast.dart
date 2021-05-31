library toast;
// import 'common/CommonToast.dart' as CommonToast;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Toast names similar to bootstrap
void ToastDanger(argMessage){
  Fluttertoast.showToast(
//          msg: e.toString(),
      //msg: 'Please set your state address first to confirm order.',
      msg: argMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,

      //timeInSecForIosWeb: 1,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void ToastSuccess(argMessage){
  Fluttertoast.showToast(
//          msg: e.toString(),
    //msg: 'Please set your state address first to confirm order.',
      msg: argMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,

      //timeInSecForIosWeb: 1,
      timeInSecForIos: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
