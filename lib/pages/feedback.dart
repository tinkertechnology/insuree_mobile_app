import 'package:openimis_web_app/pages/settings.dart';
import 'package:openimis_web_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../language_config_i18n/application.dart';
import '../language_config_i18n/app_translation.dart';
import "package:openimis_web_app/services/api_graphql_services.dart";


class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final double circleRadius = 30.0;
  final double circleBorderWidth = 8.0;

  TextEditingController dateCtl = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile_no = TextEditingController();
  TextEditingController queries = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var isLoading = Provider.of<LoadingProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 127, 141, 25), //mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          AppTranslations.of(context).text('feedback'),
        ),
        backgroundColor: Color.fromRGBO(41, 127, 141, 0), //mainColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                        child: ListView(
                          children: [
                            SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: circleRadius,
                                  backgroundColor: CustomTheme
                                      .lightTheme.primaryColor
                                      .withOpacity(0.25),
                                  child: Icon(
                                    Icons.message_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  AppTranslations.of(context)
                                      .text('feedback_title'),
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                            // FULL NAME
                            isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(height: 20.0),
                            _buildNameTF(),

                            // MOBILE NUMBER
                            SizedBox(height: 20.0),
                            _buildPhoneNumberTF(),

                            // EMAIL
                            SizedBox(height: 20.0),
                            _buildEmailTF(),

                            // DESCRIPTION
                            SizedBox(height: 20.0),
                            _buildDescriptionTF(),

                            // CANCEL & SUBMIT BUTTON
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      setState(() {
                                        //  isLoading = true;
                                      });
                                    },
                                    padding: EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    color: Colors.red.shade500,
                                    child: Text(
                                      AppTranslations.of(context)
                                          .text('cancel')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Open-sans",
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      setState(() {
                                           isLoading =true;                                   
                                      });
                                      // isLoading.setLoading(globals.isLoading);
                                      var create = ApiGraphQlServices()
                                          .createFeedback(
                                              fullname.text,
                                              email.text,
                                              mobile_no.text,
                                              queries.text);
                                      if(create!= null){
                                          // Navigator.pop(context, SettingsPage('Feedback Has been Sent thank you'));
                                          Navigator.of(context).pop(MaterialPageRoute(builder:(context)=>SettingsPage('feedback has been sent')));
                                      }
                                    },
                                    
                                    padding: EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    color: CustomTheme.lightTheme.primaryColor,
                                    child: Text(
                                      AppTranslations.of(context)
                                          .text('submit')
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Open-sans",
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
        ],
      ),
    );
  }

  Widget _buildNameTF() {
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
                color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: fullname,
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              hintText: 'Full Name',
              hintStyle: TextStyle(fontFamily: 'Open-sans'),
              filled: true,
              contentPadding: EdgeInsets.all(16.0),
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberTF() {
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
                color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: mobile_no,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter mobile number';
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              hintText: '9841xxxxxx',
              hintStyle: TextStyle(fontFamily: 'Open-sans'),
              filled: true,
              contentPadding: EdgeInsets.all(16.0),
              prefixIcon: Icon(Icons.dialpad),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTF() {
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
                color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              hintText: 'Email Address',
              hintStyle: TextStyle(fontFamily: 'Open-sans'),
              filled: true,
              contentPadding: EdgeInsets.all(16.0),
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTF() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            AppTranslations.of(context).text('description'),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "Open-sans",
                color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            controller: queries,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter FeedbackPage';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                // userCredential.usernameOrEmail = value;
              });
            },
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
              hintStyle: TextStyle(fontFamily: 'Open-sans'),
              filled: true,
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        ],
      ),
    );
  }
}
