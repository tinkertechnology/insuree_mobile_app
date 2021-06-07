import 'dart:ui';

import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/services/location_service.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {
	@override
	_HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
	
	Future<MedicalServices> _medicalservices;
	Future<Claims> _insureeclaims;
	Future<Claimed> _claimed;
  UserLocation userLocation;
  
	final double _initFabHeight = 120.0;
	double _fabHeight = 0;
	double _panelHeightOpen = 0.0;
	double _panelHeightClosed = 20.0;
	
	@override
	void initState() {
		super.initState();
		_medicalservices =
			ApiGraphQlServices().MedicalServicesGQL('medicalservice');
		_insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();


	}
	
	@override
	Widget build(BuildContext context) {
		var userLocation = Provider.of<UserLocation>(context);

		_panelHeightOpen = MediaQuery.of(context).size.height * .52;
		
		return DraggableScrollableSheet(
			initialChildSize: 0.65,
			minChildSize: 0.03,
			maxChildSize: 0.65,
			builder: (BuildContext context, ScrollController scrollController){
				return Container(
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(
							topRight: Radius.circular(20),
							topLeft: Radius.circular(20)
						),
//						border: Border(
//							top: BorderSide(color: Colors.orangeAccent)
//						),
						color:CustomTheme.lightTheme.backgroundColor,
						/*gradient: LinearGradient(
							begin: Alignment.bottomRight,
							end: Alignment.topLeft,
							colors: [
								CustomTheme.lightTheme.primaryColor,
								CustomTheme.lightTheme.splashColor,
								CustomTheme.lightTheme.accentColor
							]
						),*/
					),
					child:  ListView(
						controller: scrollController,
						children: [
							SizedBox(
								height: 12.0,
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Container(
										width: 40,
										height: 5,
										decoration: BoxDecoration(
											color: Colors.black54,
											borderRadius: BorderRadius.all(Radius.circular(12.0))),
									),
								],
							),
							SizedBox(
								height: 18.0,
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Text(
										"Explore Services",
										style: TextStyle(
											fontWeight: FontWeight.normal,
											fontSize: 24.0,
										),
									),
								],
							),
							SizedBox(
								height: 18.0,
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: <Widget>[
									_button("Service1", Icons.medical_services_rounded, CustomTheme.lightTheme.splashColor),
									_button("Service2", Icons.medical_services_sharp, CustomTheme.lightTheme.splashColor),
									_button("Service3", Icons.medical_services_outlined, CustomTheme.lightTheme.splashColor),
									_button("Service4", Icons.medical_services, CustomTheme.lightTheme.splashColor),

								],

							),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: [
									Text('Latitude: ${userLocation?.longitude}  Longitude: ${userLocation?.longitude}')
								],
							)

						],
					),
				);
			}
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
				Text(label),

			],
		);
	}
}