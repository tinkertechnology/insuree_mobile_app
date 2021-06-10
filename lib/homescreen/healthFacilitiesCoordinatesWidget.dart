import 'package:card_app/models/claimeditems.dart';
import 'package:card_app/models/claimedservices.dart';
import 'package:card_app/models/health_facility_coordinates.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:provider/provider.dart';

class HealthFacilitiesCoordinatesWidget extends StatefulWidget {
	@override
	_HealthFacilitiesCoordinatesWidgetState createState() => _HealthFacilitiesCoordinatesWidgetState();
}

class _HealthFacilitiesCoordinatesWidgetState extends State<HealthFacilitiesCoordinatesWidget> {
	Future<HealthFacilityCoordinates> _healthFacilityCoordinates;
	bool _isLoad=false;
	@override
	initState(){
		super.initState();
		//_healthFacilityCoordinates = ApiGraphQlServices().HealthFacilityCoordinatesServicesGQL({});
	}
	
	@override
	Widget build(BuildContext context) {
		var userLocation = Provider.of<UserLocation>(context);
		if(!_isLoad){
			_healthFacilityCoordinates =
					ApiGraphQlServices().HealthFacilityCoordinatesServicesGQL({
						"inputLatitude": userLocation?.latitude,
						"inputLongitude": userLocation?.longitude
					});
			_isLoad = true;
		}

		return  Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(
					'Service Provider List',
					style: TextStyle(
						color: Colors.white
					),
				),
				backgroundColor: CustomTheme.lightTheme.primaryColor,
			),
			body: Column(
				children: [
					Expanded(
						child: Container(
							padding: EdgeInsets.all(16.0),
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)),
							),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisSize: MainAxisSize.min,
								children: [
									Container(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											mainAxisSize: MainAxisSize.max,
											children: [
												Container(
													padding: EdgeInsets.only(left:8.0, top: 16.0, bottom: 8.0),
													decoration: BoxDecoration(
														border: Border(
															bottom: BorderSide(
																color: Colors.grey
																	.withOpacity(0.25)))),
													width: double.infinity,
													child: Text(
														'Nearby Health Facilities/Approx. Distance (km) ',
														style: TextStyle(
															fontSize: 20.0,
															fontWeight: FontWeight.bold
														),
													),
												),
												SizedBox(height: 8.0),
												Container(
													child: FutureBuilder<HealthFacilityCoordinates>(
														future: _healthFacilityCoordinates,
														builder: (context, snapshot) {
															if (snapshot.hasData) {
																return ListView.builder(
																	shrinkWrap: true,
																	physics: NeverScrollableScrollPhysics(),
																	itemCount: snapshot.data.data.healthFacilityCoordinate.length,
																	itemBuilder: (BuildContext context, int index) {
																		var item = snapshot.data.data.healthFacilityCoordinate[index];
																		return Container(
																			child: ListTile(
																				title: Text(
																					'${item.healthFacility.name}',
																					style: TextStyle(
																						fontSize: 14.0,
																						fontWeight: FontWeight.normal
																					),
																				),
																				trailing: Text(
																					'${item.distance}',
																					style: TextStyle(
																						fontSize: 16.0,
																						fontWeight: FontWeight.bold,
																						color: CustomTheme.lightTheme.primaryColor
																					),
																				),
																			),
																		);
																	});
															} else {
																return Center(
																	child: CircularProgressIndicator());
															}
														}),
												)
											],
										),
									),
								],
							),),
					),
				],
			),
		);
	}
}
