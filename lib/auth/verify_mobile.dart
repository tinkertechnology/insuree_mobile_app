// import 'dart:convert';
// import 'package:ff_navigation_bar/ff_navigation_bar.dart';
// import 'package:openimis_web_app/common/env.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:openimis_web_app/common/env.dart' as env;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'dart:io';

// class VerifyMobilePage extends StatefulWidget {
//     @override
//     _VerifyMobilePageState createState() => _VerifyMobilePageState();

// }

// class _VerifyMobilePageState extends State<VerifyMobilePage> {
//     String mobile;
//     String fullName = "";
//     String location = "";
//     String message="";
//     String order_latitude = "";
//     String order_longitude = "";
//     bool isApiLoaded = false;
//     bool isLoading = false;
//     var _textController = TextEditingController();
//     void _verifyMobileNumber() async {
// //    var category_url = Url + '/api/categories';

//         var cartOrderUrl = env.API_VALIDATE_MOBILE;
//         final response = await http.post(cartOrderUrl,

//             headers: <String, String>{

//                 'Content-Type': 'application/json; charset=UTF-8',
// //        'Authorization': 'JWT ' + auth.user['token'],

//             },

//             body: jsonEncode(<String, String>{
//                 "mobile": mobile,

//             }),

//         );
//         if (response.statusCode == 200) {
//             print(response.body);

//             Fluttertoast.showToast(
// //          msg: e.toString(),
//                 msg: 'OTP code sent',
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,

//                 //timeInSecForIosWeb: 1,
//                 timeInSecForIos: 1,
//                 backgroundColor: Colors.green,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );
//             Navigator.pushNamed(context, '/verify_otp', arguments:
//             mobile
//             );
//         }

//         else if (response.statusCode == 400) {
//             print(response.body);

//             Fluttertoast.showToast(
// //          msg: e.toString(),
//                 msg: response.body,
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.TOP,

//                 //timeInSecForIosWeb: 1,
//                 timeInSecForIos: 1,
//                 backgroundColor: Colors.red,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );
//         }




//         else {

//             Fluttertoast.showToast(
// //          msg: e.toString(),
//                 msg: response.body,
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.TOP,

//                 //timeInSecForIosWeb: 1,
//                 timeInSecForIos: 1,
//                 backgroundColor: Colors.red,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );

//         }


//     }


//     void _customerDepotRequest() async {
//         if(mounted) {
//             setState(() {
//                 isLoading = true;
//             });
//         }
//         var url = env.API_BASE_URL+'/api/CustomerMessageForDepot/';
//         final response = await http.post(url,
//             headers: <String, String>{
//                 'Content-Type': 'application/json; charset=UTF-8',
// //        'Authorization': 'JWT ' + auth.user['token'],
//             },
//             body: jsonEncode(<String, String>{
//                 "mobile": mobile.toString(),
//                 "name": fullName.toString(),
//                 "location":location.toString(),
//                 "message": _textController.text.toString()
//             }),

//         );
//         if (response.statusCode == 200) {
//             if(mounted) {
//                 setState(() {
//                     isLoading = false;
//                 });
//             }
//             print(response.body);
//             Fluttertoast.showToast(
// //          msg: e.toString(),
//                 msg: 'Thanks for filling the form, we shall reach you soon',
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 //timeInSecForIosWeb: 1,
//                 timeInSecForIos: 1,
//                 backgroundColor: Colors.grey,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );
//             Navigator.popAndPushNamed(context, '/', arguments:
//             mobile
//             );
//         }

//         else {

//             Fluttertoast.showToast(
// //          msg: e.toString(),
//                 msg: response.body,
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.TOP,

//                 //timeInSecForIosWeb: 1,
//                 timeInSecForIos: 1,
//                 backgroundColor: Colors.red,
//                 textColor: Colors.white,
//                 fontSize: 16.0
//             );
//             if(mounted)
//                 setState(() {
//                 isLoading=false;
//             });
//         }
//     }

//     List<dynamic> stores = [
//         {
//             "id": 1,
//             "is_active": 1,
//             "title": "No Store Available",
//             "latitude": "1.0000000000000000",
//             "longitude": "1.0000000000000000",
//             "fk_user": 3
//         }
//     ];

//     final Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
//     Position _currentPosition;


//     _getCurrentLocation() {
//         geolocator
//             .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
//             .then((Position position) {
//             setState(() {
//                 _currentPosition = position;
//                 if(_currentPosition!=null) {
//                     order_latitude = _currentPosition.latitude.toString();
//                     order_longitude = _currentPosition.longitude.toString();
//                     print(order_latitude);
//                     print(order_longitude);
//                     //obtainStores();
//                 }
//             });

//             //_getAddressFromLatLng();
//         }).catchError((e) {
//             print(e);
//         });
//     }

//     void obtainStores() async {
//         _getCurrentLocation();
//         // no user id saved at auth
//             try {
//                 //var path = //'/api/store/';
//                 var url = env.API_BASE_URL + '/api/store/?ulat='+_currentPosition.latitude.toString()+'&ulng='+_currentPosition.longitude.toString()+'&r=2&get_nearest=true';
//                 http.Response response = await http.get(
//                     url,
// //                    headers: <String, String>{
// //                        'Content-Type': 'application/json; charset=UTF-8',
// //                        'Authorization': 'JWT ' + en,
// //                    }
//                 );
//                 print(response.body);
//                 if (response.statusCode >= 200 && response.statusCode <= 210) {
//                     //showToast('Response received');
//                     var jsonResponse = json.decode(response.body);
//                     if(this.mounted) {
//                         setState(() {
//                             stores = jsonResponse['results'];
//                             isApiLoaded = true;
//                         });
//                     }
//                 }
//                 if (response.statusCode == null || response.statusCode==500) {
//                     //showToast('Internal Server Error');
//                 }
//             } on SocketException catch (e) {
//                 print(e);
//                 //showToast('Failed Internet Connection');
//         }

//     }

//     _launchURL() async {
//         const url = 'https://sarovaraovara.com.np/our-depot';
//         if (await canLaunch(url)) {
//             await launch(url);
//         } else {
//             throw 'Could not launch $url';
//         }
//     }

//     @override
//     Widget build(BuildContext context) {
//         final args = ModalRoute.of(context).settings.arguments;

//         setState(() {
//           mobile = args;
//         });

//         Widget _buildNameTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Full Name',
//                         style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 1.5,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Futura',
//                         ),
//                     ),
//                     SizedBox(height: 10.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             // initialValue: env.USER_MOBILE_NO, //await userCredential.loadSaveUserMobileNumber(null),
//                             keyboardType: TextInputType.emailAddress,
//                             validator: (value) {
//                                 if (value.isEmpty) {
//                                     return 'Please enter full name';
//                                 }
//                                 return null;
//                             },
//                             onChanged: (value) {
//                                 setState(() {
//                                     fullName = value;
//                                 });
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter your full name",
//                                 border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.account_circle,
//                                     color: Colors.black,
//                                 ),
//                             )
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildMobileTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Mobile Number',
//                         style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 1.5,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Futura',
//                         ),
//                     ),
//                     SizedBox(height: 10.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             initialValue: mobile,
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                                 if (value.isEmpty) {
//                                     return 'Please Enter mobile number';
//                                 }
//                                 return null;
//                             },
//                             onChanged: (value) {
//                                 if(mounted)
//                                 setState(() {
//                                     mobile=value;
//                                 });
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter Mobile Number",
//                                 border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.mobile_screen_share,
//                                     color: Colors.black,
//                                 ),
//                             )
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildLocationTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Location',
//                         style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 1.5,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Futura',
//                         ),
//                     ),
//                     SizedBox(height: 10.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             // initialValue: env.USER_MOBILE_NO, //await userCredential.loadSaveUserMobileNumber(null),
//                             keyboardType: TextInputType.text,
//                             validator: (value) {
//                                 if (value.isEmpty) {
//                                     return 'Please enter your address';
//                                 }
//                                 return null;
//                             },
//                             onChanged: (value) {
//                                 setState(() {
//                                     location = value;
//                                 });
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter currrent address",
//                                 border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.map,
//                                     color: Colors.black,
//                                 ),
//                             )
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildMessageTF() {
//             /*return Column(
//                 children: <Widget>[
//                     Text(
//                         'Message',
//                         style: TextStyle(
//                             color: Colors.black,
//                             //letterSpacing: 1.5,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Futura',
//                         ),
//                         textAlign: TextAlign.left,
//                     ),
//                     SizedBox(height: 10.0),
//                     Padding(
//                         padding: EdgeInsets.all(15.0),
//                         child: Column(
//                             children: <Widget>[
//                                 // SizedBox(height: 10.0),
//                                 Container(
//                                     // alignment: Alignment.centerLeft,
//                                     // height: 60.0,
//                                     child: TextFormField(
//                                         keyboardType: TextInputType.multiline,
//                                         maxLines: 5,
//                                         maxLength: 500,
//                                         decoration: InputDecoration(
//                                             hintText: "Write a message to us",
//                                             border: OutlineInputBorder(),
//                                             contentPadding: EdgeInsets.all(15.0),
//                                         ),
//                                         // obscureText: true,
//                                     ),
//                                 ),
//                             ],
//                         ),
//                     ),

//                     RaisedButton(
//                         // elevation: 5.0,
//                         child: Text(
//                             'Send Message',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 1.5,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Futura',
//                             ),
//                         ),
//                         onPressed: (){},
//                         padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//                         color: Color.fromRGBO(1, 153, 182, 50),
//                     )
//                 ],
//             );*/
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Message',
//                         style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 1.5,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'Futura',
//                         ),
//                     ),
//                     SizedBox(height: 10.0),
// 					Padding(
// 						padding: EdgeInsets.all(0.0),
// 						child: Column(
// 							children: <Widget>[
// 								// SizedBox(height: 10.0),
// 								Container(
// 									// alignment: Alignment.centerLeft,
// 									// height: 60.0,
// 									child: TextFormField(
//                       controller: _textController,
// 										keyboardType: TextInputType.multiline,
// 										maxLines: 5,
// 										maxLength: 500,
// 										decoration: InputDecoration(
// 											hintText: "Write a message to us",
// 											border: OutlineInputBorder(),
// 											contentPadding: EdgeInsets.all(15.0),
// 										),
// 										// obscureText: true,
// 									),
// 								),
// 							],
// 						),
// 					),
//                 ],
//             );
//         }

//         Widget _buildSendMessageBtnTF() {
//             return Container(
//                 padding: EdgeInsets.symmetric(vertical: 25.0),
//                 width: double.infinity,
//                 child: RaisedButton(
//                     elevation: 5.0,
//                     child: Text(
//                         'Send Message',
//                         style: TextStyle(
//                             color: Colors.white,
//                             letterSpacing: 1.5,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Futura',
//                         ),
//                     ),
//                     onPressed: () {
//                         _customerDepotRequest();
//                     },
//                     padding: EdgeInsets.all(15.0),
//                     color: Color.fromRGBO(0, 153, 182, 50),
//                 ),
//             );
//         }

//         if(isApiLoaded==false){
//             obtainStores();
//         }
//         return Scaffold(
//             appBar: AppBar(
//                 backgroundColor: Color.fromRGBO(0, 153, 182, 50),
//                 title: Text(
//                     "Verify Mobile Number",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: 'Futura',
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                     ),
//                 ),
//             ),
//             backgroundColor: Colors.white,
//             body: SingleChildScrollView(
//                 child: stores.length<=0 ? Container(
//                     child: Column(
//                         children: <Widget>[
//                             /*SizedBox(height: 10.0),*/
//                             Image.asset('assets/images/sarovaraovara_logo.png', height: 80, width: 300,),
//                             // SizedBox(height: 10.0),
//                             Padding(
//                                 padding: EdgeInsets.all(15.0),
//                                 child: Text(
//                                     'Currently, our service is not available at your location. So, we were unable to provide OTP for the verification of your mobile number. '
//                                         'Click here [https://sarovaraovara.com.np/our-depot] to know about the service covered area by sarovaraovara. '
//                                         'We will come near to your location soon.',
//                                     style: TextStyle(
//                                         fontFamily: 'Futura',
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300
//                                     ),
//                                     textAlign: TextAlign.justify,
//                                 ),
//                             ),

//                             Padding(
//                                 padding: EdgeInsets.all(15.0),
//                                 child: Text(
//                                     'If you like to see our depot near to your location. Kindly call us by submitting below form. We will try to come near to your location as soon as possible.',
//                                     style: TextStyle(
//                                         fontFamily: 'Futura',
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w300
//                                     ),
//                                     textAlign: TextAlign.justify,
//                                 ),
//                             ),

//                            Container(
// 							   padding: EdgeInsets.all(15.0),
// 							   child: isLoading ?  Container(child: Center(child: CircularProgressIndicator()))
//                      :Column(
// 								   children: <Widget>[
// 									   _buildNameTF(),
// 									   SizedBox(height: 10.0),
//                                        _buildMobileTF(),
// 									   SizedBox(height: 10.0),
// 									   _buildLocationTF(),
// 									   SizedBox(height: 10.0),
// 									   _buildMessageTF(),
//                                        SizedBox(height: 10.0),
//                                        _buildSendMessageBtnTF()
// 								   ],
// 							   ),
// 						   ),
//                             /*SizedBox(height: 10.0),
//                             RaisedButton(
//                                 elevation: 5.0,
//                                 child: Text(
//                                     'Send Message',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         letterSpacing: 1.5,
//                                         fontSize: 18.0,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Futura',
//                                     ),
//                                 ),
//                                 onPressed: () {},
//                                 padding: EdgeInsets.all(15.0),
//                                 color: Color.fromRGBO(1, 153, 182, 50),
//                             )*/
//                         ],
//                     ),
//                 )
//                     :ListView(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     children: <Widget>[Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                             /*Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 20.0),
//                             child: Text(
//                                 'sarovaraovara'.toUpperCase(),
//                                 style: TextStyle(
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Futura',
//                                     color: Color.fromRGBO(0, 153, 182, 50)
//                                 ),
//                                 textAlign: TextAlign.center,
//                             ),
//                         ),*/

//                             const SizedBox(height: 20.0),

//                             Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 16.0, top: 20.0, right: 16.0),
//                                 child: Text("Enter your mobile number",
//                                     style: TextStyle(
//                                         fontSize: 18.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                     textAlign: TextAlign.center,),
//                             ),

//                             Padding(
//                                 padding: const EdgeInsets.only(top: 30.0),
//                                 child: Image(
//                                     image: AssetImage('assets/images/otp-icon.png'),
//                                     height: 120.0,
//                                     width: 120.0,),
//                             ),

//                             const SizedBox(height: 30),

//                             Row(
//                                 children: <Widget>[

//                                     Flexible(
//                                         child: new Container(
//                                         ),
//                                         flex: 1,
//                                     ),

//                                     Flexible(
//                                         child: new TextFormField(
//                                             textAlign: TextAlign.center,
//                                             autofocus: false,
//                                             enabled: false,
//                                             initialValue: "+977",
//                                             style: TextStyle(fontSize: 20.0, color: Colors.black),
//                                         ),
//                                         flex: 3,
//                                     ),

//                                     Flexible(
//                                         child: new Container(
//                                         ),
//                                         flex: 1,
//                                     ),

//                                     Flexible(
//                                         child: new TextFormField(
//                                             initialValue: mobile,
//                                             textAlign: TextAlign.start,
//                                             autofocus: false,
//                                             enabled: true,
//                                             keyboardType: TextInputType.number,
//                                             textInputAction: TextInputAction.done,
//                                             readOnly: true,
//                                             style: TextStyle(fontSize: 20.0, color: Colors.black),
//                                             onChanged: (text){
//                                                 setState(() {
//                                                     mobile = text;
//                                                 });

//                                             },

//                                         ),
//                                         flex: 9,
//                                     ),

//                                     Flexible(
//                                         child: new Container(
//                                         ),
//                                         flex: 1,
//                                     ),

//                                 ],
//                             ),

//                             const SizedBox(height:30),

//                             Padding(
//                                 padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
//                                 child: RaisedButton(
//                                     elevation: 5.0,
//                                     child: Text(
//                                         'GET OTP CODE',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             letterSpacing: 1.5,
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                             fontFamily: 'Futura',
//                                         ),
//                                     ),
//                                     onPressed: _verifyMobileNumber,
//                                     padding: EdgeInsets.all(15.0),
//                                     color: Color.fromRGBO(1, 153, 182, 50),
//                                 ),
//                             ),
//                         ]
//                     )],),
//             ),

//             // BOTTOM NAVIGATION BAR
//             bottomNavigationBar: FFNavigationBar(
//                 theme: FFNavigationBarTheme(
//                     barBackgroundColor: Colors.white,
//                     selectedItemBackgroundColor: Color.fromRGBO(0, 153, 182, 50),
//                     selectedItemIconColor: Colors.white,
//                     selectedItemLabelColor: Colors.black,
//                 ),
//                 selectedIndex: 3,
//                 onSelectTab: (index){
//                     switch(index) {
//                         case 0:
//                             Navigator.pop(context);
//                             Navigator.pushNamed(context, '/');
//                             break;
//                         case 1:
//                             Navigator.pushNamed(context, '/worldlist');
//                             break;
//                         case 2:
//                             Navigator.pushNamed(context, '/cart');
//                             break;
//                         case 3:
//                             auth.isLoggedIn ? Navigator.pushNamed(context, '/profile') :  Navigator.pushNamed(context, '/auth');
//                             break;
//                     }
//                 },
//                 items: [
//                     FFNavigationBarItem(
//                         iconData: Icons.home,
//                         label: 'Home',
//                     ),
//                     FFNavigationBarItem(
//                         iconData: Icons.card_giftcard,
//                         label: 'Products',
//                     ),
//                     FFNavigationBarItem(
//                         iconData: Icons.shopping_cart,
//                         label: 'Cart',
//                     ),
//                     FFNavigationBarItem(
//                         iconData: auth.isLoggedIn ? Icons.person : Icons.account_circle ,
//                         label: auth.isLoggedIn ? 'Profile' : 'Account',
//                     ),
//                 ],
//             ),
//         );
//         // TODO: implement build
//     }
// }