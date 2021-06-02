import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/insuree_claims.dart';

class HistoryPage extends StatefulWidget {
	@override
	_HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
	Future<MedicalServices> _medicalservices;
	Future<Claims> _insureeclaims;
	Future<Claimed> _claimed;
	@override
	void initState(){
		super.initState();
		_medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');
		_insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();
		_claimed = ApiGraphQlServices().ClaimedServicesGQL();
		
	}
	
	@override
	Widget build(BuildContext context) {
		return Stack(
			fit: StackFit.expand,
			children: [
				ListView(
					scrollDirection: Axis.vertical,
					shrinkWrap: true,
					children: [
						// OPENIMIS LOGO, CURRENT BALANCE & CARD
						Stack(
							children: [
								// OPENIMIS LOGO & CURRENT BALANCE
								Container(
									height: 220,
									padding: EdgeInsets.all(20),
									width: double.infinity,
									decoration: BoxDecoration(
										borderRadius: BorderRadius.only(
											bottomLeft: Radius.circular(10),
											bottomRight: Radius.circular(10)
										),
										gradient: LinearGradient(
											begin: Alignment.topLeft,
											end: Alignment.bottomRight,
											colors: [
												CustomTheme.lightTheme.primaryColor,
												CustomTheme.lightTheme.splashColor
											]
										),
									),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										mainAxisSize: MainAxisSize.min,
										children: <Widget>[
											Expanded(
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: <Widget>[
														CircleAvatar(
															radius: 30,
															backgroundColor: Colors.white,
															child: ClipOval(
																child: Image.asset("assets/images/openimis-logo.png", fit: BoxFit.contain,),
															),
														),
														SizedBox(height: 8),
														Expanded(
															child: Text(
																'Hari Bahadur Thapa Magar',
																style: TextStyle(
																	fontSize: 14,
																	fontWeight: FontWeight.normal,
																	color: Colors.white
																),
																maxLines: 3,
															),
														)
													],
												),
											),
											
											VerticalDivider(
												thickness: 1.5,
												color: Colors.white,
											),
											
											Expanded(
												child: Column(
													crossAxisAlignment: CrossAxisAlignment.end,
													mainAxisSize: MainAxisSize.max,
													children: <Widget>[
														Text(
															'Current Balance',
															style: TextStyle(
																fontSize: 14,
																fontWeight: FontWeight.normal,
																color: Colors.white
															),
														),
														SizedBox(height: 8.0),
														Text(
															'Rs. 450.00',
															style: TextStyle(
																fontSize: 16,
																fontWeight: FontWeight.bold,
																color: Colors.white
															),
														),
														SizedBox(height: 4.0),
														Divider(
															indent: 20.0,
															thickness: 1.5,
															color: Colors.white,
														),
														SizedBox(height: 4.0),
														Text(
															'Valid until: 2023-02-21',
															style: TextStyle(
																fontSize: 14,
																fontWeight: FontWeight.normal,
																color: Colors.white
															),
														),
														SizedBox(height: 8.0),
														Text(
															'First Service Name',
															style: TextStyle(
																fontSize: 14,
																fontWeight: FontWeight.normal,
																color: Colors.white
															),
														)
													],
												),
											),
										],
									),
								),
								
								// CARD
								Container(
									height: 130,
									width: double.infinity,
									padding: EdgeInsets.all(10.0),
									margin: EdgeInsets.only(top: 150),
									child: Card(
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(20)
										),
										child: Padding(
											padding: EdgeInsets.all(8),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												mainAxisSize: MainAxisSize.max,
												children: <Widget>[
													Icon(Icons.access_time),
													Icon(Icons.notifications),
													Icon(Icons.calendar_today)
												],
											),
										)
									),
								),
							],
						),
						
						// HISTORY & VIEW ALL
						Container(
							padding: EdgeInsets.only(left: 16.0, right: 16.0),
							margin: EdgeInsets.only(top: 8.0),
							child: ListTile(
								title: Text(
									'History',
									style: TextStyle(
										fontSize: 18.0,
										fontWeight: FontWeight.normal
									),
								),
								leading: Icon(Icons.history, color: Colors.green, size: 30,),
								trailing: Text(
									'View All',
									style: TextStyle(
										fontSize: 16.0,
										fontWeight: FontWeight.normal
									),
								),
							),
						),
						
						// HISTORY ITEMS
						Container(
							padding: EdgeInsets.only(left: 16.0, right: 16.0),
							margin: EdgeInsets.only(top: 8.0),
							child: Column(
								children: [
									ListTile(
										title: Text('Hospital Name'),
										subtitle: Text('Service 1'),
										leading: Icon(Icons.notifications),
										trailing: Text('Rs. 400'),
									),
									ListTile(
										title: Text('Hospital Name'),
										subtitle: Text('Service 1'),
										leading: Icon(Icons.notifications),
										trailing: Text('Rs. 400'),
									),
									ListTile(
										title: Text('Hospital Name'),
										subtitle: Text('Service 1'),
										leading: Icon(Icons.notifications),
										trailing: Text('Rs. 400'),
									),
									ListTile(
										title: Text('Hospital Name'),
										subtitle: Text('Service 1'),
										leading: Icon(Icons.notifications),
										trailing: Text('Rs. 400'),
									),
									ListTile(
										title: Text('Hospital Name'),
										subtitle: Text('Service 1'),
										leading: Icon(Icons.notifications),
										trailing: Text('Rs. 400'),
									),
								],
							)
						),
					],
				),
				
				DraggableScrollableSheet(
					initialChildSize: 0.05,
					minChildSize: 0.05,
					maxChildSize: 0.05,
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
									if(snapshot.hasData) {
										return ListView.builder(
											controller: scrollController,
											itemCount: snapshot.data.data.insureeProfile.insureeClaim.length,
											itemBuilder: (BuildContext context, int index) {
											var claims = snapshot.data.data.insureeProfile.insureeClaim[index];
											return ListTile(
													title: Text('${claims.dateClaimed}'),
											);
										});
									} else{
										return Center(child: CircularProgressIndicator());
									}
								}
							),
						);
					},
				),
			],
		);
	}
}
