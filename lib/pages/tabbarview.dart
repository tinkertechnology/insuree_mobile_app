import 'package:flutter/material.dart';
import 'package:card_app/services/bottom_nav_bar_service.dart';

class TabbarView extends StatefulWidget {
  @override
  _TabbarViewState createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarView> {
  @override
  Widget build(BuildContext context) {
  	// Default TabBar
    return DefaultTabController(
	    length: 10,
	    child: Scaffold(
		    body: NestedScrollView(
			    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
				    return <Widget>[
					    new SliverAppBar(
						    title: Text('Tabs Demo'),
						    pinned: true,
						    floating: true,
						    bottom: TabBar(
							    isScrollable: true,
							    tabs: [
								    Tab(child: Text('Flight')),
								    Tab(child: Text('Train')),
								    Tab(child: Text('Car')),
								    Tab(child: Text('Cycle')),
								    Tab(child: Text('Boat')),
								    Tab(child: Text('Boat')),
								    Tab(child: Text('Car')),
								    Tab(child: Text('Cycle')),
								    Tab(child: Text('Boat')),
								    Tab(child: Text('Boat')),
							    ],
						    ),
					    ),
				    ];
			    },
			    body: TabBarView(
				    children: <Widget>[
					    Icon(Icons.flight, size: 350),
					    Icon(Icons.directions_transit, size: 350),
					    Icon(Icons.directions_walk, size: 350),
					    Icon(Icons.directions, size: 350),
					    Icon(Icons.directions_bike, size: 350),
					    Icon(Icons.directions_bike, size: 350),
					    Icon(Icons.directions_walk, size: 350),
					    Icon(Icons.directions, size: 350),
					    Icon(Icons.directions_bike, size: 350),
					    Icon(Icons.directions_bike, size: 350),
				    ]
			    )
		    ),
	    )
    );
  }
}
