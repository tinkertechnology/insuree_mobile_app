import 'package:card_app/common/env.dart';
import 'package:card_app/theme/dark_theme_provider.dart';
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

	bool _flutter = false;
	@override
	Widget build(BuildContext context) {
    final bottom_nav = Provider.of<BottomNavigationBarProvider>(context);
   
    
    final auth = Provider.of<AuthBlock>(context);
		final themeChange = Provider.of<DarkThemeProvider>(context);

		return Scaffold(
			backgroundColor: Color.fromRGBO(234, 239, 255, 50),
			body: SingleChildScrollView(
				child: Column(
					children: <Widget>[
						// PROFILE INFO
						Container(
							margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: InkWell(
									onTap: (){
										print('Profile Clicked');
										Navigator.pushNamed(context, '/profile-info');
									},
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
																		child: (_image!=null)?Image.file(_image, fit: BoxFit.fill,):
																		Image.network("https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", fit: BoxFit.fill,),//Image.asset('assets/images/card.png', fit: BoxFit.cover,),
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
											
											// NOTIFICATIONS
											Container(
												//padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: InkWell(
													onTap: (){
														print("Notifications clicked...");
														Navigator.pushNamed(context, '/notifications');
													},
													
													child: ListTile(
														title: Text('Notifications'),
														//subtitle: Text('write a feedback'),
														leading: Icon(Icons.notifications),
														trailing: Icon(Icons.arrow_forward_ios),
													)
												)
											),
											
											// SERVICE PROVIDER LIST
											Container(
												// padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: (){
														print("clicked");
													},
													child: ListTile(
														title: Text('Service Provider List'),
														//subtitle: Text('write a feedback'),
														leading: Icon(Icons.list),
														trailing: Icon(Icons.arrow_forward_ios),
													)
												)
											),
											
											// NOTICE
											Container(
												// padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												decoration: BoxDecoration(
													border: Border(
														bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
													)
												),
												child: GestureDetector(
													onTap: (){
														print("Notice Board clicked");
													},
													child: ListTile(
														title: Text('Notice'),
														//subtitle: Text('write a feedback'),
														leading: Icon(Icons.note),
														trailing: Icon(Icons.arrow_forward_ios),
													)
												)
											),
											
											// FEEDBACK
											Container(
												//padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
												child: GestureDetector(
													onTap: (){
														print("Feedback page clicked...");
														Navigator.pushNamed(context, '/feedback');
													},
													child: ListTile(
														title: Text('Feedback'),
														//subtitle: Text('write a feedback'),
														leading: Icon(Icons.feedback,),
														trailing: Icon(Icons.arrow_forward_ios),
													)
												)
											),
										],
									),
								)
							),
						),
						
						// UPDATE LANGUAGE
						/*Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								color: Colors.white,
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.all(8.0),
									child: SwitchListTile(
										title: Text('Update Language'),
										subtitle: Text('change language to your preferred language'),
										secondary: Icon(Icons.language),
										value: _flutter,
										activeColor: Colors.yellow[500],
										inactiveTrackColor: Colors.grey,
										onChanged: (bool val){
											setState(() {
												_flutter = val;
											});
										}
									),
								),
							),
						),*/
						Container(
							margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.all(8.0),
									child: SwitchListTile(
										title: Text('Update Language'),
										subtitle: Text('Change language to your preferred language'),
										secondary: Icon(Icons.language, size: 30,),
										value: _flutter,
										activeColor: Colors.white.withOpacity(0.25),
										inactiveTrackColor: Colors.grey,
										onChanged: (bool value) {
											_flutter = value;
										},
									),
								)
							),
						),
						
						// DARK/LIGHT THEME
						/*Container(
							margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
							child: Card(
								color: Colors.white,
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									padding: EdgeInsets.all(8.0),
									child: SwitchListTile(
										title: Text('Dark/Light Theme'),
										subtitle: Text('Change theme color'),
										secondary: Icon(Icons.brightness_6),
										value: themeChange.darkTheme,
										activeColor: Colors.red,
										inactiveTrackColor: Colors.grey,
										onChanged: (bool value) {
											themeChange.darkTheme = value;
										},
									),
								),
							),
						),*/
						Container(
							margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									child: SwitchListTile(
										title: Text('Dark/Light Theme'),
										subtitle: Text('Change theme color'),
										secondary: Icon(Icons.brightness_6, size: 30,),
										value: themeChange.darkTheme,
										activeColor: Colors.white.withOpacity(0.25),
										inactiveTrackColor: Colors.grey,
										onChanged: (bool value) {
											themeChange.darkTheme = value;
										},
									),
								)
							),
						),
						
						// CONTACT US
						Container(
							margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
							child: Card(
								shape: RoundedRectangleBorder(
									side: BorderSide(color: Colors.white70, width: 1),
									borderRadius: BorderRadius.circular(20),
								),
								child: Container(
									child: ListTile(
										title: Text('Contact Us'),
										subtitle: Text('Change theme color'),
										leading: Icon(
											Icons.info_outline,
											size: 30,
										),
										trailing: Icon(
											Icons.arrow_forward_ios,
										),
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
//                            bottom_nav.currentIndex = 0;
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