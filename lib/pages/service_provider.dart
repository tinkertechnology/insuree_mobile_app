import '../language_config_i18n/app_translation.dart';
import '../language_config_i18n/application.dart';
import 'package:openimis_web_app/models/health_facility_coordinates.dart';
import 'package:openimis_web_app/models/user_location.dart';
import 'package:openimis_web_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:openimis_web_app/services/api_graphql_services.dart';
import 'package:provider/provider.dart';


class ServiceProviderPage extends StatefulWidget {
	@override
	_ServiceProviderPageState createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
	Future<HealthFacilityCoordinates> _healthFacilityCoordinates;
	bool _isLoad=false;
	@override
	initState(){
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
					AppTranslations.of(context).text('service_provider_list'),
					style: TextStyle(
						color: Colors.white
					),
				),
				backgroundColor: CustomTheme.lightTheme.primaryColor,
			),
			body:  Column(
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
												_HealthFacilities()
											],
										),
									),
								],
							),
						),
					),
				],
			),
		);
	}
	
	Widget _HealthFacilities(){
		return Container(
			child: FutureBuilder<HealthFacilityCoordinates>(
				future: _healthFacilityCoordinates,
				builder: (context, snapshot) {
					if (snapshot.hasData && snapshot.data.data!=null) {
						return ListView.builder(
							shrinkWrap: true,
							physics: NeverScrollableScrollPhysics(),
							itemCount: snapshot.data.data.healthFacilityCoordinate.length,
							itemBuilder: (BuildContext context, int index) {
								var item = snapshot.data.data.healthFacilityCoordinate[index];
								return Container(
									padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
									child: Card(
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(0.0),
										),
										elevation: 5,
										shadowColor: CustomTheme.lightTheme.primaryColor,
										child: Container(
											padding: EdgeInsets.only(left: 16.0),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisSize: MainAxisSize.max,
												children: [
													ListTile(
														title: Text(
															'${item.healthFacility.name}',
															style: TextStyle(
																fontSize: 16.0,
																fontWeight: FontWeight.normal
															),
														),
														
														subtitle: Padding(
															padding: EdgeInsets.only(top: 8.0),
															child: Text(
																'About ' + '${item.distance} ' + 'kms',
																style: TextStyle(
																	fontSize: 14.0,
																	fontWeight: FontWeight.w400,
																),
															),
														)
													),
												],
											),
										),
									)
								);
							});
					}

					else {
						return Container(child: Center(
								child: CircularProgressIndicator()));
					}
				}),
		);
	}
}
