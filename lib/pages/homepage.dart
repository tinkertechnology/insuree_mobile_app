import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/pages/exploreServices.dart';
import 'package:flutter/material.dart';
import 'package:card_app/pages/claimed_item_services.dart';
import 'package:card_app/screen_size_reducers.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/models/claimed_services_items.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/langlang/app_translation.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
	Future<MedicalServices> _medicalservices;
	Future<Claims> _insureeclaims;
	Future<Claimed> _claimed;
	Future<ClaimedServicesItems> _claimedservicesitems;
	AuthBlock auth;
	
	@override
	void initState(){
		super.initState();
		
		_medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');
		// _insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();

	}
	
	Widget build(BuildContext context) {
	    auth = Provider.of<AuthBlock>(context);
	    //const auth_token = auth.user['data']['insureeAuthOtp']['token'];
//	    print(auth);
//	    print(auth.user["data"][0]["insureeAuthOTP"]);
        print(auth.user['data']['insureeAuthOtp']);
		return Scaffold(
            backgroundColor: CustomTheme.lightTheme.backgroundColor.withOpacity(0.5),
            body: Stack(
                children: [
                    SingleChildScrollView(
                        child: Column(
                            children: [
                                Stack(
                                    children: [
                                        // OPENIMIS LOGO & CURRENT BALANCE
                                        _InsureeInfoWidget(),
                            
                                        // CARD
                                        _InsureeCardWidget(),
                                    ],
                                ),
                                _ClaimHistoryWidget(),
                            ],
                        ),
                    ),
                    
                    ExploreServicesPage(),
                ],
            ),
        );
	}
	
	Widget _InsureeInfoWidget(){
	    return Container(
            height: screenHeight(context, dividedBy: 4), //220,
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                        CustomTheme.lightTheme.primaryColor,
                        CustomTheme.lightTheme.splashColor
                    ]
                ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                        child: Image.asset("assets/images/openimis-logo.png", fit: BoxFit.contain,),
                                    ),
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                    child: Text(
                                        'Hari Bahadur Thapa Magar',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white
                                        ),
                                        maxLines: 3,
                                    ),
                                )
                            ],
                        ),
                    ),
                
                    VerticalDivider(
                        thickness: 1.5,
                        color: Colors.white,
                    ),
                
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                                Text(
                                    'Current Balance',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                    'Rs. 450.00',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                ),
                                SizedBox(height: 4.0),
                                Divider(
                                    indent: 20.0,
                                    thickness: 1.5,
                                    color: Colors.white,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                    'Valid until: 2023-02-21',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                    'First Service Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                )
                            ],
                        ),
                    ),
                ],
            ),
        );
    }
    
    Widget _InsureeCardWidget(){
	    return Container(
            height: 100,
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 165),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                            Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: CustomTheme.lightTheme.primaryColor)
                                    ),
                                    child: Column(
                                        children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(8),
                                                        topLeft: Radius.circular(8),
                                                    ),
                                                    color: CustomTheme.lightTheme.primaryColor
                                                ),
                                                padding: EdgeInsets.all(4),
                                                child: Text(
                                                    'Expiry Date',
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('2078-01-01')
                                        ],
                                    ),
                                ),
                            ),
                            Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: CustomTheme.lightTheme.primaryColor)
                                    ),
                                    child: Column(
                                        children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(8),
                                                        topLeft: Radius.circular(8),
                                                    ),
                                                    color: CustomTheme.lightTheme.primaryColor
                                                ),
                                                padding: EdgeInsets.all(4),
                                                child: Text(
                                                    'Expiry Date',
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('2078-01-01')
                                        ],
                                    ),
                                ),
                            ),
                            Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: CustomTheme.lightTheme.primaryColor)
                                    ),
                                    child: Column(
                                        children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(8),
                                                        topLeft: Radius.circular(8),
                                                    ),
                                                    color: CustomTheme.lightTheme.primaryColor
                                                ),
                                                padding: EdgeInsets.all(4),
                                                child: Text(
                                                    'Expiry Date',
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('2078-01-01')
                                        ],
                                    ),
                                ),
                            ),
                            Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: CustomTheme.lightTheme.primaryColor)
                                    ),
                                    child: Column(
                                        children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(8),
                                                        topLeft: Radius.circular(8),
                                                    ),
                                                    color: CustomTheme.lightTheme.primaryColor
                                                ),
                                                padding: EdgeInsets.all(4),
                                                child: Text(
                                                    'Expiry Date',
                                                    style: TextStyle(
                                                        color: Colors.white
                                                    ),
                                                ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text('2078-01-01')
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    )
                )
            ),
        );
    }
	
	Widget _ClaimHistoryWidget(){
	    return Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
                children: [
                    ListTile(
                        title: Text(
                            AppTranslations.of(context).text("history"),
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal
                            ),
                        ),
                        leading: Icon(Icons.history, color: Colors.green, size: 30,),
                        trailing: GestureDetector(
                            onTap: (){
                                Navigator.pushNamed(context, '/user-history');
                            },
                            child: Text(
                                AppTranslations.of(context).text('see_all'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal
                                ),
                            ),
                        )
                    ),
                    FutureBuilder<Claims>(
                        future: ApiGraphQlServices()
                            .ClaimsServicesGQL(
                            auth.user['data']['insureeAuthOtp']['token'],
                            auth.user['data']['insureeAuthOtp']['insuree']['chfId']
                        ),
                        builder: (context, snapshot) {
                            if(snapshot.hasData && snapshot.data.data!=null) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.data.insureeProfile.insureeClaim.length,
                                    itemBuilder: (BuildContext context, int index){
                                        var claims = snapshot.data.data.insureeProfile.insureeClaim[index];
                                        return ListTile(
                                            title: Text('${claims.healthFacility.name}'),
                                            subtitle: Text('${claims.dateClaimed}'),
                                            trailing: Text('${env.Currency} ${claims.claimed}'),
                                            onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ClaimedItemServicesPage(claimid: int.parse(claims.id)),
                                                    ),
                                                );
                                            },
                                        );
                                    }
                                );
                            }
                            else{
                                return Center(child: CircularProgressIndicator());
                            }
                        }
                    )
                ],
            ),
        );
    }
}