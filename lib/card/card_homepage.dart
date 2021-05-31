import 'package:flutter/material.dart';

import 'package:card_app/homescreen/homepage.dart';
class CardHome extends StatefulWidget {
  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
	Widget build(BuildContext context) {
		return(
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
		);
	}
}