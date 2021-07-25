import 'package:flutter/material.dart';
import 'package:openimis_web_app/models/user.dart';
import 'dart:ui';
import 'dart:async';
import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:provider/provider.dart';
class RegisterScreen extends StatefulWidget {
	@override
	_RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
	final _formKey = GlobalKey<FormState>();
	final UserRegister userRegister = UserRegister();
	AuthBlock auth;
	
	final double circleRadius =100.0;
	final double circleBorderWidth = 8.0;
	bool _checkbox = false;
	@override
	Widget build(BuildContext context) {
		Size deviceSize = MediaQuery.of(context).size;
		auth = Provider.of<AuthBlock>(context);
		return Scaffold(
			backgroundColor: Color.fromRGBO(234, 239, 255, 30),
			body: Container(
				height: MediaQuery.of(context).size.height,
				child: Column(
					children: <Widget>[
						Container(
							padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 20.0, bottom: 20.0),
							margin: EdgeInsets.only(top: 20),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									IconButton(
										icon: Icon(Icons.clear, size: 30),
										onPressed: (){
											Navigator.pop(context);
										},
									),
									SizedBox(
										child: Row(
											children: <Widget>[
												Text(
													"Already have an account?",
													style: TextStyle(
														fontSize: 14,
														fontWeight: FontWeight.w400,
														fontFamily: "Open-sans"
													),
												),
												SizedBox(width: 4.0),
												GestureDetector(
													onTap: (){
														Navigator.pushNamed(context, '/reset-password');
													},
													child: Text(
														"Sign In",
														style: TextStyle(
															fontSize: 14,
															fontWeight: FontWeight.bold,
															fontFamily: "Open-sans",
															color: Colors.yellow.withBlue(4)
														),
													),
												),
											],
										),
									)
								],
							),
						),
						
						Expanded(
							child: Form(
								key: _formKey,
								child: Stack(
									alignment: Alignment.topCenter,
									children: <Widget>[
										Padding(
											padding: EdgeInsets.only(top: circleRadius/2.0),
											child: Container(
												decoration: BoxDecoration(
													color: Colors.white,
													borderRadius: BorderRadius.only(
														topLeft: Radius.circular(40),
														topRight: Radius.circular(40),
													),
												),
											),
										),
										
										SingleChildScrollView(
											physics: NeverScrollableScrollPhysics(),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.center,
												children: <Widget>[
													Container(
														width: circleRadius,
														height: circleRadius,
														decoration: ShapeDecoration(
															shape: CircleBorder(),
															color: Colors.white
														),
														child: Padding(
															padding: EdgeInsets.all(circleBorderWidth),
															child: DecoratedBox(
																decoration: ShapeDecoration(
																	shape: CircleBorder(),
																	image: DecorationImage(
																		fit: BoxFit.cover,
																		image: NetworkImage('https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png',)
																	)
																),
															),
														),
													),
													
													SizedBox(height: 16.0),
													ListTile(
														title: Text(
															"Getting Started",
															style: TextStyle(
																fontSize: 24,
																fontWeight: FontWeight.w400
															),
															textAlign: TextAlign.center,
														),
														subtitle: Text(
															"Create an account to continue!",
															style: TextStyle(
																fontSize: 16,
																fontWeight: FontWeight.w300,
																color: Colors.grey
															),
															textAlign: TextAlign.center,
														),
													),
													
													// PHONE NUMBER CONTAINER
													SizedBox(height: 16.0),
													
													// FULL NAME
													Container(
														padding: EdgeInsets.symmetric(horizontal: 20.0),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															mainAxisSize: MainAxisSize.min,
															children: <Widget>[
																Text(
																	"Full Name",
																	style: TextStyle(
																		fontSize: 16,
																		fontWeight: FontWeight.w400,
																		fontFamily: "Open-sans",
																		color: Colors.grey
																	),
																),
																SizedBox(height: 8.0),
																TextFormField(
																	keyboardType: TextInputType.text,
																	validator: (value) {
																		if (value.isEmpty) {
																			return 'Please enter full name';
																		}
																		return null;
																	},
																	onSaved: (value) {
																		setState(() {
																			// userCredential.usernameOrEmail = value;
																		});
																	},
																	decoration: InputDecoration(
																		border: OutlineInputBorder(
																			borderRadius: BorderRadius.all(
																				Radius.circular(10.0)
																			),
																			borderSide: BorderSide(
																				color: Colors.white,
																			)
																		),
																		
																		hintText: 'Full Name',
																		hintStyle: TextStyle(
																			fontFamily: 'Open-sans'
																		),
																		filled: true,
																		contentPadding: EdgeInsets.all(16.0),
																		prefixIcon: Icon(Icons.person_outline),
																	),
																),
															],
														),
													),
													
													// PHONE NUMBER
													SizedBox(height: 20.0),
													Container(
														padding: EdgeInsets.symmetric(horizontal: 20.0),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															mainAxisSize: MainAxisSize.min,
															children: <Widget>[
																Text(
																	"Phone Number",
																	style: TextStyle(
																		fontSize: 16,
																		fontWeight: FontWeight.w400,
																		fontFamily: "Open-sans",
																		color: Colors.grey
																	),
																),
																SizedBox(height: 8.0),
																TextFormField(
																	keyboardType: TextInputType.emailAddress,
																	validator: (value) {
																		if (value.isEmpty) {
																			return 'Please Enter mobile number';
																		}
																		return null;
																	},
																	onSaved: (value) {
																		setState(() {
																			// userCredential.usernameOrEmail = value;
																		});
																	},
																	decoration: InputDecoration(
																		border: OutlineInputBorder(
																			borderRadius: BorderRadius.all(
																				Radius.circular(10.0)
																			),
																			borderSide: BorderSide(
																				color: Colors.white,
																			)
																		),
																		
																		hintText: 'Mobile or Email',
																		hintStyle: TextStyle(
																			fontFamily: 'Montserrat'
																		),
																		filled: true,
																		contentPadding: EdgeInsets.all(16.0),
																		prefixIcon: Icon(Icons.person_outline),
																	),
																),
															],
														),
													),
													
													// PASSWORD CONTAINER
													Container(
														padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															mainAxisSize: MainAxisSize.min,
															children: <Widget>[
																Text(
																	"Password",
																	style: TextStyle(
																		fontSize: 16,
																		fontWeight: FontWeight.w400,
																		fontFamily: "Open-sans",
																		color: Colors.grey
																	),
																),
																SizedBox(height: 8.0),
																TextFormField(
																	validator: (value) {
																		if (value.isEmpty) {
																			return 'Please enter password';
																		}
																		return null;
																	},
																	onSaved: (value) {
																		setState(() {
																			// userCredential.password = value;
																		});
																	},
																	decoration: InputDecoration(
																		hintText: 'Password',
																		border: OutlineInputBorder(
																			borderRadius: BorderRadius.all(
																				Radius.circular(10.0)
																			)
																		),
																		hintStyle: TextStyle(
																			fontFamily: 'Montserrat'
																		),
																		filled: true,
																		contentPadding: EdgeInsets.all(16.0),
																		prefixIcon: Icon(Icons.lock_outline)
																	),
																	keyboardType: TextInputType.text,
																	obscureText: true,
																),
															],
														)
													),
													
													// TERMS AND CONDITIONS
													Container(
														padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
														child: Row(
															mainAxisAlignment: MainAxisAlignment.start,
															children: <Widget>[
																Checkbox(
																	value: _checkbox,
																	onChanged: (value) {
																		setState(() {
																			_checkbox = true;
																		});
																	},
																),
																Expanded(
																	child: Text(
																		"By creating an account, you agree to our Terms and Conditions."
																	),
																)
															],
														),
													),
													
													// SIGN UP BUTTON
													Container(
														padding: EdgeInsets.fromLTRB(20, 8, 20, 10),
														width: double.infinity,
														child: Consumer<AuthBlock>(
															builder: (BuildContext context, AuthBlock auth, Widget child){
																return RaisedButton(
																	onPressed: () async {
																		// Validate form
																		if (_formKey.currentState.validate() &&  !auth.loading) {
																			_formKey.currentState.save();
																			// Hit Api
																			var register = await auth.register(userRegister);
																			Timer.periodic(Duration(milliseconds: 500), (timer) {
																				print(DateTime.now());
																				print('sign in');
																				if(auth.isRegisterSuccess==true){
																					Navigator.popAndPushNamed(context, '/otp-verify');
																				}
																				timer.cancel();
																			});
																		}
																	},
																	padding: EdgeInsets.all(16.0),
																	shape: RoundedRectangleBorder(
																		borderRadius: BorderRadius.all(Radius.circular(10.0)),
																	),
																	color: Color.fromRGBO(254, 196, 45, 50),
																	child: auth.loading && auth.loadingType == 'register'
																		? CircularProgressIndicator(
																		valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
																		: Text(
																		"Sign Up".toUpperCase(),
																		style: TextStyle(
																			fontSize: 16.0,
																			fontWeight: FontWeight.w400,
																			fontFamily: "Open-sans"
																		),
																	),
																);
															}
														),
													),
												],
											),
										)
									],
								),
							),
						)
					],
				),
			)
		);
	}
}