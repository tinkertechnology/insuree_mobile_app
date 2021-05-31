// import 'dart:convert';
// import 'package:ff_navigation_bar/ff_navigation_bar.dart';
// import 'package:card_app/blocks/auth_block.dart';
// import 'package:card_app/common/env.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:card_app/common/env.dart' as env;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'dart:io';

// class RegisterPage extends StatefulWidget {
// 	@override
// 	_RegisterPageState createState() => _RegisterPageState();

// }

// class _RegisterPageState extends State<RegisterPage> {
// 	String mobile = "";
// 	String firstname = "";
// 	String lastname = "";
// 	String location = "";
// 	String message="";
// 	String email="";
// 	var _textController = TextEditingController();
// 	String order_latitude = "";
// 	String order_longitude = "";
// 	bool isApiLoaded = false;
// 	String isSelected;
// 	bool isLoading = false;


// 	void _customerResistrationSurvey() async {
// 		if(mounted)
// 			setState(() {
// 			  isLoading = true;
// 			});

// 		var url = env.API_BASE_URL+'/api/CustomerRegisterSurvey/';
// 		final response = await http.post(url,
// 			headers: <String, String>{
// 				'Content-Type': 'application/json; charset=UTF-8',
// //        'Authorization': 'JWT ' + auth.user['token'],
// 			},
// 			body: jsonEncode(<String, String>{
// 				"mobile": mobile.toString(),
// 				"firstname": firstname.toString(),
// 				"lastname": lastname.toString(),
// 				"location":location.toString(),
// 				"know_about_us": isSelected.toString(),
// 				"email": email.toString(),
// 				"other": _textController.text.toString()
// 			}),

// 		);
// 		if (response.statusCode == 200) {
// 			print(response.body);
// 			if(mounted)
// 				setState(() {
// 				  isLoading=false;
// 				});
// 			Fluttertoast.showToast(
// //          msg: e.toString(),
// 				msg: 'Thanks for filling the form, verify your mobile now',
// 				toastLength: Toast.LENGTH_LONG,
// 				gravity: ToastGravity.BOTTOM,
// 				//timeInSecForIosWeb: 1,
// 				timeInSecForIos: 1,
// 				backgroundColor: Colors.grey,
// 				textColor: Colors.white,
// 				fontSize: 16.0
// 			);
// 			Navigator.popAndPushNamed(context, '/signup_mobile', arguments:
// 			mobile
// 			);
// 		}

// 		else {

// 			Fluttertoast.showToast(
// //          msg: e.toString(),
// 				msg: response.body,
// 				toastLength: Toast.LENGTH_LONG,
// 				gravity: ToastGravity.TOP,

// 				//timeInSecForIosWeb: 1,
// 				timeInSecForIos: 1,
// 				backgroundColor: Colors.red,
// 				textColor: Colors.white,
// 				fontSize: 16.0
// 			);
// 			if(mounted)
// 			setState(() {
// 			  isLoading = false;
// 			});
// 		}
// 	}

// 	List<dynamic> stores = [
// 		{
// 			"id": 1,
// 			"is_active": 1,
// 			"title": "No Store Available",
// 			"latitude": "1.0000000000000000",
// 			"longitude": "1.0000000000000000",
// 			"fk_user": 3
// 		}
// 	];

// 	final Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
// 	Position _currentPosition;


// 	_getCurrentLocation() {
// 		geolocator
// 			.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
// 			.then((Position position) {
// 			setState(() {
// 				_currentPosition = position;
// 				if(_currentPosition!=null) {
// 					order_latitude = _currentPosition.latitude.toString();
// 					order_longitude = _currentPosition.longitude.toString();
// 					print(order_latitude);
// 					print(order_longitude);
// 					//obtainStores();
// 				}
// 			});

// 			//_getAddressFromLatLng();
// 		}).catchError((e) {
// 			print(e);
// 		});
// 	}

// 	void obtainStores() async {
// 		_getCurrentLocation();
// 		// no user id saved at auth
// 		try {
// 			//var path = //'/api/store/';
// 			var url = env.API_BASE_URL + '/api/store/?ulat='+_currentPosition.latitude.toString()+'&ulng='+_currentPosition.longitude.toString()+'&r=2&get_nearest=true';
// 			http.Response response = await http.get(
// 				url,
// //                    headers: <String, String>{
// //                        'Content-Type': 'application/json; charset=UTF-8',
// //                        'Authorization': 'JWT ' + en,
// //                    }
// 			);
// 			print(response.body);
// 			if (response.statusCode >= 200 && response.statusCode <= 210) {
// 				//showToast('Response received');
// 				var jsonResponse = json.decode(response.body);
// 				if(this.mounted) {
// 					setState(() {
// 						stores = jsonResponse['results'];
// 						isApiLoaded = true;
// 					});
// 				}
// 			}
// 			if (response.statusCode == null || response.statusCode==500) {
// 				//showToast('Internal Server Error');
// 			}
// 		} on SocketException catch (e) {
// 			print(e);
// 			//showToast('Failed Internet Connection');
// 		}

// 	}

// 	_launchURL() async {
// 		const url = 'https://sarovaraovara.com.np/our-depot';
// 		if (await canLaunch(url)) {
// 			await launch(url);
// 		} else {
// 			throw 'Could not launch $url';
// 		}
// 	}

// 	@override
// 	Widget build(BuildContext context) {
// //		final args = ModalRoute.of(context).settings.arguments;

// 		Widget _buildFirstNameTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Text(
// 						'First Name',
// 						style: TextStyle(
// 							color: Colors.black,
// 							letterSpacing: 1.5,
// 							fontSize: 18.0,
// 							fontWeight: FontWeight.w300,
// 							fontFamily: 'Futura',
// 						),
// 					),
// 					SizedBox(height: 10.0),
// 					Container(
// 						alignment: Alignment.centerLeft,
// 						height: 60.0,
// 						child: TextFormField(
// 							// initialValue: env.USER_MOBILE_NO, //await userCredential.loadSaveUserMobileNumber(null),
// 							keyboardType: TextInputType.text,
// 							validator: (value) {
// 								if (value.isEmpty) {
// 									return 'Please enter first name';
// 								}
// 								return null;
// 							},
// 							onChanged: (value) {
// 								setState(() {
// 									firstname = value;
// 								});
// 							},
// 							decoration: InputDecoration(
// 								hintText: "Enter your first name",
// 								border: OutlineInputBorder(),
// 								contentPadding: EdgeInsets.only(top: 14.0),
// 								prefixIcon: Icon(
// 									Icons.account_circle,
// 									color: Colors.black,
// 								),
// 							)
// 						),
// 					),
// 				],
// 			);
// 		}

// 		Widget _buildLastNameTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Text(
// 						'Last Name',
// 						style: TextStyle(
// 							color: Colors.black,
// 							letterSpacing: 1.5,
// 							fontSize: 18.0,
// 							fontWeight: FontWeight.w300,
// 							fontFamily: 'Futura',
// 						),
// 					),
// 					SizedBox(height: 10.0),
// 					Container(
// 						alignment: Alignment.centerLeft,
// 						height: 60.0,
// 						child: TextFormField(
// 							// initialValue: env.USER_MOBILE_NO, //await userCredential.loadSaveUserMobileNumber(null),
// 							keyboardType: TextInputType.text,
// 							validator: (value) {
// 								if (value.isEmpty) {
// 									return 'Please enter last name';
// 								}
// 								return null;
// 							},
// 							onChanged: (value) {
// 								setState(() {
// 									lastname = value;
// 								});
// 							},
// 							decoration: InputDecoration(
// 								hintText: "Enter your last name",
// 								border: OutlineInputBorder(),
// 								contentPadding: EdgeInsets.only(top: 14.0),
// 								prefixIcon: Icon(
// 									Icons.account_circle,
// 									color: Colors.black,
// 								),
// 							)
// 						),
// 					),
// 				],
// 			);
// 		}

// 		Widget _buildMobileTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Text(
// 						'Mobile Number',
// 						style: TextStyle(
// 							color: Colors.black,
// 							letterSpacing: 1.5,
// 							fontSize: 18.0,
// 							fontWeight: FontWeight.w300,
// 							fontFamily: 'Futura',
// 						),
// 					),
// 					SizedBox(height: 10.0),
// 					Container(
// 						alignment: Alignment.centerLeft,
// 						height: 60.0,
// 						child: TextFormField(
// 							//await userCredential.loadSaveUserMobileNumber(null),
// 							keyboardType: TextInputType.number,
// 							validator: (value) {
// 								if (value.isEmpty) {
// 									return 'Please Enter mobile number';
// 								}
// 								return null;
// 							},
// 							onChanged: (value) {
// 								setState(() {
// 								mobile = value;
// 								});
// 							},
// 							decoration: InputDecoration(
// 								hintText: "Enter Mobile Number",
// 								border: OutlineInputBorder(),
// 								contentPadding: EdgeInsets.only(top: 14.0),
// 								prefixIcon: Icon(
// 									Icons.mobile_screen_share,
// 									color: Colors.black,
// 								),
// 							)
// 						),
// 					),
// 				],
// 			);
// 		}

// 		Widget _buildLocationTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Text(
// 						'Location',
// 						style: TextStyle(
// 							color: Colors.black,
// 							letterSpacing: 1.5,
// 							fontSize: 18.0,
// 							fontWeight: FontWeight.w300,
// 							fontFamily: 'Futura',
// 						),
// 					),
// 					SizedBox(height: 10.0),
// 					Container(
// 						alignment: Alignment.centerLeft,
// 						height: 60.0,
// 						child: TextFormField(
// 							// initialValue: env.USER_MOBILE_NO, //await userCredential.loadSaveUserMobileNumber(null),
// 							keyboardType: TextInputType.text,
// 							validator: (value) {
// 								if (value.isEmpty) {
// 									return 'Please enter your address';
// 								}
// 								return null;
// 							},
// 							onChanged: (value) {
// 								setState(() {
// 									location = value;
// 								});
// 							},
// 							decoration: InputDecoration(
// 								hintText: "Enter currrent address",
// 								border: OutlineInputBorder(),
// 								contentPadding: EdgeInsets.only(top: 14.0),
// 								prefixIcon: Icon(
// 									Icons.map,
// 									color: Colors.black,
// 								),
// 							)
// 						),
// 					),
// 				],
// 			);
// 		}

// 		Widget _buildEmailTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Text(
// 						'Email',
// 						style: TextStyle(
// 							color: Colors.black,
// 							letterSpacing: 1.5,
// 							fontSize: 18.0,
// 							fontWeight: FontWeight.w300,
// 							fontFamily: 'Futura',
// 						),
// 					),
// 					SizedBox(height: 10.0),
// 					Container(
// 						alignment: Alignment.centerLeft,
// 						height: 60.0,
// 						child: TextFormField(
// 							// initialValue: env.USER_MOBILE_NO, //await userCredential.loadSaveUserMobileNumber(null),
// 								keyboardType: TextInputType.emailAddress,
// 								validator: (value) {
// 									if (value.isEmpty) {
// 										return 'Please enter your Email';
// 									}
// 									return null;
// 								},
// 								onChanged: (value) {
// 									setState(() {
// 										email = value;
// 									});
// 								},
// 								decoration: InputDecoration(
// 									hintText: "Enter Email address",
// 									border: OutlineInputBorder(),
// 									contentPadding: EdgeInsets.only(top: 14.0),
// 									prefixIcon: Icon(
// 										Icons.email,
// 										color: Colors.black,
// 									),
// 								)
// 						),
// 					),
// 				],
// 			);
// 		}

// 		Widget _buildAboutUsTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Container(
// 						child: Text(
// 							'How did you know about us',
// 							style: TextStyle(
// 								color: Colors.black,
// 								letterSpacing: 1.5,
// 								fontSize: 18.0,
// 								fontWeight: FontWeight.w300,
// 								fontFamily: 'Futura',
// 							),
// 						),
// 					),

// 					/*DropdownButton(
// 						isExpanded: true,
// 						hint: Text(
// 							'How did you know about us ? ',
// 							style: TextStyle(
// 								fontSize: 16,
// 								fontFamily: 'Futura',
// 								fontWeight: FontWeight.w500
// 							),
// 						), // Not necessarovaray for Option 1
// 						items: stores.map((item) {
// 							if(true){
// 								print(item);
// 							}
// 							return new DropdownMenuItem(
// 								child: new Text(item['title']), value: item['id'].toString());
// 						}).toList(),
// 						onChanged: (newVal) {
// 							setState(() {
// 								// storeSelected = newVal;
// 							});
// 							print(newVal);
// 						},
// 						// value: storeSelected != null ? storeSelected.toString() : null,

// 					),*/

// 					DropdownButton<String>(
// 						isExpanded: true,
// 						hint: Text(
// 							'How did you know about us ? ',
// 							style: TextStyle(
// 								fontSize: 16,
// 								fontFamily: 'Futura',
// 								fontWeight: FontWeight.w500
// 							),
// 						),
// 						items: <String>['From Flex', 'Facebook', 'Twitter', 'Instagram',  'Google', 'Other'].map((String value) {
// 							return new DropdownMenuItem<String>(
// 								value: value,
// 								child: new Text(value),
// 							);
// 						}).toList(),
// 						onChanged: (newVal) {
// 							setState(() {
// 								isSelected = newVal;
// 								print(isSelected);
// 							});
// 						},
// 						value : isSelected//isSelected
// 					),
// 				],
// 			);
// 		}

// 		Widget _buildMessageTF() {
// 			return Column(
// 				crossAxisAlignment: CrossAxisAlignment.start,
// 				children: <Widget>[
// 					Text(
// 						'Message',
// 						style: TextStyle(
// 							color: Colors.black,
// 							letterSpacing: 1.5,
// 							fontSize: 18.0,
// 							fontWeight: FontWeight.w300,
// 							fontFamily: 'Futura',
// 						),
// 					),
// 					SizedBox(height: 10.0),
// 					Padding(
// 						padding: EdgeInsets.all(0.0),
// 						child: Column(
// 							children: <Widget>[
// 								// SizedBox(height: 10.0),
// 								Container(
// 									// alignment: Alignment.centerLeft,
// 									// height: 60.0,
// 									child: TextFormField(
// 										controller: _textController,
// 										keyboardType: TextInputType.multiline,
// 										maxLines: 3,
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
// 				],
// 			);
// 		}

// 		Widget _buildRegisterBtnTF() {
// 			return RaisedButton(
// 				elevation: 5.0,
// 				child: Text(
// 					'Submit',
// 					style: TextStyle(
// 						color: Colors.white,
// 						letterSpacing: 1.5,
// 						fontSize: 18.0,
// 						fontWeight: FontWeight.bold,
// 						fontFamily: 'Futura',
// 					),
// 				),
// 				onPressed: () {
// 					_customerResistrationSurvey();
// 					// Validate form
// //								Navigator.pushNamed(context, '/verify_mobile');
// 				},
// 				padding: EdgeInsets.all(15.0),
// 				color: Color.fromRGBO(0, 153, 182, 50),
// 			);
// 		}

// 		if(isApiLoaded==false){
// 			obtainStores();
// 		}
// 		return Scaffold(
// 			appBar: AppBar(
// 				backgroundColor: Color.fromRGBO(0, 153, 182, 50),
// 				title: Text(
// 					'Pre-Register',
// 					style: TextStyle(
// 						fontSize: 20,
// 						fontFamily: 'Futura',
// 						fontWeight: FontWeight.w500,
// 						color: Colors.white,
// 					),
// 				),
// 			),
// 			backgroundColor: Colors.white,
// 			body: isLoading ? Container(child: Center(child: CircularProgressIndicator()))
// 					:SingleChildScrollView(
// 				child:  Container(
// 					child: Column(
// 						children: <Widget>[
// 							/*SizedBox(height: 10.0),
//                         Image.asset('assets/images/sarovaraovara_logo.png'),*/
// 							// SizedBox(height: 10.0),
// 							Container(
// 								padding: EdgeInsets.all(15.0),
// 								child: Column(
// 									children: <Widget>[
// 										_buildFirstNameTF(),
// 										SizedBox(height: 10.0),
// 										_buildLastNameTF(),
// 										SizedBox(height: 10.0),
// 										_buildMobileTF(),
// 										SizedBox(height: 10.0),
// 										_buildEmailTF(),
// 										SizedBox(height: 10.0),
// 										_buildLocationTF(),
// 										SizedBox(height: 10.0),
// 										_buildAboutUsTF(),
// 										SizedBox(height: 10.0),
// 										/*_buildMessageTF(),
// 										SizedBox(height: 10.0),*/
// 										_buildRegisterBtnTF()
// 									],
// 								),
// 							),
// 						],
// 					),
// 				),
// 			),

// 			// BOTTOM NAVIGATION BAR
// 			bottomNavigationBar: FFNavigationBar(
// 				theme: FFNavigationBarTheme(
// 					barBackgroundColor: Colors.white,
// 					selectedItemBackgroundColor: Color.fromRGBO(0, 153, 182, 50),
// 					selectedItemIconColor: Colors.white,
// 					selectedItemLabelColor: Colors.black,
// 				),
// 				selectedIndex: 3,
// 				onSelectTab: (index){
// 					switch(index) {
// 						case 0:
// 							Navigator.pop(context);
// 							Navigator.pushNamed(context, '/');
// 							break;
// 						case 1:
// 							Navigator.pushNamed(context, '/worldlist');
// 							break;
// 						case 2:
// 							Navigator.pushNamed(context, '/cart');
// 							break;
// 						case 3:
// 							auth.isLoggedIn ? Navigator.pushNamed(context, '/profile') :  Navigator.pushNamed(context, '/auth');
// 							break;
// 					}
// 				},
// 				items: [
// 					FFNavigationBarItem(
// 						iconData: Icons.home,
// 						label: 'Home',
// 					),
// 					FFNavigationBarItem(
// 						iconData: Icons.card_giftcard,
// 						label: 'Products',
// 					),
// 					FFNavigationBarItem(
// 						iconData: Icons.shopping_cart,
// 						label: 'Cart',
// 					),
// 					FFNavigationBarItem(
// 						iconData: auth.isLoggedIn ? Icons.person : Icons.account_circle ,
// 						label: auth.isLoggedIn ? 'Profile' : 'Account',
// 					),
// 				],
// 			),
// 		);
// 		// TODO: implement build
// 	}
// }