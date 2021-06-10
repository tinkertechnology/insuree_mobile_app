import 'package:card_app/models/insuree_policy_information.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/models/policy_information.dart';
import 'package:card_app/services/api_graphql_services.dart';

class PolicyInformationPage extends StatefulWidget {
	@override
	_PolicyInformationPageState createState() => _PolicyInformationPageState();
}

class _PolicyInformationPageState extends State<PolicyInformationPage> {
	Future<InsureePolicyInformation> _insureepolicyinformation;
	@override
	void initState() {
    // TODO: implement initState
    super.initState();
    _insureepolicyinformation = ApiGraphQlServices().InsureePolicyInformationServicesGQL(1);
  }
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,//Color.fromRGBO(41,127,141, 25)
			body: Column(
				children: <Widget>[
					Expanded(
						child: Container(
							decoration: BoxDecoration(
								color: CustomTheme.lightTheme.backgroundColor,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)
								)
							),
							child: Padding(
								padding: const EdgeInsets.only(top: 8.0),

								child: FutureBuilder<InsureePolicyInformation>(
								  future: _insureepolicyinformation,

								  builder: (context, snapshot) {
								  	if(snapshot.hasData) {
											return ListView.builder(
													itemCount: snapshot.data.data.insureeProfile.insureePolicies.length,
													itemBuilder: (BuildContext context, int index) {
														var _data = snapshot.data.data.insureeProfile.insureePolicies[index];
														return Container(
															margin: EdgeInsets.only(left: 16.0, right: 16.0),
															decoration: BoxDecoration(
																	border: Border(
																			bottom: BorderSide(
																					color: Colors.grey.withOpacity(0.5),
																					width: 1.0)
																	)
															),
															child: ListTile(
																title: Column(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		//Text(_data.policy.value.toString()),
																		Text('Health Facility Name')
																	],
																),
																leading: Text('HIB-3500'),
																subtitle: Text('Expiry date: ' + _data.policy.expiryDate.toString()),
																trailing: Row(
																	mainAxisAlignment: MainAxisAlignment
																			.spaceBetween,
																	mainAxisSize: MainAxisSize.min,
																	children: [
																		Text(_data.policy.value.toString()),
																		SizedBox(width: 4.0),
																		Text(
																			_data.policy.status.toString(),
																			style: TextStyle(
																				fontSize: 16.0,
																				fontWeight: FontWeight.bold,
																				color: CustomTheme.lightTheme.primaryColor
																			),
																		),
																	],
																),
															),
														);
													}
											);
										}
								  	else {
								  		return Center(child: CircularProgressIndicator(),);
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
}
