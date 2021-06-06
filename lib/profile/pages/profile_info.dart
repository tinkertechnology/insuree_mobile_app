import 'dart:convert';
import 'dart:io';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:card_app/common/env.dart' as env;

class ProfileInfo extends StatefulWidget {
	@override
	_ProfileInfoState createState() => _ProfileInfoState();
	
}

class _ProfileInfoState extends State<ProfileInfo> {
	File _image;
	final picker = ImagePicker();
	final _formKey = GlobalKey<FormState>();
	var _passKey = GlobalKey<FormFieldState>();
	@override
	void initState() {
		super.initState();
	}
	
	_imgFromCamera() async {
		// File image = (await _picker.getImage(source: ImageSource.camera, imageQuality: 50)) as File;  // await ImagePicker.getImage(
		//source: ImageSource.camera, imageQuality: 50
		//);
		PickedFile image = await picker.getImage(source: ImageSource.camera);
		setState(() {
			if (image != null) {
				_image = File(image.path);
			} else {
				print('No image selected.');
			}
		});
	}

	_imgFromGallery() async {
		PickedFile image = await picker.getImage(source: ImageSource.gallery);
		setState(() {
			if (image != null) {
				_image = File(image.path);
			} else {
				print('No image selected.');
			}
		});
	}
	
	Future uploadPic() async{
		String url = env.API_BASE_URL;
		var request = new http.MultipartRequest("POST", Uri.parse(url));
//		request.headers.addAll(headers);
		request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(Uri.parse(_image.path)).readAsBytes(), filename: "jpt.jpg"));
//		request.fields['address'] = 'address';
//		request.fields['query'] ='mutation {createVoucherPayment(file: ${Uri.parse(_image.path)}){   ok  }  }","variables":null"}';
		request.fields['query'] ='mutation {createVoucherPayment(file: "file"){   ok  }  }';
		print(request);
		request.send().then((response) {
			print(response.stream.bytesToString().toString());
			if (response.statusCode == 200)
				print("Uploaded!");
			setState(() {
				print("Profile Picture uploaded");
				//_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
			});
		});
		
	}
	
	
	void _showPicker(context) {
		showModalBottomSheet(
			context: context,
			builder: (BuildContext bc) {
				return SafeArea(
					child: Container(
						child: new Wrap(
							children: <Widget>[
								new ListTile(
									leading: new Icon(Icons.photo_library),
									title: new Text('Photo Library'),
									onTap: () {
										_imgFromGallery();
										Navigator.of(context).pop();
									}),
								new ListTile(
									leading: new Icon(Icons.photo_camera),
									title: new Text('Camera'),
									onTap: () {
										_imgFromCamera();
										Navigator.of(context).pop();
									},
								),
							],
						),
					),
				);
			}
		);
	}
	

	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Color.fromRGBO(41,127,141, 25), //mainColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text('Profile'),
				backgroundColor: Color.fromRGBO(41,127,141, 0), //mainColor,
			),
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
										SizedBox(height: 20.0),
										// PROFILE IMAGE
										Center(
											child: SizedBox(
												height: 100,
												width: 100,
												child: Stack(
													children: <Widget>[
														Ink(
															decoration: BoxDecoration(
																shape: BoxShape.rectangle,
																color: Colors.transparent,
															),
															child: Image(
																image: AssetImage('assets/images/100-welcome.png'),
																fit: BoxFit.cover,
//                                                                color: Colors.black,
																width: 100,
																height: 100,
																alignment: Alignment.center,
															)
														),
														Align(
															alignment: Alignment(1.5,1.5),
															child: MaterialButton(
																minWidth: 0,
																child: Icon(Icons.camera_alt),
																onPressed: (){
																	_imgFromCamera();
																},
																textColor: Colors.white,
																color: Theme.of(context).accentColor,
																elevation: 0,
																shape: CircleBorder(),
															),
														)
													],
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
										
										// DATE OF BIRTH
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                                                        keyboardType: TextInputType.text,
                                                        validator: (value) {
                                                            if (value.isEmpty) {
                                                                return 'Please enter date of birth';
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
                        
                                                            hintText: 'DOB',
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
										
										// ADDRESS
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisSize: MainAxisSize.min,
												children: <Widget>[
													Text(
														"Address",
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
																return 'Please enter address';
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
															
															hintText: 'Address',
															hintStyle: TextStyle(
																fontFamily: 'Open-sans'
															),
															filled: true,
															contentPadding: EdgeInsets.all(16.0),
															prefixIcon: Icon(Icons.location_on),
														),
													),
												],
											),
										),
										
										// MOBILE NUMBER
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
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
														keyboardType: TextInputType.number,
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
															
															hintText: 'Phone Number',
															hintStyle: TextStyle(
																fontFamily: 'Open-sans'
															),
															filled: true,
															contentPadding: EdgeInsets.all(16.0),
															prefixIcon: Icon(Icons.phone),
														),
													),
												],
											),
										),
										
										// EMAIL
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.symmetric(horizontal: 10.0),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisSize: MainAxisSize.min,
												children: <Widget>[
													Text(
														"Email Address",
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
																return 'Please enter email address';
															}
															return null;
														},
														onSaved: (value) {
															setState(() {

																uploadPic();
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
															
															hintText: 'Email Address',
															hintStyle: TextStyle(
																fontFamily: 'Open-sans'
															),
															filled: true,
															contentPadding: EdgeInsets.all(16.0),
															prefixIcon: Icon(Icons.alternate_email),
														),
													),
												],
											),
										),
										
										// SIGN UP BUTTON
										SizedBox(height: 20.0),
										Container(
											padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
											width: double.infinity,
											child: RaisedButton(
												onPressed: () async {
													uploadPic();
												},
												padding: EdgeInsets.all(20.0),
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.all(Radius.circular(10.0)),
												),
												color: CustomTheme.lightTheme.splashColor,
												child: Text(
													"save changes".toUpperCase(),
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




