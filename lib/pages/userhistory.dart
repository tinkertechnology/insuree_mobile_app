import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:openimis_web_app/models/insuree_claims.dart';
import 'package:openimis_web_app/services/api_graphql_services.dart';
import 'package:openimis_web_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:openimis_web_app/common/env.dart' as env;
import 'package:provider/provider.dart';

class UserHistoryPage extends StatefulWidget {
	@override
	_UserHistoryPageState createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
	Future<Claims> _insureeclaims;
	AuthBlock auth;
	
	@override
	void initState(){
		super.initState();
		// _insureeclaims = ApiGraphQlServices().ClaimsServicesGQL(auth.user['data']['insureeAuthOtp']['token']);
	}
	
	@override
	Widget build(BuildContext context) {
		auth = Provider.of<AuthBlock>(context);
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(
					'History',
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
								padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
								child: FutureBuilder<Claims>(
									future: ApiGraphQlServices()
										.ClaimsServicesGQL(
										auth.user['data']['insureeAuthOtp']['token'],
										auth.user['data']['insureeAuthOtp']['insuree']['chfId']
									),
									builder: (context, snapshot){
										if(snapshot.hasData && snapshot.data.data!=null) {
											return ListView.builder(
												shrinkWrap: true,
												scrollDirection: Axis.vertical,
												physics: NeverScrollableScrollPhysics(),
												itemCount: snapshot.data.data.insureeProfile.insureeClaim.length,
												itemBuilder: (BuildContext context, int index){
													var claims = snapshot.data.data.insureeProfile.insureeClaim[index];
													
													return _getHistoryWidgetCard(claims);
												}
											);
										}
										else{
											return Center(child: CircularProgressIndicator());
										}
									},
								),
							)
						)
					)
				],
			),
		);
	}
	
	Widget _getHistoryWidgetCard(claims){
        return Container(
            padding: EdgeInsets.all(2),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
                        child: Text(
                            '${claims.dateClaimed}', // 'Fri, May 28th',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                            ),
                        ),
                    ),
                    
                    Card(
                        shape: RoundedRectangleBorder(
                            // side: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        color: CustomTheme.lightTheme.accentColor.withOpacity(1),
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                    ListTile(
                                        title:  Text('${claims.healthFacility.name}'),
                                        trailing: Text(
                                            '${env.Currency} ${claims.claimed}',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ),
                ],
            )
        );
    }
}

