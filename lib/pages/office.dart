import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class OfficePage extends StatefulWidget {
	@override
	_OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(
					'Offices',
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
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)
								)
							),
							child: Padding(
								padding: const EdgeInsets.all(16.0),
								child: ListView.builder(
									itemBuilder: (BuildContext context, int index){
										return Container(
											padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
											/*decoration: BoxDecoration(
												border: Border(
													bottom: BorderSide(color: Colors.orangeAccent)
												)
											),*/
											child: Card(
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(10.0),
													// side: BorderSide(color: CustomTheme.lightTheme.primaryColor),
												),
												elevation: 5,
												shadowColor: CustomTheme.lightTheme.primaryColor,
												child: Container(
													padding: EdgeInsets.all(16.0),
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														mainAxisSize: MainAxisSize.max,
														children: [
															Text(
																'openIMIS',
																style: TextStyle(
																	fontSize: 16.0,
																	fontWeight: FontWeight.normal,
																),
															),
															SizedBox(height: 4.0),
															Text(
																'Kathmandu, Nepal',
																style: TextStyle(
																	fontSize: 16.0,
																	fontWeight: FontWeight.normal,
																),
															),
															SizedBox(height: 4.0),
															Text(
																'openimis@gmail.com',
																style: TextStyle(
																	fontSize: 16.0,
																	fontWeight: FontWeight.normal,
																),
															),
															SizedBox(height: 4.0),
															Text(
																'01-42xxxxx',
																style: TextStyle(
																	fontSize: 16.0,
																	fontWeight: FontWeight.normal,
																),
															),
														],
													),
												),
											)
										);
									}
								)
								),
							)
						),
				],
			),
		);
	}
}
