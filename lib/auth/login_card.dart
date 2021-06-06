import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:flutter/services.dart';
import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import  'package:card_app/common/env.dart' as env;
import 'package:card_app/card/card_page.dart';
import 'package:card_app/models/insuree.dart';
class LoginScreen extends StatefulWidget {
	@override
	final String chfid;
	LoginScreen({Key key, @required this.chfid}): super(key: key);
	_LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

	final _formKey = GlobalKey<FormState>();
//	final UserCredential userCredential = UserCredential();
	final UserCredential _user = UserCredential();
	Widget _buildOTPField(){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 20.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						"OTP",
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
								return 'Please Enter OTP ';
							}
							return null;
						},
						onSaved: (value) {
							setState(() {
								_user.otp = value;
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

							hintText: 'OTP text',
							hintStyle: TextStyle(
									fontFamily: 'Montserrat'
							),
							filled: true,
							contentPadding: EdgeInsets.all(16.0),
							prefixIcon: Icon(Icons.dialpad),
						),
					),
				],
			),
		);
	}

	final double circleRadius =100.0;
	final double circleBorderWidth = 8.0;
	TextEditingController dateCtl = TextEditingController();

	@override
	Widget build(BuildContext context) {
		Size deviceSize = MediaQuery.of(context).size;
		return Scaffold(
				backgroundColor: CustomTheme.lightTheme.primaryColor, //Color.fromRGBO(234, 239, 255, 30),
				body: Container(
					margin: EdgeInsets.only(top: 70),
					height: MediaQuery.of(context).size.height,
					child: Column(
						children: <Widget>[
							/*Container(
								padding: EdgeInsets.all(20.0),
								margin: EdgeInsets.only(top: 30),
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
										Icon(Icons.clear, size: 30, color: Colors.white,),
										FlatButton(
											onPressed: (){
												Navigator.pushNamed(context, '/reset-password');
											},
											child: Text(
												"Forget your credentials?",
												style: TextStyle(
														fontSize: 16,
														fontWeight: FontWeight.w400,
														fontFamily: "Open-sans",
														color: Colors.white
												),
											),
										),
									],
								),
							),*/

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
												// physics: NeverScrollableScrollPhysics(),
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
																					image: AssetImage('assets/images/openimis-logo.png'),
																			)
																	),
																),
															),
														),

														SizedBox(height: 10.0),
														ListTile(
															title: Text(
																"Validate OTP",
																style: TextStyle(
																		fontSize: 24,
																		fontWeight: FontWeight.w400
																),
																textAlign: TextAlign.center,
															),
															subtitle: Text(
																"Enter the validaton code!",
																style: TextStyle(
																	fontSize: 16,
																	fontWeight: FontWeight.w300,
																	color: Colors.grey
																),
																textAlign: TextAlign.center,
															),
														),

														// PHONE NUMBER CONTAINER
														SizedBox(height: 10.0),
														_buildOTPField(),
														SizedBox(height: 10.0),
														// SIGN IN BUTTON
														Container(
															padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
															width: double.infinity,
															child: Consumer<AuthBlock>(
																	builder: (BuildContext context, AuthBlock auth, Widget child){
																		return RaisedButton(
																			onPressed: () async {
																				// Validate form
																				if (_formKey.currentState.validate() && !auth.loading) {
																					// Update values
																					_formKey.currentState.save();
																					_user.chfid = widget.chfid;
																					// Hit Api
																					var login = await auth.login(_user);
																					Timer.periodic(Duration(milliseconds: 500), (timer) {
																						print(DateTime.now());
																						print('sign in');
																						if(auth.isLoggedIn){
																							timer.cancel();
																							// Navigator.pushNamed(context, '/card');
																							Navigator.push(
																									context,
																									MaterialPageRoute(
																										builder: (context) => Display(initIndex: 0,),
																									));
																						}
																						timer.cancel();
																					});
																				}
																			},
																			padding: EdgeInsets.all(16.0),
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.all(Radius.circular(10.0)),
																			),
																			color: CustomTheme.lightTheme.splashColor.withOpacity(0.8),
																			child: auth.loading && auth.loadingType == 'login'
																					? CircularProgressIndicator(
																					valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
																					: Text(
																				"Validate OTP".toUpperCase(),
																				style: TextStyle(
																					fontSize: 16.0,
																					fontWeight: FontWeight.bold,
																					fontFamily: "Open-sans",
																					color: Colors.white
																				),
																			),
																		);
																	}
															),
														),

														// CREATE AN ACCOUNT
														/*Container(
														padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
														width: double.infinity,
														child: RaisedButton(
															onPressed: (){
																Navigator.pushNamed(context, '/register');
															},
															padding: EdgeInsets.all(16.0),
															shape: RoundedRectangleBorder(
																borderRadius: BorderRadius.all(Radius.circular(10.0)),
															),
															child: Text(
																"Create an account",
																style: TextStyle(
																	fontSize: 16.0,
																	fontWeight: FontWeight.w400,
																	fontFamily: "Open-sans"
																),
															),
														),
													),*/
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