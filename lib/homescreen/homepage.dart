import 'dart:convert';

import 'package:card_app/homescreen/homepage_link_sync_event.dart';
import 'package:card_app/localization/language/languages.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:card_app/pages/claimed_item_services.dart';
import 'package:card_app/profile/profile_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/models/claimeditems.dart';
import 'package:card_app/services/api_graphql_services.dart';





class HomeScreen extends StatefulWidget {
	@override
	_HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


	Future<MedicalServices> _medicalservices;
	Future<Claims> _insureeclaims;
	Future<Claimed> _claimed;


	@override
	void initState() {
		super.initState();

		_medicalservices =
				ApiGraphQlServices().MedicalServicesGQL('medicalservice');
		_insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();
	}

	@override
	Widget build(BuildContext context) {
		final orientation = MediaQuery
				.of(context)
				.orientation;
		return DraggableScrollableSheet(
			initialChildSize: 0.65,
			minChildSize: 0.03,
			maxChildSize: 0.65,
			builder: (BuildContext context, ScrollController scrollController) {
				return Container(
					width: double.infinity,
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(
								topLeft: Radius.circular(10),
								topRight: Radius.circular(10)
						),
						color: Color.fromRGBO(234, 239, 255, 1),
					),
					child: FutureBuilder<Claims>(
							future: _insureeclaims,
							builder: (context, snapshot) {
								if (snapshot.hasData && snapshot.data.data != null) {
									return ListView.builder(
											controller: scrollController,
											itemCount: snapshot.data.data.insureeProfile.insureeClaim
													.length,
											itemBuilder: (BuildContext context, int index) {
												var claims = snapshot.data.data.insureeProfile
														.insureeClaim
												[index];
												return ListTile(
													trailing: Text('${env.Currency} ${claims.claimed}'),
													title: Text('${claims.dateClaimed}'),
													subtitle: Text('${claims.healthFacility.name}'),
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
								else {
									return Center(child: CircularProgressIndicator());
								}
							}
					),
				);
			},
		);
	}
}