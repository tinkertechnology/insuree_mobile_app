import 'package:card_app/auth/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import  'package:card_app/common/env.dart' as env;
import 'package:card_app/services/verify_insuree_service.dart';
import 'package:card_app/models/insuree.dart';

class VerifyInsuree extends StatefulWidget {


	@override
	_VerifyInsureeState createState() => _VerifyInsureeState();
}

class _VerifyInsureeState extends State<VerifyInsuree> {
	final _formKey = GlobalKey<FormState>();
	final Insuree _insuree = Insuree();
	dynamic verify;

	Widget _buildInsureeCHFID(){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 20.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						"Insuree CHFID",
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
								return 'Please Enter CHFID number';
							}
							return null;
						},
						onSaved: (value) {
							setState(() {
								_insuree.chfid = value;
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

							hintText: 'Insuree CHFID',
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

	Widget _buildFamilyCHFID() {
		return Container(
				padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Text(
							"Family Head CHFID",
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
									_insuree.fhchfid = value;
								});
							},
							decoration: InputDecoration(
									hintText: 'Family Head CHFID',
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
									prefixIcon: Icon(Icons.dialpad)
							),
							keyboardType: TextInputType.text,
							obscureText: true,
						),
					],
				)
		);
	}

	Widget _buildDOBTF() {
		return Container(
				padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Text(
							"Date of Birth",
							style: TextStyle(
									fontSize: 16,
									fontWeight: FontWeight.w400,
									fontFamily: "Open-sans",
									color: Colors.grey
							),
						),
						SizedBox(height: 8.0),

						TextFormField(
							controller: dateCtl,
							decoration: InputDecoration(
								border: OutlineInputBorder(
										borderRadius: BorderRadius.all(
												Radius.circular(10.0)
										),
										borderSide: BorderSide(
											color: Colors.white,
										)
								),

								hintText: 'DOB',
								hintStyle: TextStyle(
										fontFamily: 'Open-sans'
								),
								filled: true,
								contentPadding: EdgeInsets.all(16.0),
								prefixIcon: Icon(Icons.person_outline),
							),
							onTap: () async {
								DateTime date = DateTime(1900);
								FocusScope.of(context).requestFocus(new FocusNode());
								date = await showDatePicker(
										context: context,
										initialDate: DateTime.now(),
										firstDate: DateTime(1900),
										lastDate: DateTime(2100)
								);
								_insuree.dob = date.toIso8601String();
							},
						),
					],
				)
		);
	}

	final double circleRadius =100.0;
	final double circleBorderWidth = 8.0;
	TextEditingController dateCtl = TextEditingController();

	@override
	Widget build(BuildContext context) {
		Size deviceSize = MediaQuery.of(context).size;
		return Scaffold(
				backgroundColor: Color.fromRGBO(41,127,141, 25), //Color.fromRGBO(234, 239, 255, 30),
				body: Container(
					height: MediaQuery.of(context).size.height,
					child: Column(
						children: <Widget>[
							Container(
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
																					image: NetworkImage('https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png',)
																			)
																	),
																),
															),
														),

														SizedBox(height: 10.0),
														ListTile(
															title: Text(
																"Let's Sign You In",
																style: TextStyle(
																		fontSize: 24,
																		fontWeight: FontWeight.w400
																),
																textAlign: TextAlign.center,
															),
															subtitle: Text(
																"Welcome back, you've been missed!",
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
														_buildInsureeCHFID(),
														_buildFamilyCHFID(),
														_buildDOBTF(),
														SizedBox(height: 10.0),
														// SIGN IN BUTTON
														Container(
															padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
															width: double.infinity,
															child: RaisedButton(
																			onPressed: () async {
																				// Validate form
																				if (_formKey.currentState.validate()) {
																					// Update values
																					_formKey.currentState.save();
																					// Hit Api
																				}
																				var verify = await VerifyInsureeService().VerifyInsureeData(_insuree);
																				print('tero bau');
																				if(verify==null){
																					Fluttertoast.showToast(
																							msg: "Incorrect Details ",
																							toastLength: Toast.LENGTH_SHORT,
																							gravity: ToastGravity.CENTER,
																							timeInSecForIos: 1,
																							fontSize: 16.0);
																				}
																				else{
																					Fluttertoast.showToast(
																							msg: "Verify Your Otp for Login",
																							toastLength: Toast.LENGTH_SHORT,
																							gravity: ToastGravity.CENTER,
																							timeInSecForIos: 1,
																							fontSize: 16.0);
																					Navigator.push(
																							context,
																							MaterialPageRoute(
																								builder: (context) => LoginScreen(chfid: _insuree.chfid,),
																							));
																				}
																			},
																			padding: EdgeInsets.all(16.0),
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.all(Radius.circular(10.0)),
																			),
																			color: Color.fromRGBO(254, 196, 45, 50),
																			child:
																					VerifyInsureeService().isLoading ? CircularProgressIndicator(
																					valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
																					: Text(
																				"Verify",
																				style: TextStyle(
																						fontSize: 16.0,
																						fontWeight: FontWeight.w400,
																						fontFamily: "Open-sans"
																				),
																			),
																		)


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