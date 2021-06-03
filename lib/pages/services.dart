import 'package:card_app/models/medical_services.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
	@override
	_ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
	Future<MedicalServices> _medicalservices;
	@override
	initState(){
		super.initState();
		_medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');
	}



	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			body: Column(
				children: <Widget>[
					Expanded(
						child: Container(
							padding: EdgeInsets.only(left: 20.0, right: 20.0),
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(30),
									topRight: Radius.circular(30)
								)
							),
							child: FutureBuilder<MedicalServices>(
								future: _medicalservices,
								builder: (context, snapshot) {
									if(snapshot.hasData) {
										return ListView.builder(
											itemCount: snapshot.data.data.medicalServicesStr.edges.length,
											itemBuilder: (BuildContext context, int index) {
												var medical_services = snapshot.data.data
													.medicalServicesStr.edges[index];
												return Container(
													decoration: BoxDecoration(
														border: Border(
															bottom: BorderSide(
																color: Colors.grey.withOpacity(0.25),
																width: 1.0
															),
														),
													),
													child: InkWell(
														onTap: (){
															print('${medical_services.node.name} $index');
														},
														child: ListTile(
															title: Text(
																'${medical_services.node.name} $index',
																style: TextStyle(
																	fontSize: 16.0,
																	fontWeight: FontWeight.normal
																),
																maxLines: 3,
															),
															trailing: Icon(Icons.arrow_forward_ios),
														),
													)
												);
											}
										
										);
									}
									else{
										return Center(child: CircularProgressIndicator());
									}
								}
							),
						)
					)
				],
			),
		);
	}
	
	List<Widget> _getServices() {
		List<Widget> service = [];
		service.add(
			_getService('M1 OBG Cervical Cerclage - Shrodikar')
		);
		return service;
	}
	
	Widget _getService(String service) {
		return Container(
			padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
			decoration: BoxDecoration(
				border: Border(
					bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.0)
				)
			),
			child: GestureDetector(
				onTap: (){
					print("Tab View clicked");
				},
				
				child: FutureBuilder<MedicalServices>(
					future: _medicalservices,
					builder: (context, snapshot) {
						if(snapshot.hasData) {
							return ListView.builder(
//												controller: scrollController,
								itemCount: snapshot.data.data.medicalServicesStr.edges.length,
								itemBuilder: (BuildContext context, int index) {
									var medical_services = snapshot.data.data
										.medicalServicesStr.edges[index];
									return
										Text('${medical_services.node.name} $index');
								}
							
							);
						}
						else{
							return Center(child: CircularProgressIndicator());
						}
					}
				),
			)
		);
	}
}
