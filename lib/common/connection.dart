// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class CheckConnection extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return _CheckConnection();
//   }
// }

// class _CheckConnection extends State<CheckConnection>{
//   StreamSubscription<ConnectivityResult> internetconnection;
//   bool isoffline = false;
//   //set variable for Connectivity subscription listiner

//   @override
//   void initState() {
//     internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       // whenevery connection status is changed.
//       if(result == ConnectivityResult.none){
//         //there is no any connection
//         setState(() {
//           isoffline = true;
//         });
//       }else if(result == ConnectivityResult.mobile){
//         //connection is mobile data network
//         setState(() {
//           isoffline = false;
//         });
//       }else if(result == ConnectivityResult.wifi){
//         //connection is from wifi
//         setState(() {
//           isoffline = false;
//         });
//       }
//     }); // using this listiner, you can get the medium of connection as well.

//     super.initState();
//   }

//   @override
//   dispose() {
//     super.dispose();
//     internetconnection.cancel();
//     //cancel internent connection subscription after you are done
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title:Text("Check Connection")),
//         body:SingleChildScrollView(
//             child: Column(children: <Widget>[

//               Container(
//                 child: errmsg("No Internet Connection Available", isoffline),
//                 //to show internet connection message on isoffline = true.
//               ),

//               Container(
//                 //this is your content
//                   margin: EdgeInsets.all(30),
//                   width:double.infinity,
//                   child: Center(
//                       child:Text("Check Connections",
//                           style:TextStyle(fontSize:20)
//                       )
//                   )
//               )

//             ],)
//         )
//     );
//   }

//   Widget errmsg(String text,bool show){
//     //error message widget.
//     if(show == true){
//       //if error is true then show error message box
//       return Container(
//         padding: EdgeInsets.all(10.00),
//         margin: EdgeInsets.only(bottom: 10.00),
//         color: Colors.red,
//         child: Row(children: <Widget>[

//           Container(
//             margin: EdgeInsets.only(right:6.00),
//             child: Icon(Icons.info, color: Colors.white),
//           ), // icon for error message

//           Text(text, style: TextStyle(color: Colors.white)),
//           //show error message text
//         ]),
//       );
//     }else{
//       return Container();
//       //if error is false, return empty container.
//     }
//   }

// }