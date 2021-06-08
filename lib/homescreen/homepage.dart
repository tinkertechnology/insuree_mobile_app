import 'dart:ui';

import 'package:card_app/langlang/app_translation.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/screen_size_reducers.dart';
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
  
	double min = 0.03, initial = 0.65, max = 0.7;
	
	@override
	void initState() {
		super.initState();
		_medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');
		_insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();
	}
	
	@override
	Widget build(BuildContext context) {
		var userLocation = Provider.of<UserLocation>(context);
 
		Size deviceSize = MediaQuery.of(context).size;
		return DraggableScrollableSheet(
			initialChildSize: initial, //0.65,
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
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: <Widget>[
									_button("Service1", Icons.medical_services_rounded, CustomTheme.lightTheme.splashColor),
									_button("Service2", Icons.medical_services_sharp, CustomTheme.lightTheme.splashColor),
									_button("Service3", Icons.medical_services_outlined, CustomTheme.lightTheme.splashColor),
									_button("Service4", Icons.medical_services, CustomTheme.lightTheme.splashColor),
								],
							),
							SizedBox(
								height: screenHeight(context, dividedBy: 30),
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