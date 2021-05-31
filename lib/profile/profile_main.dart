import 'package:card_app/common/env.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_app/profile/widgets/card_item.dart';
import 'package:card_app/profile/widgets/stack_container.dart';
import 'package:card_app/services/bottom_nav_bar_service.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:card_app/blocks/auth_block.dart';
class ProfilePageView extends StatefulWidget {
	@override
	_ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    File _image;
	final picker = ImagePicker();
	AuthBlock auth;
	Future getImage() async {
      var image = await picker.getImage(source: ImageSource.camera);
  
      setState(() {
        _image = image as File;
          print('Image Path $_image');
      });
      if(_image!=null){
        uploadPic();
      }
    }

    Future uploadPic() async{
      final dynamic fileName = basename(_image.path);
      //  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      //  StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      //  StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      var uri = Uri.parse("/api/profile/");
      
      var request = new http.MultipartRequest("POST", uri);
      request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(Uri.parse(fileName)).readAsBytes(), contentType: new MediaType('image', 'jpeg')));
      request.fields['address'] = 'address';
      request.send().then((response) {
      if (response.statusCode == 200) 
      print("Uploaded!");
      setState(() {
          print("Profile Picture uploaded");
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    });
       
    }


	@override
	Widget build(BuildContext context) {
    final bottom_nav = Provider.of<BottomNavigationBarProvider>(context);
    final auth = Provider.of<AuthBlock>(context);
		return Scaffold(
			backgroundColor: Color.fromRGBO(234, 239, 255, 50),
			body: SingleChildScrollView(
				child: Column(
					children: <Widget>[
						/*StackContainer(),
						ListView.builder(
							physics: NeverScrollableScrollPhysics(),
							itemBuilder: (context, index) => CardItem(),
							shrinkWrap: true,
							itemCount: 6,
						)*/
						
						// PROFILE INFO
						Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Expanded(
												child: Row(
													children: <Widget>[
														InkWell(
                              onTap:  getImage,
                              
                            child: Container(
															height: 80,
															width: 80,
															padding: EdgeInsets.all(8.0),
															child: Card(
																semanticContainer: true,
																clipBehavior: Clip.antiAliasWithSaveLayer,
																child:  (_image!=null)?Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                            fit: BoxFit.fill,
                          ),//Image.asset('assets/images/card.png', fit: BoxFit.cover,),
																shape: RoundedRectangleBorder(
																	borderRadius: BorderRadius.circular(10.0),
																),
																// margin: EdgeInsets.all(10),
															),
														),
                            ),
														
														Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: <Widget>[
																InkWell(
																	onTap: (){
																		Navigator.pushNamed(context, '/profileInfo');
																	},
																	child: Text(
																		"Hari Bahadur Thapa",
																		softWrap: true,
																		style: TextStyle(
																				fontSize: 14.0,
																				fontFamily: "Open-sans"
																		),
																	),
																),

																SizedBox(height: 8.0),
																Text("9841-xxx-xxx")
															],
														)
													],
												),
											),
											
											SizedBox(
												child: Row(
													children: <Widget>[
														Text("Unverified"),
														SizedBox(width: 10.0),
														Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey.withOpacity(0.2),)
													],
												),
											)
										],
									),
								)
							),
						),
						
						// GENERAL
						Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.only(left: 16, top: 8, right: 16),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: Row(
													mainAxisAlignment: MainAxisAlignment.spaceBetween,
													mainAxisSize: MainAxisSize.max,
													children: <Widget>[
														Text(
															"General",
															style: TextStyle(
																fontSize: 16.0,
																fontFamily: "Open-sans",
																fontWeight: FontWeight.bold
															),
														)
													],
												),
											),
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: (){
														print("clicked");
													},
													
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														mainAxisSize: MainAxisSize.max,
														children: <Widget>[
															Expanded(
																child: Row(
																	children: <Widget>[
																		Icon(Icons.map, size: 30,),
																		SizedBox(width: 20.0),
																		Text(
																			"Address"
																		),
																	],
																),
															),
															
															Icon(Icons.arrow_forward_ios, size: 25)
														],
													),
												)
											),
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: (){
														print("clicked");
													},
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														mainAxisSize: MainAxisSize.max,
														children: <Widget>[
															Expanded(
																child: Row(
																	children: <Widget>[
																		Icon(Icons.history, size: 30,),
																		SizedBox(width: 20.0),
																		Text(
																			"Transaction History"
																		),
																	],
																),
															),
															
															Icon(Icons.arrow_forward_ios, size: 25)
														],
													),
												)
											),
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												child: GestureDetector(
													onTap: (){
														print("clicked");
													},
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														mainAxisSize: MainAxisSize.max,
														children: <Widget>[
															Expanded(
																child: Row(
																	children: <Widget>[
																		Icon(Icons.account_circle, size: 30,),
																		SizedBox(width: 20.0),
																		Text(
																			"Contact"
																		),
																	],
																),
															),
															
															Icon(Icons.arrow_forward_ios, size: 25)
														],
													),
												)
											),
										],
									),
								)
							),
						),
						
						// SETTINGS
						Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.only(left: 16, top: 8, right: 16),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: (){
														print("clicked");
													},
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														mainAxisSize: MainAxisSize.max,
														children: <Widget>[
															Expanded(
																child: Row(
																	children: <Widget>[
																		Icon(Icons.settings, size: 30,),
																		SizedBox(width: 20.0),
																		Text(
																			"Settings"
																		),
																	],
																),
															),
															
															Icon(Icons.arrow_forward_ios, size: 25)
														],
													),
												)
											),
										],
									),
								)
							),
						),
						
						// HELP CENTER
						Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.only(left: 16, top: 8, right: 16),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: (){
														print("clicked");
													},
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														mainAxisSize: MainAxisSize.max,
														children: <Widget>[
															Expanded(
																child: Row(
																	children: <Widget>[
																		Icon(Icons.help, size: 30,),
																		SizedBox(width: 20.0),
																		Text(
																			"Help Center"
																		),
																	],
																),
															),
															
															Icon(Icons.arrow_forward_ios, size: 25)
														],
													),
												)
											),
										],
									),
								)
							),
						),
						
						// LOGOUT
						Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.only(left: 16, top: 8, right: 16),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Container(
												padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: () async {
														await auth.logout();
                            bottom_nav.currentIndex = 0;
														Navigator.of(context)
															.pushNamedAndRemoveUntil('/insuree_verify', (Route<dynamic> route) => false);
													},
													child: Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														mainAxisSize: MainAxisSize.max,
														children: <Widget>[
															Expanded(
																child: Row(
																	children: <Widget>[
																		Icon(Icons.lock_outline, size: 30,),
																		SizedBox(width: 20.0),
																		Text(
																			"Logout"
																		),

																	],

																),
															),
															
															Icon(Icons.arrow_forward_ios, size: 25)
														],
													),
												)
											),
										],
									),
								)
							),
						),
					],
				),
			),
		);
	}
}