import 'package:card_app/models/office.dart';
import 'package:card_app/services/api_graphql_services.dart';
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
							child: FutureBuilder<Offices>(
							  future: ApiGraphQlServices().getOfficesList(),
							  builder: (context, snapshot) {
                  
                  if(snapshot.hasData){
							    return Padding(
							    	padding: const EdgeInsets.all(16.0),
							    	child: ListView.builder(
                      itemCount: snapshot.data.branchOfficeDetails.length,
							    		itemBuilder: (BuildContext context, int index){
                        var offices = snapshot.data.branchOfficeDetails[index];

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
																			offices.name,
							    									style: TextStyle(
							    										fontSize: 16.0,
							    										letterSpacing: 0.5,
							    										fontWeight: FontWeight.bold,
							    									),
							    								),
							    								SizedBox(height: 4.0),
							    								  Text(
							    								  	offices.address,
							    								  	style: TextStyle(
							    								  		fontSize: 14.0,
							    								  		fontWeight: FontWeight.normal,
							    								  	),
							    								  ),
							    								  SizedBox(height: 4.0),
							    								  Text(
							    								  	offices.email,
							    								  	style: TextStyle(
							    								  		fontSize: 14.0,
							    								  		fontWeight: FontWeight.normal,
							    								  	),
							    								  ),
							    								  SizedBox(height: 4.0),
							    								  Text(
							    								  	offices.phone.toString(),
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
							    	)
							    );
                }
                else{
                  return Center(child: CircularProgressIndicator());
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
