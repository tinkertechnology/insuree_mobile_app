import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/langlang/app_translation.dart';
import 'package:card_app/langlang/application.dart';
import 'package:card_app/mock_api/profile.dart';
import 'package:card_app/models/insuree_info.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:provider/provider.dart';
import 'package:card_app/models/profile.dart';
import 'package:card_app/services/api_graphql_services.dart';



class ProfileInfo extends StatefulWidget {
	@override
	_ProfileInfoState createState() => _ProfileInfoState();
	
}

class _ProfileInfoState extends State<ProfileInfo> {
	File _image;
	final picker = ImagePicker();
	final _formKey = GlobalKey<FormState>();
	var _passKey = GlobalKey<FormFieldState>();
	TextEditingController phoneController = TextEditingController();
	TextEditingController emailController = TextEditingController();

	var abc;
	bool isLoading = false;
	AuthBlock auth;
	@override
	void initState() {
		super.initState();
    application.onLocaleChanged = onLocaleChange;
	}

    void onLocaleChange(Locale locale) async {
        setState(() {
            AppTranslations.load(locale);
        });
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

	Future uploadProfile() async{
		setState(() {
			isLoading = !isLoading;
		});
		String url = env.API_BASE_URL;
		var request = new http.MultipartRequest("POST", Uri.parse(url));
//		request.headers.addAll(headers);
		if (_image!=null) {
			request.files.add(new http.MultipartFile.fromBytes(
					'file', await File.fromUri(Uri.parse(_image.path)).readAsBytes(),
					filename: "jpt.jpg"));
		}
		request.fields['query'] ='mutation {updateProfile(file: "file", email:"${emailController.text}", phone: "${phoneController.text}", insureeCHFID:"${auth.user['data']['insureeAuthOtp']['insuree']['chfId']}"){   ok  }  }';
		print(request);
		request.send().then((response) {
			print(response.stream.bytesToString().toString());
			if (response.statusCode == 200) {
				if (response.reasonPhrase == "OK") {
//					RedirectToCardPage(AppTranslations.of(context).text('payment_voucher_submission'),);
				}
				else{
//					RedirectToCardPage(AppTranslations.of(context).text('payment_voucher_submission_error'));

				}
				setState(() {
					isLoading = !isLoading;
					//_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
				});
			}
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

	Widget _imageCardWidget(){
		return GestureDetector(
			onTap: (){
				_showPicker(context);
			},
			child: Card(
				child: Image.file(
					_image,
					fit: BoxFit.fill,
				),
			),
		);
	}

	Widget _addImageCardWidget(){
		return GestureDetector(
			onTap: (){
				_showPicker(context);
			},
		);
	}


	@override
	Widget build(BuildContext context) {
		auth = Provider.of<AuthBlock>(context);
		return Scaffold(
			backgroundColor: Color.fromRGBO(41,127,141, 25), //mainColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(AppTranslations.of(context).text('page_title_profile')),
				backgroundColor: Color.fromRGBO(41,127,141, 0), //mainColor,
			),
			body: isLoading ? Center(child: CircularProgressIndicator(),) :
			Column(
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
								child: FutureBuilder<InsureeData>(
								  future: ApiGraphQlServices().InsureeInfoServicesGQL(
										auth.user['data']['insureeAuthOtp']['token'],
										auth.user['data']['insureeAuthOtp']['insuree']['chfId'].toString(),
									),
								  builder: (context, snapshot) {
										if (snapshot.hasData && snapshot.data.data!=null) {
											return ListView(

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
																				child: CachedNetworkImage(
                                            
																						imageUrl:	snapshot.data.data.profile.photo, //"https://cdn.sstatic.net/Img/teams/teams-illo-free-sidebar-promo.svg?v=47faa659a05e",
																						placeholder: (context, url) => new CircularProgressIndicator(),
																						errorWidget: (context, url, error) =>  _image==null ? new Image.asset('assets/images/openimis-logo.png') : _addImageCardWidget(),
																						fit: BoxFit.fill
																				),

//                                                                color: Colors.black,

//																					alignment: Alignment.center,
																				),
																		_image != null ?
																		_imageCardWidget()
																				: _addImageCardWidget(),
//																		Align(
//																			alignment: Alignment(1.5, 1.5),
//																			child: MaterialButton(
//																				minWidth: 0,
//																				child: Icon(Icons.camera_alt),
//																				onPressed: () {
//																					_imageCardWidget();
//																				},
//																				textColor: Colors.white,
//																				color: Theme
//																						.of(context)
//																						.accentColor,
//																				elevation: 0,
//																				shape: CircleBorder(),
//																			),
//																		)
																	],
																)
														),
													),

													// FULL NAME
													SizedBox(height: 16.0),
													_buildFullnameWidget(snapshot.data.data.profile.insuree.otherNames, snapshot.data.data.profile.insuree.lastName),

													// DATE OF BIRTH
													SizedBox(height: 16.0),
													_buildDOBWidget(snapshot.data.data.profile.insuree.dob),

													// ADDRESS
													SizedBox(height: 16.0),
													_buildAddressWidget(snapshot.data.data.profile.insuree.currentAddress),

													// PHONE NUMBER
													SizedBox(height: 16.0),
													_buildPhoneWidget(snapshot.data.data.profile.phone),

													// EMAIL
													SizedBox(height: 16.0),
													_buildEmailWidget(snapshot.data.data.profile.email),

													// SUBMIT BUTTON
													SizedBox(height: 16.0),
													_buildSubmitButton()
												],
											);
										}
										else {
											return Center(child: CircularProgressIndicator(),);
										}
									}

								),
							),
						)
					)
				],
			),
		);
	}
	
	Widget _buildFullnameWidget(firstname, lastname){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 10.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						AppTranslations.of(context).text('full_name'),
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
							hintText: '${firstname} ${lastname}',
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
		);
	}
	
	Widget _buildDOBWidget(dob){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 10.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						AppTranslations.of(context).text('date_of_birth'),
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
							
							hintText: '${dob.year}-${dob.month}-${dob.day}',
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
		);
	}
	
	Widget _buildAddressWidget(current_address){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 10.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						AppTranslations.of(context).text('address'),
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
							
							hintText: '${current_address ?? "Not Available"}',
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
		);
	}
	
	Widget _buildPhoneWidget(String phone_number){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 10.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						AppTranslations.of(context).text('mobile_number'),
						style: TextStyle(
							fontSize: 16,
							fontWeight: FontWeight.w400,
							fontFamily: "Open-sans",
							color: Colors.grey
						),
					),
					SizedBox(height: 8.0),
					TextFormField(
						controller: phoneController,
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
							
							hintText: '${phone_number}',
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
		);
	}
	
	Widget _buildEmailWidget(String email){
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 10.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Text(
						AppTranslations.of(context).text('email_address'),
						style: TextStyle(
							fontSize: 16,
							fontWeight: FontWeight.w400,
							fontFamily: "Open-sans",
							color: Colors.grey
						),
					),
					SizedBox(height: 8.0),
					TextFormField(
						controller: emailController,
						keyboardType: TextInputType.emailAddress,
						validator: (value) {
							if (value.isEmpty) {
								return 'Please enter email address';
							}
							return null;
						},
						onSaved: (value) {
							setState(() {

								
								uploadProfile();
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
							
							hintText: '${email}',
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
		);
	}
	
	Widget _buildSubmitButton(){
		return Container(
			padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
			width: double.infinity,
			child: RaisedButton(
				onPressed: () async {
					uploadProfile();
				},
				padding: EdgeInsets.all(16.0),
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.all(Radius.circular(10.0)),
				),
				color: CustomTheme.lightTheme.primaryColor,
				child: Text(
					AppTranslations.of(context).text('submit'),
					style: TextStyle(
						fontSize: 18.0,
						fontWeight: FontWeight.bold,
						fontFamily: "Open-sans",
						color: Colors.white
					),
				),
			),
		);
	}
	
}




