import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
	@override
	_HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: PreferredSize(
				child: AppBar(
					backgroundColor: Color.fromRGBO(0, 103, 35, 50),
					elevation: 0,
				),
				preferredSize: Size.fromHeight(0),
			),
			body: CustomScrollView(
				slivers: <Widget>[
					SliverAppBar(
						title: Text('History'),
						backgroundColor: Color.fromRGBO(41,127,141,50),
						centerTitle: false,
					),
					SliverList(
						delegate: SliverChildListDelegate(_getHistorys()),
					)
				],
			),
		);
	}
	
	List<Widget> _getHistorys() {
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
			padding: EdgeInsets.all(8),
			color: Color.fromRGBO(126,174,183, 100), //Color.fromRGBO(234, 239, 255, 50),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisSize: MainAxisSize.max,
				children: <Widget>[
					Padding(
						padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
						child: Text(
							date, // 'Fri, May 28th',
							style: TextStyle(
								fontSize: 16.0,
								fontWeight: FontWeight.bold
							),
						),
					),
					Card(
						shape: RoundedRectangleBorder(
							side: BorderSide(color: Colors.white, width: 1),
							borderRadius: BorderRadius.circular(20)
						),
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
														history, //"Paid for A01 Typhoid and paratyphoid fevers",
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
