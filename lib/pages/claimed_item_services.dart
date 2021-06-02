import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool hasNotification = false;
  @override
  Widget build(BuildContext context) {
	  return Scaffold(
		  backgroundColor: CustomTheme.lightTheme.primaryColor,
		  appBar: AppBar(
			  elevation: 0.0,
			  title: Text(
				  'Claimed Item Services',
				  style: TextStyle(
					  color: Colors.white
				  ),
			  ),
			  backgroundColor: CustomTheme.lightTheme.primaryColor,
		  ),
		  /*body: CustomScrollView(
			  slivers: <Widget>[
				  SliverAppBar(
					  title: Text('Notifications'),
					  backgroundColor: Color.fromRGBO(41,127,141,50), //Colors.white,
					  centerTitle: false,
					  actions: <Widget>[
						  Container(
							  child: IconButton(
								  icon: Icon(Icons.notifications),
								  color: Colors.black,
								  disabledColor: Colors.black,
								  splashColor: Theme.of(context).accentColor,
								  onPressed: () {},
							  ),
						  ),
						  Padding(
							  padding: EdgeInsets.only(right: 10),
						  ),
					  ]),
				  SliverList(
					  delegate: SliverChildListDelegate(_getNotifications()),
				  )
			  ],
		  ),*/
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
										  delegate: SliverChildListDelegate(_getNotifications()),
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

  List<Widget> _getNotifications() {
	  List<Widget> notifications = [];
	  notifications.add(_getNotification(
		  'You have memories with Taliah Rossi and Mabel Quintero to look back on today.', '3 hours ago', false));
	  notifications.add(_getNotification(
		  'Susan Preece changed his profile picture.', 'Yesterday at 11:22pm', true));
	  notifications.add(_getNotification(
		  'David Beckham changed his profile picture.', 'Yesterday at 8:28pm', false));
	  notifications.add(_getNotification(
		  'Macaulay Dolan\'s birthday was yesterday.', '10 hours ago', true));
	  notifications.add(_getNotification(
		  'David Beckham changed his profile picture.', 'Yesterday at 8:28pm', false));
	  notifications.add(_getNotification(
		  'David Beckham changed his profile picture.', 'Yesterday at 8:28pm', false));
	  notifications.add(_getNotification(
		  'David Beckham changed his profile picture.', 'Yesterday at 8:28pm', false));
	  notifications.add(_getNotification(
		  'David Beckham changed his profile picture.', 'Yesterday at 8:28pm', false));
	  notifications.add(_getNotification(
		  'David Beckham changed his profile picture.', 'Yesterday at 8:28pm', false));
	  return notifications;
  }

  Widget _getNotification(String notificaiton, String time, bool hasStory) {
	  return Container(
		  decoration: BoxDecoration(
			  color: (hasStory == true) ? Theme.of(context).highlightColor : Colors.transparent
		  ),
		  child: ListTile(
			  title: Text(
				  notificaiton,
				  style: TextStyle(fontWeight: FontWeight.w400),
			  ),
			  leading: CircleAvatar(
				  backgroundImage: AssetImage('assets/images/notification-icon.png',), //NetworkImage(userProfileImage),
				  radius: 20.0,
			  ),
			  subtitle: Text(
				  '\n' + time,
				  style: TextStyle(
					  fontSize: 12,
				  ),
			  ),
			  isThreeLine: true,
			  /*trailing: IconButton(
				  icon: Icon(Icons.more_horiz),
				  disabledColor: Colors.black,
			  ),*/
			  onTap: () {
				  setState(() {
					  hasStory = (hasStory == true) ? false : true;
				  });
			  },
		  ),
	  );
  }
}
