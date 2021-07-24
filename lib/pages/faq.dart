import 'package:card_app/models/faq.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class FAQ extends StatefulWidget {
	@override
	_FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(
					'FAQ',
					style: TextStyle(
						color: Colors.white
					),
				),
				backgroundColor: CustomTheme.lightTheme.primaryColor,
			),
			body: Column(
				children: <Widget>[
					Expanded(
						child: Container(
							width: double.infinity,
							padding: EdgeInsets.only(left: 16.0, right: 16.0),
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)
								)
							),
							
							child: FutureBuilder<Faq>(
							  future: ApiGraphQlServices().getFaqs(),
							  builder: (context, snapshot) {
							  	if (snapshot.hasData && snapshot.data!=null) {
										return Container(
												padding: EdgeInsets.only(top: 16.0),
												child: ListView.builder(
														itemCount: snapshot.data.faq.length,
														shrinkWrap: true,
														itemBuilder: (BuildContext context, int index) {
															var faqs = snapshot.data.faq[index];
															return Container(
																padding: EdgeInsets.only(bottom: 8.0),
																child: Card(
																	elevation: 3.0,
																	shape: RoundedRectangleBorder(
																			borderRadius: BorderRadius.circular(8.0)
																	),
																	child: GFAccordion(
																		expandedTitleBackgroundColor: Colors
																				.transparent,
																		title: '${faqs.question}',
																		content: '${faqs.answer}',
																	),
																),
															);
														}
												)
										);
									}
							  	if (snapshot.hasError){
							  		return Center(child: Text('$snapshot.error'),);
									}
							  	else {
							  		return Container(child: Center(child: CircularProgressIndicator(),),);
									}
							  }
							),
						),
					),
				],
			),
		);
	}
}
