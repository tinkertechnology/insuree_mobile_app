import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class PolicyInformation extends StatefulWidget {
	@override
	_PolicyInformationState createState() => _PolicyInformationState();
}

class _PolicyInformationState extends State<PolicyInformation> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Color.fromRGBO(41,127,141, 25),//Color.fromRGBO(0, 96, 113, 25),
			
			body: Column(
				children: <Widget>[
					Expanded(
						child: Container(
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)
								)
							),
							child: Padding(
								padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
								child: ListView(
									children: [
										// CARD
										Container(
											height: 200,
											child: Card(
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(20)
												),
												color: CustomTheme.lightTheme.splashColor, //Colors.orange,
												child: Container(
													padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														mainAxisSize: MainAxisSize.min,
														children: <Widget>[
															Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																mainAxisSize: MainAxisSize.max,
																children: <Widget>[
																	Text(
																		'openIMIS',
																		style: TextStyle(
																			fontSize: 16,
																			fontWeight: FontWeight.bold,
																			color: Colors.white
																		),
																	),
																	Image.asset('assets/images/openimis-logo.png', height: 40,)
																],
															),
															
															SizedBox(height: 8.0),
															SizedBox(
																child: Text(
																	'xxxx xxxx xxxx xxxx',
																	style: TextStyle(
																		fontSize: 28,
																		fontWeight: FontWeight.bold,
																		color: Colors.white
																	),
																),
															),
															
															SizedBox(height: 8.0),
															SizedBox(
																child: Text(
																	'08/22',
																	style: TextStyle(
																		fontSize: 24,
																		fontWeight: FontWeight.w400,
																		color: Colors.white
																	),
																),
															),
															
															SizedBox(height: 8.0),
															SizedBox(
																child: Text(
																	'customer holder name'.toUpperCase(),
																	style: TextStyle(
																		fontSize: 24,
																		fontWeight: FontWeight.w400,
																		color: Colors.white
																	),
																),
															),
														],
													),
												)
											),
										),
										
										// FULL NAME
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
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
														readOnly: true,
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
															hintText: 'Hari Bahadur',
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
										
										// CARD NUMBER
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisSize: MainAxisSize.min,
												children: <Widget>[
													Text(
														"Card Number",
														style: TextStyle(
															fontSize: 16,
															fontWeight: FontWeight.w400,
															fontFamily: "Open-sans",
															color: Colors.grey
														),
													),
													SizedBox(height: 8.0),
													TextFormField(
														keyboardType: TextInputType.number,
														readOnly: true,
														validator: (value) {
															if (value.isEmpty) {
																return 'Please enter phone number';
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
															
															hintText: 'xxxx xxxx xxxx xxxx',
															hintStyle: TextStyle(
																fontFamily: 'Open-sans'
															),
															filled: true,
															contentPadding: EdgeInsets.all(16.0),
															prefixIcon: Icon(Icons.dialpad),
														),
													),
												],
											),
										),
										
										// EXPIRY DATE
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisSize: MainAxisSize.min,
												children: <Widget>[
													Text(
														"Expiry Date",
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
														readOnly: true,
														validator: (value) {
															if (value.isEmpty) {
																return 'Please enter email address';
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
															
															hintText: 'xx / xx',
															hintStyle: TextStyle(
																fontFamily: 'Open-sans'
															),
															filled: true,
															contentPadding: EdgeInsets.all(16.0),
															prefixIcon: Icon(Icons.date_range),
														),
													),
												],
											),
										),
										
										// RENEW SUBMISSION BUTTON
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
											width: double.infinity,
											child: RaisedButton(
												onPressed: () async {},
												padding: EdgeInsets.all(20.0),
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.all(Radius.circular(10.0)),
												),
												color: CustomTheme.lightTheme.primaryColor, //Color.fromRGBO(41,127,141, 100),
												child: Text(
													"renew submission".toUpperCase(),
													style: TextStyle(
														fontSize: 18.0,
														fontWeight: FontWeight.bold,
														fontFamily: "Open-sans",
														color: Colors.white
													),
												),
											),
										),
									],
								),
							),
						)
					)
				],
			),
		);
	}
}
