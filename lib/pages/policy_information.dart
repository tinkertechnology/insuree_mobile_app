import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/models/insuree_policy_information.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:provider/provider.dart';

class PolicyInformationPage extends StatefulWidget {
	@override
	_PolicyInformationPageState createState() => _PolicyInformationPageState();
}

class _PolicyInformationPageState extends State<PolicyInformationPage> {
	Future<InsureePolicyInformation> _insureepolicyinformation;
	AuthBlock auth;
	
	@override
	void initState() {
        // TODO: implement initState
        super.initState();
//        _insureepolicyinformation = ApiGraphQlServices().InsureePolicyInformationServicesGQL(1);
    }
    
	@override
	Widget build(BuildContext context) {
		auth = Provider.of<AuthBlock>(context);
		
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
								  future: ApiGraphQlServices()
									  .InsureePolicyInformationServicesGQL(
									  auth.user['data']['insureeAuthOtp']['token'],
									  auth.user['data']['insureeAuthOtp']['insuree']['chfId']
								  ),

								  builder: (context, snapshot) {
								  	if(snapshot.hasData) {
											return ListView.builder(
													itemCount: snapshot.data.data.insureeProfile.insureePolicies.length,
													itemBuilder: (BuildContext context, int index) {
														var _data = snapshot.data.data.insureeProfile.insureePolicies[index];
														return _policyInformationListWidget(_data);
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
	
	Widget _policyInformationListWidget(_data){
		return Container(
			margin: EdgeInsets.only(left: 8.0, right: 8.0),
			decoration: BoxDecoration(
				border: Border(
					bottom: BorderSide(
						color: Colors.grey.withOpacity(0.5),
						width: 1.0,
					),
				),
			),
			child: ListTile(
				title: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
                            '${_data.insuree.healthFacility.name}',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                            ),
                        )
					],
				),
				leading: Text(
                    '${_data.insuree.healthFacility.code}',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                    ),
                ),
				subtitle: Text(
                    'Expiry date: ${_data.policy.expiryDate.year}-${_data.policy.expiryDate.month}-${_data.policy.expiryDate.day}',
                ),
				trailing: Column(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					mainAxisSize: MainAxisSize.min,
					children: [
						Text(
                            '${env.Currency} ${_data.policy.value}',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
						SizedBox(height: 16.0),
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
}
