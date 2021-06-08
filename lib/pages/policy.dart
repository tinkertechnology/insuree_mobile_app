import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/models/policy_information.dart';
import 'package:card_app/services/api_graphql_services.dart';

class PolicyInformationPage extends StatefulWidget {
	@override
	_PolicyInformationPageState createState() => _PolicyInformationPageState();
}

class _PolicyInformationPageState extends State<PolicyInformationPage> {

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
								child: ListView.builder(
									itemBuilder: (BuildContext context, int index){
										return Container(
											margin: EdgeInsets.only(left: 16.0, right: 16.0),
											decoration: BoxDecoration(
												border: Border(
													bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0)
												)
											),
											child: ListTile(
												title: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Text('प्रथम सेवा विन्दु'),
														Text('Patan Hospital')
													],
												),
												leading: Text('HIB-3500'),
												subtitle: Text('Expiry date: 2021-06-04'),
												trailing: Row(
													mainAxisAlignment: MainAxisAlignment.spaceBetween,
													mainAxisSize: MainAxisSize.min,
													children: [
														Text('Balance'),
														SizedBox(width: 4.0),
														Text('Status')
													],
												),
											),
										);
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
