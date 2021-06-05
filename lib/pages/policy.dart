import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class PolicyInformation extends StatefulWidget {
	@override
	_PolicyInformationState createState() => _PolicyInformationState();
}

class _PolicyInformationState extends State<PolicyInformation> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,//Color.fromRGBO(41,127,141, 25)
			
			body: Column(
				children: <Widget>[
					Expanded(
						child: Container(
							decoration: BoxDecoration(
								color: Colors.white,
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
											//margin: EdgeInsets.all(8.0),
											decoration: BoxDecoration(
												border: Border(
													bottom: BorderSide(color: Colors.grey.withOpacity(0.25), width: 1.0)
												)
											),
											child: ListTile(
												title: Text('प्रथम सेवा विन्दु/Patan Hospital'),
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
