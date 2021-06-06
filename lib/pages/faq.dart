import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class FAQ extends StatefulWidget {
	@override
	_FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
	List<ItemModel> itemData = <ItemModel>[
		ItemModel(
			headerItem: 'What is Android ?',
			description:
			"Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google."
		),
	
	];
	
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
							
							/*child: Container(
								padding: EdgeInsets.all(10),
								child: ListView.builder(
									shrinkWrap: true,
									physics: ScrollPhysics(),
									itemCount: itemData.length,
									itemBuilder: (BuildContext context, int index) {
										return ExpansionPanelList(
											children: [
												ExpansionPanel(
													body: Container(
														padding: EdgeInsets.all(16.0),
														child: Column(
															mainAxisAlignment: MainAxisAlignment.spaceBetween,
															crossAxisAlignment: CrossAxisAlignment.start,
															children: <Widget>[
																Text(
																	itemData[index].description,
																	style: TextStyle(
																		color: Colors.grey[700],
																		fontSize: 15,
																		letterSpacing: 0.3,
																		height: 1.3
																	),
																	textAlign: TextAlign.justify,
																),
															],
														),
													),
													headerBuilder: (BuildContext context, bool isExpanded) {
														return Container(
															padding: EdgeInsets.all(10),
															child: Text(
																itemData[index].headerItem,
																style: TextStyle(
																	fontSize: 18,
																),
															),
														);
													},
													//backgroundColor: CustomTheme.lightTheme.accentColor.withOpacity(0.86),
													canTapOnHeader: true,
													isExpanded: itemData[index].isExpanded,
												)
											],
											expansionCallback: (int item, bool status) {
												setState(() {
													itemData[index].isExpanded = !itemData[index].isExpanded;
												});
											},
										);
									},
								),
							),*/
							
							child: Container(
								padding: EdgeInsets.only(top: 16.0),
								child: ListView.builder(
									itemCount: 20,
									shrinkWrap: true,
									itemBuilder: (BuildContext context, int index){
										return Container(
											padding: EdgeInsets.only(bottom: 8.0),
											child: Card(
												elevation: 3.0,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(8.0)
												),
												child: GFAccordion(
													expandedTitleBackgroundColor: Colors.transparent,
													title: 'Accordion 1',
													content: 'GetFlutter is an open source library that comes with pre-build 1000+ UI components.',
												),
											),
										);
									}
								)
							),
						),
					),
				],
			),
		);
	}
}


class ItemModel {
	bool isExpanded;
	String headerItem;
	String description;
	
	ItemModel({this.isExpanded: false, this.headerItem, this.description});
}