import 'dart:ui';

import 'package:openimis_web_app/blocks/auth_block.dart';
import '../language_config_i18n/app_translation.dart';
import 'package:openimis_web_app/models/claimed.dart';
import 'package:openimis_web_app/models/insuree_claims.dart';
import 'package:openimis_web_app/models/insuree_policy_information.dart';
import 'package:openimis_web_app/models/user_location.dart';
import 'package:openimis_web_app/screen_size_reducers.dart';
import 'package:openimis_web_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openimis_web_app/models/medical_services.dart';
import 'package:openimis_web_app/services/api_graphql_services.dart';
import 'package:provider/provider.dart';
import 'package:openimis_web_app/services/bottom_nav_bar_service.dart';

class ExploreServicesPage extends StatefulWidget {
	@override
	_ExploreServicesPageState createState() => _ExploreServicesPageState();
}

class _ExploreServicesPageState extends State<ExploreServicesPage> {
	Future<MedicalServices> _medicalservices;
	Future<Claims> _insureeclaims;
	Future<Claimed> _claimed;
	UserLocation userLocation;
	Future<InsureePolicyInformation> _insureepolicyinformation;
	AuthBlock auth;

	double min = 0.03, initial = 0.65, max = 0.7;
	
	@override
	void initState() {
		super.initState();
		_medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');

	}
	
	@override
	Widget build(BuildContext context) {
		final bottom_nav = Provider.of<BottomNavigationBarProvider>(context);
		return DraggableScrollableSheet(
			//initialChildSize: initial, //0.65,
			initialChildSize: initial,
			minChildSize: min,
			maxChildSize: max,
			builder: (BuildContext context, ScrollController scrollController){
				return Container(
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(
							topRight: Radius.circular(20),
							topLeft: Radius.circular(20)
						),
						boxShadow: [
							BoxShadow(color: CustomTheme.lightTheme.accentColor, spreadRadius: 1),
						],
						color:CustomTheme.lightTheme.backgroundColor,
					),
					
					child:  ListView(
						controller: scrollController,
						children: [
							SizedBox(
								height: screenHeight(context, dividedBy: 80),
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Container(
										width: screenWidth(context, dividedBy: 10),
										height: screenHeight(context, dividedBy: 100),
										decoration: BoxDecoration(
											color: Colors.black54,
											borderRadius: BorderRadius.all(Radius.circular(12.0))),
									),
								],
							),
							SizedBox(
								height: screenHeight(context, dividedBy: 80),
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Text(AppTranslations.of(context).text("explore_services"),
										style: TextStyle(
											fontWeight: FontWeight.normal,
											fontSize: 24.0,
										),
									),
								],
							),
							SizedBox(
								height: screenHeight(context, dividedBy: 40),
							),
							
							_exploreServicesItemWidget(),
							
							SizedBox(
								height: screenHeight(context, dividedBy: 30),
							),
//							Row(
//								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//								children: [
//									Text('Latitude: ${userLocation?.longitude}  Longitude: ${userLocation?.longitude}')
//								],
//							),
						],
					),
				);
			}
		);
	}
	
	Widget _exploreServicesItemWidget(){
		return ConstrainedBox(
			constraints: BoxConstraints(maxHeight: 1000),
			child: FutureBuilder<MedicalServices>(
				future: _medicalservices,
				builder: (context, snapshot) {
					if(snapshot.hasData && snapshot.data.data!=null) {
						return GridView.builder(
							gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
							physics: ScrollPhysics(),
							shrinkWrap: true,
							itemCount: snapshot.data.data.medicalServicesStr.edges.length,
							itemBuilder: (BuildContext context, int index) {
								var medical_services = snapshot.data.data
									.medicalServicesStr.edges[index];
								return Container(
									padding: EdgeInsets.all(4.0),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceEvenly,
										mainAxisSize: MainAxisSize.max,
										children: [
											Expanded(
												child: _button(
													'${medical_services.node.name} $index',
													Icons.medical_services_rounded,
													CustomTheme.lightTheme.splashColor
												),
											),
										],
									),
								);
							}
						);
					}
					else{
						return Center(child:CircularProgressIndicator());
					}
				}
			),
		);
	}
	
	Widget _button(String label, IconData icon, Color color) {
		return Column(
			children: <Widget>[
				Container(
					padding: const EdgeInsets.all(16.0),
					child: Icon(
						icon,
						color: Colors.white,
					),
					decoration:
					BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
						BoxShadow(
							color: Color.fromRGBO(0, 0, 0, 0.15),
							blurRadius: 8.0,
						)
					]),
				),
				SizedBox(
					height: 12.0,
				),
				Text(
					label,
					style: TextStyle(
						fontSize: 12.0
					),
					textAlign: TextAlign.center,
					softWrap: true,
					maxLines: 3,
				),

			],
		);
	}
}