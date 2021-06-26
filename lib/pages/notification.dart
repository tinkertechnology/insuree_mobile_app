import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/models/notifications.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/models/notifications.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}


class _NotificationPageState extends State<NotificationPage> {
  bool hasNotification = false;
  Future<Notifications> _notifications;
	AuthBlock auth;
  @override
  Widget build(BuildContext context) {
		auth = Provider.of<AuthBlock>(context);
	  return Scaffold(
		  backgroundColor: CustomTheme.lightTheme.primaryColor,
		  appBar: AppBar(
			  elevation: 0.0,
			  title: Text(
				  'Notifications',
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
					child: FutureBuilder<Notifications>(
									future: ApiGraphQlServices().NotificationsServicesGQL(
											auth.user['data']['insureeAuthOtp']['token'],
											auth.user['data']['insureeAuthOtp']['insuree']['chfId']
									),
									builder: (context, snapshot) {
										if(snapshot.hasData && snapshot.data.data!=null) {
											return ListView.builder(
													shrinkWrap: true,
													scrollDirection: Axis.vertical,
													physics: NeverScrollableScrollPhysics(),
													itemCount: snapshot.data.data.notifications.edges.length,
													itemBuilder: (BuildContext context, int index){
														var _notifications = snapshot.data.data.notifications.edges[index];
														var date = "${_notifications.node.createdAt.year}-${_notifications.node.createdAt.month}-${_notifications.node.createdAt.day}";
														return ListTile(
															title: Text('${_notifications.node.message}'),
															subtitle: Text('${date}'),
															onTap: () {
															},
														);
													}
											);
										}
										else{
											return Center(child: CircularProgressIndicator());
										}
									}
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
