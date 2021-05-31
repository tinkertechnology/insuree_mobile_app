// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:card_app/models/user.dart';
// import 'package:card_app/blocks/auth_block.dart';
// import 'package:provider/provider.dart';
// import  'package:card_app/common/env.dart' as env;
// import 'package:http/http.dart' as http;

// class SignupMobile extends StatefulWidget {
//     @override
//     _SignupMobileState createState() => _SignupMobileState();
// }

// class _SignupMobileState extends State<SignupMobile> {
//     final _formKey = GlobalKey<FormState>();
//     User user = User();
//     String confirmPassword;
//     bool localRegisterSuccess=false;
//     bool isLoading = true;
//     String mobile;
//     bool isApiLoaded = false;

//     void getInfo() async {
//         print('fetch data');
//         // CommonToast.ToastSuccess('API Clicked');
// //    var category_url = Url + '/api/categories';
//         var path = env.API_BASE_URL+'/api/CustomerSurveryInfo/?mobile='+ mobile;
//         final response = await http.get(
//             path,
//             headers: <String, String>{
//                 'Content-Type': 'application/json; charset=UTF-8',
//                // 'Authorization': 'JWT ' + env.getAuthToken(null) //auth.user['token'],
//             },
//         );
//         if (response.statusCode == 200) {

//             print(response.body);

// //            CommonToast.ToastSuccess('StatusCode200 Clicked');
//             if(mounted)
//             setState(() {
//                 // products = (json.decode(response.body) as List);
//                 // print(products);
//                 var json = jsonDecode(response.body).cast<dynamic, dynamic>();
//                 user.firstname = json['firstname'];
//                 user.lastname = json['lastname'];
//                 user.email = json['email'];
//                 isApiLoaded = true;
//                 isLoading = false;

//                 // products = api_products;
//             });
//             // var list = (json.decode(response.body) as List)
//             // .map((data) => new Photo.fromJson(data))
//             //.toList();
//             //print(list);


//         } else {
//             setState(() {
//                 isLoading = false;
//             });
//             throw Exception('Failed to load photos');
//         }

//     }


//     void setRegister(arg){
//         localRegisterSuccess = arg;
//         if(arg==true){
//             env.setRegisterSuccessTrue();
//         }
//         else {
//             env.setRegisterSuccessFalse();
//         }
//     }


//     @override
//     Widget build(BuildContext context) {
//         final args = ModalRoute.of(context).settings.arguments;
//         if(args!=null){
//             if(mounted)
//                 setState(() {
//                   mobile = args;
//                 });

//         }
//         if(isApiLoaded==false){
//             getInfo();
//         }
//         Widget _buildMobileTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Mobile Number',
//                         style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'futura',
//                             letterSpacing: 1.5,
//                             color: Colors.white,
//                         ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             enabled: true,
//                             initialValue: args,
//                             validator: (value) {
//                                 if (value.isEmpty) {
//                                     return 'Please enter your mobile number';
//                                 }
//                                 return null;
//                             },
//                             onSaved: (value) {
//                                 setState(() {
//                                     user.username = value;
//                                 });
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter Mobile Number",
//                                 hintStyle: TextStyle(color: Colors.white54),
//                                 border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Colors.white,
//                                     ),
//                                 ),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.mobile_screen_share,
//                                     color: Colors.white54,
//                                 ),
//                             )
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildEmailTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Email Address',
//                         style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'futura',
//                             letterSpacing: 1.5,
//                             color: Colors.white,
//                         ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             initialValue: user.email,
//                             keyboardType: TextInputType.emailAddress,
//                             enabled: true,
//                             validator: (value) {
// //                                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
// //                                RegExp regex = new RegExp(pattern);
//                                 if (value.isEmpty) {
//                                     return 'Please enter your email address';
//                                 }
//                                 return null;
//                             },
//                             onSaved: (value) {
//                                 setState(() {
//                                     user.email = value;
//                                 });
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter Email Address",
//                                 hintStyle: TextStyle(color: Colors.white54),
//                                 border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Colors.yellow,
//                                     ),
//                                 ),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.email,
//                                     color: Colors.white54,
//                                 ),
//                             )
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildFirstNameTF(){
//         return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//                 Text(
//                     'First Name',
//                     style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.w300,
//                         fontFamily: 'futura',
//                         letterSpacing: 1.5,
//                         color: Colors.white,
//                     ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Container(
//                     alignment: Alignment.centerLeft,
//                     height: 60.0,
//                     child: TextFormField(
//                         initialValue: user.firstname,
//                         keyboardType: TextInputType.text,
//                         enabled: true,
//                         validator: (value) {
// //                                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
// //                                RegExp regex = new RegExp(pattern);
//                             if (value.isEmpty) {
//                                 return 'Enter your firstname';
//                             }
//                             return null;
//                         },
//                         onSaved: (value) {
//                             setState(() {
//                                 user.firstname = value;
//                             });
//                         },
//                         decoration: InputDecoration(
//                             hintText: "Enter First Name",
//                             hintStyle: TextStyle(color: Colors.white54),
//                             border: OutlineInputBorder(),
//                             contentPadding: EdgeInsets.only(top: 14.0),
//                             prefixIcon: Icon(
//                                 Icons.account_circle,
//                                 color: Colors.white54,
//                             ),
//                         )
//                     ),
//                 ),
//             ],
//         );
//     }
//         Widget _buildLastNameTF(){
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Last Name',
//                         style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'futura',
//                             letterSpacing: 1.5,
//                             color: Colors.white,
//                         ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             initialValue: user.lastname,
//                             keyboardType: TextInputType.text,
//                             enabled: true,
//                             validator: (value) {
// //                                Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
// //                                RegExp regex = new RegExp(pattern);
//                                 if (value.isEmpty) {
//                                     return 'Enter your lastname';
//                                 }
//                                 return null;
//                             },
//                             onSaved: (value) {
//                                 setState(() {
//                                     user.lastname = value;
//                                 });
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter Last Name",
//                                 hintStyle: TextStyle(color: Colors.white54),
//                                 border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.account_circle,
//                                     color: Colors.white54,
//                                 ),
//                             )
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildPasswordTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Password',
//                         style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'futura',
//                             letterSpacing: 1.5,
//                             color: Colors.white,
//                         ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             validator: (value) {
//                                 if (value.isEmpty) {
//                                     return 'Please enter password';
//                                 }
//                                 return null;
//                             },
//                             onSaved: (value) {
//                                 setState(() {
//                                     user.password = value;
//                                 });
//                             },
//                             onChanged: (text) {
//                                 user.password = text;
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter Password",
//                                 hintStyle: TextStyle(color: Colors.white54),
//                                 border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.lock,
//                                     color: Colors.white54,
//                                 ),
//                             ),
//                             obscureText: true,
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildConfirmPasswordTF() {
//             return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                     Text(
//                         'Confirm Password',
//                         style: TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w300,
//                             fontFamily: 'futura',
//                             letterSpacing: 1.5,
//                             color: Colors.white,
//                         ),
//                     ),
//                     SizedBox(height: 5.0),
//                     Container(
//                         alignment: Alignment.centerLeft,
//                         height: 60.0,
//                         child: TextFormField(
//                             validator: (value) {
//                                 if (value.isEmpty) {
//                                     return 'Please enter same password';
//                                 }
//                                 else if(user.password != confirmPassword){
//                                     return 'Password fields do not match';
//                                 }
//                                 else if(user.password.length < 8){
//                                     return 'Password must be 8 character long';
//                                 }
//                                 return null;
//                             },
//                             onChanged: (text) {
//                                 confirmPassword = text;
//                             },
//                             decoration: InputDecoration(
//                                 hintText: "Enter Confirm Password",
//                                 hintStyle: TextStyle(color: Colors.white54),
//                                 border: OutlineInputBorder(),
//                                 contentPadding: EdgeInsets.only(top: 14.0),
//                                 prefixIcon: Icon(
//                                     Icons.lock,
//                                     color: Colors.white54,
//                                 ),
//                             ),
//                             obscureText: true,
//                         ),
//                     ),
//                 ],
//             );
//         }

//         Widget _buildRegisterBtn() {
//             return Container(
//                 padding: EdgeInsets.symmetric(vertical: 25.0),
//                 width: double.infinity,
//                 child: Consumer<AuthBlock>(
//                     builder: (BuildContext context, AuthBlock auth, Widget child){
//                         return RaisedButton(
//                             elevation: 5.0,
//                             child: auth.loading && auth.loadingType == 'register' ? CircularProgressIndicator(
//                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ) : Text(
//                                 'Register',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     letterSpacing: 1.5,
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Futura',
//                                 ),
//                             ),
//                             onPressed: () async {
//                                 // Validate form
//                                 if (_formKey.currentState.validate() && !auth.loading) {
//                                     // Update values
//                                     _formKey.currentState.save();
//                                     // Hit Api
//                                     auth.register(user);
//                                     Timer.periodic(Duration(milliseconds: 500), (timer) async{
//                                         print(DateTime.now());
//                                         if(env.getRegisterSuccess()) {
//                                             localRegisterSuccess = true;
//                                             timer.cancel();
//                                             print('vako');
//                                             UserCredential userCredential = UserCredential();
//                                             userCredential.usernameOrEmail = user.username;
//                                             userCredential.password = user.password;
//                                             var login = await auth.login(userCredential);
//                                             Timer.periodic(Duration(milliseconds: 500), (timer) {
//                                                 print(DateTime.now());
//                                                 print('signup_otp');
//                                                 if(auth.isLoggedIn){
//                                                     timer.cancel();
//                                                     Navigator.pushNamed(context, '/');
//                                                 }
//                                                 timer.cancel();
//                                             });
// //                                            Navigator.pushNamed(context, '/auth');
//                                            // Navigator.pushNamed(context, '/');
//                                         }
//                                     });
//                                 }
//                             },
//                             padding: EdgeInsets.all(15.0),
// //                            shape: RoundedRectangleBorder(
// //                                borderRadius: BorderRadius.circular(30.0),
// //                            ),
//                             color: Color.fromRGBO(0, 153, 182, 50),
//                         );
//                     },
//                 ),
//             );
//         }

//         return Scaffold(
//             appBar: new AppBar(
//                 elevation: 0.0,
//                 backgroundColor: Color.fromRGBO(0, 153, 182, 50),
//                 title: Text(
//                     'Register',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: 'Futura',
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                     ),
//                 ),
//             ),

//             body: Stack(
//                 children: <Widget>[
//                     Container(
//                         height: double.infinity,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: Color.fromRGBO(1, 153, 182, 50),
//                         ),
//                     ),

//                     Container(
//                         height: double.infinity,
//                         child: SingleChildScrollView(
//                             physics: AlwaysScrollableScrollPhysics(),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 40.0,
//                                 vertical: 0.0,
//                             ),

//                             child: isLoading ? Container(child: Center(child: CircularProgressIndicator())):Form(
//                                 key: _formKey,
//                                 child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                         /*Padding(
//                                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                                             child: Text(
//                                                 'Card'.toUpperCase(),
//                                                 style: TextStyle(
//                                                     fontSize: 40,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Futura',
//                                                     letterSpacing: 2.0,
//                                                     color: Color.fromRGBO(0, 153, 182, 50)
//                                                 ),
//                                                 textAlign: TextAlign.center,
//                                             ),
//                                         ),*/


//                                         Center(
//                                             child: Text(
//                                                 'Welcome to sarovaraovara',
//                                                 style: TextStyle(
//                                                     fontSize: 24,
//                                                     fontFamily: 'Futura',
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                     letterSpacing: .3
//                                                 ),
//                                             ),
//                                         ),

//                                         SizedBox(height: 15),

//                                         _buildMobileTF(),
//                                         _buildFirstNameTF(),
//                                         _buildLastNameTF(),
//                                         _buildEmailTF(),
//                                         _buildPasswordTF(),
//                                         _buildConfirmPasswordTF(),
//                                         _buildRegisterBtn(),
//                                     ],
//                                 ),
//                             ),
//                         ),
//                     ),
//                 ],
//             ),
//         );
//     }
// }
