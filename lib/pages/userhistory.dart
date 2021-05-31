import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class UserHistory extends StatefulWidget {
	@override
	_UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
			appBar: AppBar(
				elevation: 0.0,
				title: Text(
					'User History',
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
								padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
								child: CustomScrollView(
									slivers: <Widget>[
										SliverList(
											delegate: SliverChildListDelegate(_getHistories()),
										)
									],
								),
							)
						)
					)
				],
			),
		);
	}
	
	List<Widget> _getHistories() {
		List<Widget> history = [];
		history.add(
			_getHistory('Paid for A01 Typhoid and paratyphoid fevers', 'Fri, May 28th', '400.00', '11:45', false)
		);
		history.add(
			_getHistory('Paid for M7 OBG Surgical Toilet and Suture for 3rd Degree Tears', 'Thur, May 27th', '4000.00', '09:15', false)
		);
		history.add(
			_getHistory('Paid for 0001 ACETYLSALICYLIC ACID (ASPIRIN)  TABS 300MG', 'Tue, May 25th', '600.00', '14:25', false)
		);
		history.add(
			_getHistory('Paid for A01 Typhoid and paratyphoid fevers', 'Mon, May 24th', '400.00', '16:32', false)
		);
		history.add(
			_getHistory('Paid for A01 Typhoid and paratyphoid fevers', 'Sun, May 23th', '200.00', '10:15', false)
		);
		history.add(
			_getHistory('Paid for A01 Typhoid and paratyphoid fevers', 'Fri, May 28th', '400.00', '11:45', false)
		);
		history.add(
			_getHistory('Paid for M7 OBG Surgical Toilet and Suture for 3rd Degree Tears', 'Thur, May 27th', '4000.00', '09:15', false)
		);
		history.add(
			_getHistory('Paid for 0001 ACETYLSALICYLIC ACID (ASPIRIN)  TABS 300MG', 'Tue, May 25th', '600.00', '14:25', false)
		);
		history.add(
			_getHistory('Paid for A01 Typhoid and paratyphoid fevers', 'Mon, May 24th', '400.00', '16:32', false)
		);
		history.add(
			_getHistory('Paid for A01 Typhoid and paratyphoid fevers', 'Sun, May 23th', '200.00', '10:15', false)
		);
		return history;
	}
	
	Widget _getHistory(String history, String date, String price, String time, bool hasStory) {
		return Container(
			padding: EdgeInsets.all(2),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.max,
				children: <Widget>[
					Padding(
						padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
						child: Text(
							date, // 'Fri, May 28th',
							style: TextStyle(
								fontSize: 14.0,
								fontWeight: FontWeight.bold
							),
						),
					),
					Card(
						shape: RoundedRectangleBorder(
							// side: BorderSide(color: Colors.white, width: 1),
							borderRadius: BorderRadius.circular(20)
						),
						color: CustomTheme.lightTheme.accentColor.withOpacity(1),
						child: Container(
							padding: EdgeInsets.all(16),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisSize: MainAxisSize.max,
								children: <Widget>[
									Container(
										child: Row(
											mainAxisAlignment: MainAxisAlignment.spaceEvenly,
											mainAxisSize: MainAxisSize.min,
											children: <Widget>[
												Expanded(
													flex: 5,
													child: Text(
														history,
														style: TextStyle(
															fontSize: 14.0,
															fontFamily: "Open-sans",
															fontWeight: FontWeight.w400
														),
													),
												),
												
												Expanded(
													child: Text(
														'Rs.' + price, //"400.00",
														style: TextStyle(
															fontSize: 14.0,
															fontFamily: "Open-sans",
															fontWeight: FontWeight.bold,
															color: Colors.green
														),
													),
												),
											],
										),
									),
									SizedBox(height: 8.0),
									Text(
										time, //"General",
										style: TextStyle(
											fontSize: 14.0,
											fontFamily: "Open-sans",
											fontWeight: FontWeight.w600
										),
									)
								],
							),
						),
					),
				],
			)
		);
	}
}

