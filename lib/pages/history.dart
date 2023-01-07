import 'package:openimis_web_app/blocks/auth_block.dart';
import '../language_config_i18n/app_translation.dart';
import 'package:openimis_web_app/models/insuree_info.dart';
import 'package:openimis_web_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:openimis_web_app/common/env.dart' as env;
import 'package:openimis_web_app/models/medical_services.dart';
import 'package:openimis_web_app/services/api_graphql_services.dart';
import 'package:openimis_web_app/models/claimed.dart';
import 'package:openimis_web_app/models/insuree_claims.dart';
import 'package:provider/provider.dart';
import '../screen_size_reducers.dart';
import 'claimed_item_services.dart';
import 'exploreServices.dart';

class HistoryPage extends StatefulWidget {
	@override
	_HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
	Future<MedicalServices> _medicalservices;
	Future<Claims> _insureeclaims;
	Future<Claimed> _claimed;
	AuthBlock auth;
	
	@override
	void initState(){
		super.initState();
		_medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');
		// _insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();
	}
	
	@override
	Widget build(BuildContext context) {
		auth = Provider.of<AuthBlock>(context);
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
										Container(
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
											child: FutureBuilder<InsureeData>(
													future: ApiGraphQlServices().InsureeInfoServicesGQL(
															auth.user['data']['insureeAuthOtp']['token'],
															auth.user['data']['insureeAuthOtp']['insuree']['chfId']
													),
													builder: (context, snapshot) {
														if(snapshot.hasData) {
															return Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																mainAxisSize: MainAxisSize.min,
																children: <Widget>[
																	Expanded(
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment
																					.start,
																			children: <Widget>[
																				CircleAvatar(
																					radius: 30,
																					backgroundColor: Colors.white,
																					child: ClipOval(

																						child: FadeInImage.assetNetwork(
																							image: snapshot.hasData ? snapshot.data.data.profile.photo:
																							"assets/images/openimis-logo.png",
																							placeholder: "assets/images/openimis-logo.png",

																							fit: BoxFit.contain,),
																					),
																				),


																				SizedBox(height: 8),
																				Expanded(
																					child: Text(
																						'${snapshot.data.data.profile.insuree.otherNames} ${snapshot.data.data.profile.insuree.lastName}',
																						style: TextStyle(
																								fontSize: 14,
																								fontWeight: FontWeight
																										.normal,
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
																			crossAxisAlignment: CrossAxisAlignment
																					.end,
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
																					'${snapshot.data.data.profile.insuree.insureePolicies[0].policy.value}',
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
																					'${123}',
																					style: TextStyle(
																							fontSize: 14,
																							fontWeight: FontWeight.normal,
																							color: Colors.white
																					),
																				),
																				SizedBox(height: 8.0),
																				Text(
																					'${snapshot.data.data.profile.insuree.healthFacility.name ?? "N/A"}',
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
															);
														}
														else if(snapshot.hasError){
															return(Center(child: CircularProgressIndicator(),));
														}
														else {
															return(Center(child: CircularProgressIndicator()));
														}
													}
											),


										),
										
										// CARD
										Container(
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
																			Text('2021-10-19')
																			//Text('${insureeCardDetail.policy.expiryDate}')
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
																					'Remaining',
																					style: TextStyle(
																						color: Colors.white
																					),
																				),
																			),
																			SizedBox(height: 8.0),
																			Text('125 days')
																			//Text('${remainingDays.lastName}')
																		],
																	),
																),
															),
														],
													)
												)
											),
										),
									],
								),
								Container(
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
																var date = '${claims.dateClaimed}';
																return ListTile(
																	title: Text('${claims.healthFacility.name}'),
																	subtitle: Text('${claims.dateClaimed}'),
																	trailing: Text(
																		'${env.Currency} ${claims.claimed}',
																		style: TextStyle(
																			fontSize: 16.0,
																			fontWeight: FontWeight.w400
																		),
																	),
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
								),
							],
						),
					),
					
					ExploreServicesPage(),
				],
			),
		);
		
	}
}
