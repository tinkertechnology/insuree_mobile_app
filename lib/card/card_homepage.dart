import 'package:flutter/material.dart';

import 'package:card_app/homescreen/homepage.dart';
class CardHome extends StatefulWidget {
  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
	Widget build(BuildContext context) {
		/*return(
			SingleChildScrollView(
				child: Container(
					padding: const EdgeInsets.all(0.0),
					child: Center(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							children: <Widget>[
								HomeScreen(),
							],
						),
					),
				),
			)
		);*/
		return Stack(
			children: <Widget>[
				Container(
					height: 200,
					padding: EdgeInsets.all(20),
					width: double.infinity,
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(
							bottomLeft: Radius.circular(10),
							bottomRight: Radius.circular(10)
						),
						/*gradient: LinearGradient(
							begin: Alignment.topLeft,
							end: Alignment.bottomRight,
							colors: [
								CustomTheme.lightTheme.primaryColor,
								CustomTheme.lightTheme.splashColor,
								CustomTheme.lightTheme.accentColor
							]
						),*/
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
				Container(
					height: 130,
					width: double.infinity,
					padding: EdgeInsets.all(10.0),
					margin: EdgeInsets.only(top: 130),
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
				
				Container(
					padding: EdgeInsets.all(20),
					margin: EdgeInsets.only(top: 250),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								mainAxisSize: MainAxisSize.max,
								children: <Widget>[
									Text("History"),
									Text('View All')
								],
							),
						],
					),
				),
				HomeScreen()
			],
		);
	}
}