import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
	@override
	_ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: CustomTheme.lightTheme.primaryColor,
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
											delegate: SliverChildListDelegate(_getServices()),
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
	
	List<Widget> _getServices() {
		List<Widget> service = [];
		service.add(
			_getService('M1 OBG Cervical Cerclage - Shrodikar')
		);
		service.add(
			_getService('M2 OBG Cervix Repair')
		);
		service.add(
			_getService('M3 OBG Colpotomy')
		);
		service.add(
			_getService('M4 OBG Mursupialisation')
		);
		service.add(
			_getService('M5 OBG Perineal / Genital Repair')
		);
		service.add(
			_getService('M6 OBG Polypectomy - Cervical')
		);
		service.add(
			_getService('M7 OBG Surgical Toilet and Suture for 3rd Degree Tears')
		);
		service.add(
			_getService('M8 SUR Anal Dilatation')
		);
		service.add(
			_getService('M9 SUR Biopsy - Incisional')
		);
		service.add(
			_getService('M10 SUR Biopsy - Lymph Node')
		);
		service.add(
			_getService('M6 OBG Polypectomy - Cervical')
		);
		service.add(
			_getService('M7 OBG Surgical Toilet and Suture for 3rd Degree Tears')
		);
		service.add(
			_getService('M8 SUR Anal Dilatation')
		);
		service.add(
			_getService('M9 SUR Biopsy - Incisional')
		);
		service.add(
			_getService('M10 SUR Biopsy - Lymph Node')
		);
		
		return service;
	}
	
	Widget _getService(String service) {
		/*return Container(
			color: Color.fromRGBO(234, 239, 255, 100),
			// Color.fromRGBO(234, 239, 255, 50),
			// margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
			child: Card(
				elevation: 8.0,
				margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
				child: Container(
					padding: EdgeInsets.all(8.0),
					decoration: BoxDecoration(
						color: Color.fromRGBO(126,174,183,50)
					),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						mainAxisSize: MainAxisSize.min,
						children: <Widget>[
							Container(
								padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
								child: GestureDetector(
									onTap: (){
										print("Tab View clicked");
										// Navigator.pushNamed(context, '/tab-view');
									},
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										mainAxisSize: MainAxisSize.max,
										children: <Widget>[
											Expanded(
												child: Text(
													service, //"Address"
													style: TextStyle(
														fontSize: 16.0,
														fontWeight: FontWeight.w400,
													),
												),
											),
											
											Icon(Icons.arrow_forward_ios, size: 25)
										],
									),
								)
							),
						],
					),
				)
			),
		);*/
		
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
				
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					mainAxisSize: MainAxisSize.max,
					children: <Widget>[
						Expanded(
							child: Text(
								service,
								style: TextStyle(
									fontSize: 16,
									fontWeight: FontWeight.normal
								),
								maxLines: 3,
							),
						),
						SizedBox(width: 8.0),
						Icon(
							Icons.arrow_forward_ios,
							size: 25,
							color: CustomTheme.lightTheme.accentColor,
						)
					],
				),
			)
		);
	}
}
