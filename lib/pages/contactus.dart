import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import '../screen_size_reducers.dart';

class ContactUsPage extends StatefulWidget {
	@override
	_ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(
					'Contact Us',
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
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)
								)
							),
							child: DefaultTabController(
								length: 3,
								child: Container(
									padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
									child: Column(
										children: <Widget>[
											TabBar(
												indicatorColor: CustomTheme.lightTheme.accentColor,
												indicatorWeight: 2,
												tabs: [
													Tab(
														child: Text(
															'EA Contact',
															style: TextStyle(
																fontSize: 14,
																fontWeight: FontWeight.w400,
																color: Colors.black
															),
														),
													),
													Tab(
														child: Text(
															'EO Contact',
															style: TextStyle(
																fontSize: 14,
																fontWeight: FontWeight.w400,
																color: Colors.black
															),
														),
													),
													Tab(
														child: Text(
															'PO Contact',
															style: TextStyle(
																fontSize: 14,
																fontWeight: FontWeight.w400,
																color: Colors.black
															),
														),
													),
												],
											),
											
											Container(
												height: screenHeight(context, dividedBy: 1.26),
												padding: EdgeInsets.only(top: 8.0),
												child: TabBarView(
													children: [
														Container(
															child: ListView.builder(
																itemBuilder: (BuildContext context, int index){
																	return Container(
																		padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
																		child: Card(
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(0.0),
																				// side: BorderSide(color: CustomTheme.lightTheme.primaryColor),
																			),
																			elevation: 5,
																			shadowColor: CustomTheme.lightTheme.primaryColor,
																			child: Container(
																				padding: EdgeInsets.fromLTRB(24, 16, 16, 16),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					mainAxisSize: MainAxisSize.max,
																					children: [
																						Text(
																							'Kathmandu Branch',
																							style: TextStyle(
																								fontSize: 16.0,
																								letterSpacing: 0.5,
																								fontWeight: FontWeight.bold,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'Kathmandu, Nepal',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'openimis@gmail.com',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'01-42xxxxx',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																					],
																				),
																			),
																		)
																	);
																}
															),
														),
														
														Container(
															child: ListView.builder(
																itemBuilder: (BuildContext context, int index){
																	return Container(
																		padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
																		child: Card(
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(0.0),
																				// side: BorderSide(color: CustomTheme.lightTheme.primaryColor),
																			),
																			elevation: 5,
																			shadowColor: CustomTheme.lightTheme.primaryColor,
																			child: Container(
																				padding: EdgeInsets.fromLTRB(24, 16, 16, 16),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					mainAxisSize: MainAxisSize.max,
																					children: [
																						Text(
																							'Kathmandu Branch',
																							style: TextStyle(
																								fontSize: 16.0,
																								letterSpacing: 0.5,
																								fontWeight: FontWeight.bold,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'Kathmandu, Nepal',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'openimis@gmail.com',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'01-42xxxxx',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																					],
																				),
																			),
																		)
																	);
																}
															),
														),
														
														Container(
															child: ListView.builder(
																itemBuilder: (BuildContext context, int index){
																	return Container(
																		padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
																		child: Card(
																			shape: RoundedRectangleBorder(
																				borderRadius: BorderRadius.circular(0.0),
																				// side: BorderSide(color: CustomTheme.lightTheme.primaryColor),
																			),
																			elevation: 5,
																			shadowColor: CustomTheme.lightTheme.primaryColor,
																			child: Container(
																				padding: EdgeInsets.fromLTRB(24, 16, 16, 16),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					mainAxisSize: MainAxisSize.max,
																					children: [
																						Text(
																							'Kathmandu Branch',
																							style: TextStyle(
																								fontSize: 16.0,
																								letterSpacing: 0.5,
																								fontWeight: FontWeight.bold,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'Kathmandu, Nepal',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'openimis@gmail.com',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																						SizedBox(height: 4.0),
																						Text(
																							'01-42xxxxx',
																							style: TextStyle(
																								fontSize: 14.0,
																								fontWeight: FontWeight.normal,
																							),
																						),
																					],
																				),
																			),
																		)
																	);
																}
															),
														),
													],
												),
											)
										],
									),
								),
							),
						),
					),
				],
			),
		);
		
		/*return DefaultTabController(
			length: 3,
			child: Scaffold(
				body: NestedScrollView(
					headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
						return <Widget>[
							new SliverAppBar(
								title: Text('Contact us'),
								bottom: TabBar(
									tabs: [
										Tab(child: Text('EA Contact')),
										Tab(child: Text('EO Contact')),
										Tab(child: Text('PC Contact')),
									],
								),
							),
						];
					},
					body: TabBarView(
						children: <Widget>[
							Icon(Icons.flight, size: 350),
							Icon(Icons.directions_transit, size: 350),
							Icon(Icons.directions_walk, size: 350),
						]
					)
				),
			)
		);*/
	}
}
