import 'package:openimis_web_app/common/CommonToast.dart';
import 'package:openimis_web_app/theme/custom_theme.dart';
import 'package:openimis_web_app/theme/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:openimis_web_app/services/bottom_nav_bar_service.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:openimis_web_app/blocks/auth_block.dart';
import '../language_config_i18n/app_translation.dart';
import '../language_config_i18n/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openimis_web_app/helper/shared_preferences_helper.dart';

class SettingsPage extends StatefulWidget {
  final feedbackMessage;
  SettingsPage(this.feedbackMessage);
	@override
	_SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {
	Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
	static final List<String> languagesList = application.supportedLanguages;
	static final List<String> languageCodesList =
			application.supportedLanguagesCodes;

	final Map<dynamic, dynamic> languagesMap = {
		languagesList[0]: languageCodesList[0],
		languagesList[1]: languageCodesList[1],
	};
  SessionManager prefs =  SessionManager();

	String label = languagesList[0];

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

	void _select(String language) async {
		print("dd "+language);
		final SharedPreferences prefs = await _prefs;
		var jpt = Locale(languagesMap[language]);
		onLocaleChange(Locale(languagesMap[language]));

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

    void showMessage(String val, context){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(val), duration: Duration(milliseconds: 3000),),);
    }
	bool _flutter = false;
	@override
	Widget build(BuildContext context) {
    final bottom_nav = Provider.of<BottomNavigationBarProvider>(context);
    if (widget.feedbackMessage!=null){
      showMessage(widget.feedbackMessage, context);
    }    
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.backgroundColor, //Color.fromRGBO(234, 239, 255, 50),
			body: SingleChildScrollView(
				child: Column(
					children: <Widget>[
						// PROFILE INFO
						Container(
							margin: EdgeInsets.fromLTRB(20, 8, 20, 0),
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
									child: FutureBuilder<String>(
									  future: prefs.getFullname(),
									  builder: (context, snapshot) {
									    var fullname = snapshot.data;
									    if(snapshot.hasData) {
					                        return Container(
					                          child: ListTile(
					                            title: Text('${fullname}'),
					//									    		subtitle: Text('9841-xxx-xxx'),
					                            trailing: Icon(Icons.arrow_forward_ios),
					                            leading: Container(
					                              padding: EdgeInsets.all(8.0),
					                              child: FutureBuilder<String>(
					                                future: prefs.getImage(),
					                                builder: (context, snapshot) {
					                                  return Card(
					                                    semanticContainer: true,
					                                    clipBehavior: Clip.antiAliasWithSaveLayer,
					                                    child: (_image != null) ? Image.file(
					                                      _image, fit: BoxFit.fill,) :
					                                    Image.asset(
					                                       'assets/images/openimis-logo.png',
					                                      fit: BoxFit.fill,
					                                    ),
					                                    shape: RoundedRectangleBorder(
					                                      borderRadius: BorderRadius.circular(10.0),
					                                    ),
					                                    // margin: EdgeInsets.all(10),
					                                  );
					                                }
					                              ),
					                            ),
					                          ),
					                        );
					                        }
									        else {
									        	return Text("Profile not set");
					                        }
									  }
									),
								),
							),
						),

						// GENERAL
						_buildGeneralWidget(context),

						// UPDATE LANGUAGE
						_buildUpdateLanguageWidget(context),

						// DARK/LIGHT THEME
						_buildThemeWidget(context),

						// CONTACT US
						_buildContactWidget(context),

						// LOGOUT
						_buildLogoutWidget(context),
					],
				),
			),
		);
	}
	
	Widget _buildGeneralWidget(context){
	    return Container(
            margin: EdgeInsets.fromLTRB(20, 4, 20, 4),
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
                                        Text(AppTranslations.of(context).text("general"),
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
                                        title: Text(AppTranslations.of(context).text("notifications"),),
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
                                        print("Service Provider List Clicked...");
                                        Navigator.pushNamed(context, '/service-provider-list');
                                    },
                                    child: ListTile(
                                        title: Text(AppTranslations.of(context).text("service_provider_list"),),
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
                                        Navigator.pushNamed(context, '/notice');
                                    },
                                    child: ListTile(
                                        title: Text(AppTranslations.of(context).text("notice"),),
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
                                        title: Text(AppTranslations.of(context).text("feedback"),),
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
        );
    }
    
    Widget _buildUpdateLanguageWidget(context){
	    return Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                        title: Text(AppTranslations.of(context).text("update_language"),),
                        subtitle: Text(AppTranslations.of(context).text("change_language_text"),),
                        leading: Icon(Icons.language, size: 30,),
                        trailing: DropdownButton<String>(
                            focusColor: CustomTheme.lightTheme.primaryColor,
                            style: TextStyle(color: CustomTheme.lightTheme.primaryColor),
                            iconEnabledColor: CustomTheme.lightTheme.primaryColor,
                            items: languagesList.map<DropdownMenuItem<String>>((String choice){
                                return DropdownMenuItem<String>(
                                    value: choice,
                                    child: Text(
                                        choice,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),
                                    ),
                                );
                            }).toList(),
                            onChanged: _select,
                            hint: Text('Select'),
                        ),
                    ),
                ),
            ),
        );
    }
    
    Widget _buildThemeWidget(context){
        final themeChange = Provider.of<DarkThemeProvider>(context);
	    return Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    child: SwitchListTile(
                        title: Text(AppTranslations.of(context).text("dark_light_theme"),),
                        subtitle: Text(AppTranslations.of(context).text("change_theme_color")),
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
        );
    }
    
    Widget _buildContactWidget(context){
	    return Container(
            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
	                onTap: (){
	                	Navigator.pushNamed(context, '/contact');
	                },
	                child: Container(
		                child: ListTile(
			                title: Text(AppTranslations.of(context).text("contact_us"),),
			                subtitle: Text('Have any queries? Contact us'),
			                leading: Icon(
				                Icons.phone_in_talk,
				                size: 30,
			                ),
			                trailing: Icon(
				                Icons.arrow_forward_ios,
			                ),
		                ),
	                ),
                )
            ),
        );
    }
    
    Widget _buildLogoutWidget(context){
        final auth = Provider.of<AuthBlock>(context);
        return Container(
	        margin: EdgeInsets.fromLTRB(20, 4, 20, 20),
            child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    padding: EdgeInsets.only(left: 8, top: 0, right: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                            Container(
                                // padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
                                    )
                                ),
                                child: GestureDetector(
                                    onTap: () async {
                                        await auth.logout();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil('/insuree_verify', (Route<dynamic> route) => false);
                                    },
                                    child: Container(
	                                    child: ListTile(
		                                    title: Text(AppTranslations.of(context).text("logout"),),
		                                    subtitle: Text('Logout from openIMIS app'),
		                                    leading: Icon(
			                                    Icons.lock_outline,
			                                    size: 30,
		                                    ),
	                                    ),
                                    ),
                                )
                            ),
                        ],
                    ),
                )
            ),
        );
    }
}