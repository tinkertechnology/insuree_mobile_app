import 'package:card_app/models/policy_information.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/langlang/app_translation.dart';
import 'package:card_app/langlang/application.dart';

class CardDetailPage extends StatefulWidget {
    final String message;
    CardDetailPage({Key key, @required this.message}) : super(key: key);
    @override
    _CardDetailPageState createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
    Future<PolicyInformation> _policyinformation;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    
    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        application.onLocaleChanged = onLocaleChange;
        _policyinformation = ApiGraphQlServices().PolicyInformationServicesGQL(1);
        Future(() {
            if (widget.message != null && widget.message.isNotEmpty) {
                showInSnackBar(widget.message);
            }
        });

    }
    
    void onLocaleChange(Locale locale) async {
        setState(() {
            AppTranslations.load(locale);
        });
    }

    void showInSnackBar(String value) {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(value), duration: Duration(milliseconds: 3000), ), );
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: CustomTheme.lightTheme.primaryColor,
	        appBar: AppBar(
		        elevation: 0.0,
		        title: Text(
			       AppTranslations.of(context).text('page_card_details'),
			        style: TextStyle(
				        color: Colors.white
			        ),
		        ),
		        backgroundColor: CustomTheme.lightTheme.primaryColor,
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
                                child: FutureBuilder<PolicyInformation>(
                                    future: _policyinformation,
                                    builder: (context, snapshot) {
                                        if(snapshot.hasData) {
                                            var policyprofile = snapshot.data.data.insureeProfile;
                                            return ListView(
                                                children: [
                                                    // CARD
                                                    _virtualCardWidget(policyprofile),
                                                
                                                    // FULL NAME
                                                    SizedBox(height: 20.0),
                                                    _buildNameTF(policyprofile),
                                                
                                                    // CARD NUMBER
                                                    SizedBox(height: 20.0),
                                                    _buildCardNumberTF(policyprofile),
                                                
                                                    // EXPIRY DATE
                                                    SizedBox(height: 20.0),
                                                    _buildExpiryDateTF(policyprofile),
                                                
                                                    // RENEW SUBMISSION BUTTON
                                                    SizedBox(height: 20.0),
                                                    _buildRenewButtonWidget(),
                                                ],
                                            );
                                        }
                                        else {
                                            return Center(child: CircularProgressIndicator());
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
    
    // ignore: non_constant_identifier_names
    Widget _virtualCardWidget(policyprofile){
        return Container(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: CustomTheme.lightTheme.primaryColor, width: 1.0)
                ),
                // color: CustomTheme.lightTheme.splashColor,
                //Colors.orange,
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                    Image.asset(
                                        'assets/images/openimis-logo.png',
                                        height: 40,
                                    ),
                                    SizedBox(width: 8.0),
                                    Column(
                                        children: [
                                            Text(
                                                'नेपाल सरकार',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal,
                                                ),
                                            ),
                                            Text(
                                                'सामाजिक स्वास्थ्य सुरक्षा विकास समिति',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal,
                                                ),
                                            ),
                                        ],
                                    ),
                                    SizedBox(width: 8.0),
                                    Image.asset(
                                        'assets/images/openimis-logo.png',
                                        height: 40,
                                    )
                                ],
                            ),
                        
                            SizedBox(height: 8.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                    Text(
                                        'सदस्यता नं: ' + '${policyprofile.chfId}',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                        ),
                                    ),
                                ],
                            ),
                        
                            SizedBox(height: 8.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                    Text(
                                        'नामथर: ',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                        ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                        '${policyprofile.otherNames} ${policyprofile.lastName}',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.underline,
                                            decorationStyle: TextDecorationStyle.dotted,
                                        ),
                                    ),
                                ],
                            ),
                        
                            SizedBox(height: 8.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                    Text(
                                        'जन्ममिति: 2078-01-01',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                        ),
                                    ),
                                    Text(
                                        'लिङ्ग: Male',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                        ),
                                    )
                                ],
                            ),
                        
                            SizedBox(height: 8.0),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                    Text(
                                        'प्रथम स्वास्थ्य संस्था:',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                        ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                        'Patan' + 'Hospital',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.underline,
                                            decorationStyle: TextDecorationStyle.dotted,
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                )
            ),
        );
    }
    
    Widget _buildNameTF(policyprofile){
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
                            hintText: '${policyprofile.otherNames} ${policyprofile.lastName}',
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
    
    Widget _buildCardNumberTF(policyprofile){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Text(
                        AppTranslations.of(context).text('card_number'),
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
                    
                            hintText: '${policyprofile.chfId}',
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
        );
    }
    
    Widget _buildExpiryDateTF(policyprofile){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Text(
                        AppTranslations.of(context).text('expiry_date'),
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
                    
                            hintText: '${DateTime.parse(policyprofile.insureePolicies[0].expiryDate.toString())}',
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
        );
    }
    
    Widget _buildRenewButtonWidget(){
        return Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
            width: double.infinity,
            child: RaisedButton(
                onPressed: () async {
                    Navigator.pushNamed(context, '/PaymentsubmissionPage');
                },
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: CustomTheme.lightTheme.primaryColor,
                child: Text(
                    AppTranslations.of(context).text('renew_submission').toUpperCase(),
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
