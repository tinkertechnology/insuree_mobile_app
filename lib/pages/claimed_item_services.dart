import 'package:card_app/models/claimeditems.dart';
import 'package:card_app/models/claimedservices.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/services/api_graphql_services.dart';

class ClaimedItemServicesPage extends StatefulWidget {
    final int claimid;
    ClaimedItemServicesPage({Key key, this.claimid}) : super(key: key);
    @override
    _ClaimedItemServicesPageState createState() =>
        _ClaimedItemServicesPageState();
}

class _ClaimedItemServicesPageState extends State<ClaimedItemServicesPage> {
    bool hasNotification = false;
    Future<ClaimedServices> _claimedservices;
    Future<ClaimedItems> _claimeditems;
    @override
    void initState() {
        // TODO: implement initState
        var hasStory = true;
        super.initState();
        _claimedservices =
            ApiGraphQlServices().ClaimedServicesServicesGQL(widget.claimid);
        _claimeditems = ApiGraphQlServices().ClaimedItemServicesGQL(widget.claimid);
    }
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: CustomTheme.lightTheme.primaryColor,
            appBar: AppBar(
                elevation: 0.0,
                title: Text(
                    'Claimed Item Services',
                    style: TextStyle(color: Colors.white),
                ),
                backgroundColor: CustomTheme.lightTheme.primaryColor,
            ),
            body: Column(
                children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                            ),
                            child: SingleChildScrollView(
                                // scrollDirection: Axis.vertical,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        Container(
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                    Container(
                                                        padding: EdgeInsets.only(left:8.0, top: 16.0, bottom: 8.0),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors.grey
                                                                        .withOpacity(0.25)))),
                                                        width: double.infinity,
                                                        child: Text(
                                                            'Items',
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Container(
                                                        child: FutureBuilder<ClaimedItems>(
                                                            future: _claimeditems,
                                                            builder: (context, snapshot) {
                                                                if (snapshot.hasData) {
                                                                    return ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.data.data
                                                                            .insureeClaim[0].items.length,
                                                                        itemBuilder: (BuildContext context,
                                                                            int index) {
                                                                            var claimeditems = snapshot
                                                                                .data
                                                                                .data
                                                                                .insureeClaim[0]
                                                                                .items[index];
                                                                            return Container(
                                                                                /*decoration: BoxDecoration(
                                                                                    color: (true == true)
                                                                                        ? Theme.of(context)
                                                                                        .highlightColor
                                                                                        : Colors.transparent
                                                                                ),*/
                                                                                child: ListTile(
                                                                                    title: Text(
                                                                                        '${claimeditems.item.name}',
                                                                                        style: TextStyle(
                                                                                            fontSize: 14.0,
                                                                                            fontWeight: FontWeight.normal
                                                                                        ),
                                                                                    ),
                                                                                    subtitle: Text(
                                                                                        '${env.Currency} ${claimeditems.item.price.toString()}',
                                                                                        style: TextStyle(
                                                                                            fontSize: 12,
                                                                                            fontWeight: FontWeight.w300
                                                                                        ),
                                                                                    ),
                                                                                ),
                                                                            );
                                                                        });
                                                                } else {
                                                                    return Center(
                                                                        child: CircularProgressIndicator());
                                                                }
                                                            }),
                                                    )
                                                ],
                                            ),
                                        ),
                                        Container(
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                    Container(
                                                        padding: EdgeInsets.only(left:8.0, top: 16.0, bottom: 8.0),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors.grey
                                                                        .withOpacity(0.25)))),
                                                        width: double.infinity,
                                                        child: Text(
                                                            'Services',
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Container(
                                                        child: FutureBuilder<ClaimedServices>(
                                                            future: _claimedservices,
                                                            builder: (context, snapshot) {
                                                                if (snapshot.hasData) {
                                                                    return ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot
                                                                            .data.data.insureeClaim[0].services.length,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                            var claimedservices = snapshot
                                                                                .data.data.insureeClaim[0].services[index];
                                                                            return Container(
                                                                                /*decoration: BoxDecoration(
                                                                                    color: (true == true)
                                                                                        ? Theme.of(context)
                                                                                        .highlightColor
                                                                                        : Colors.transparent
                                                                                ),*/
                                                                                child: ListTile(
                                                                                    title: Text(
                                                                                        '${claimedservices.service.name}',
                                                                                        style: TextStyle(
                                                                                            fontSize: 14.0,
                                                                                            fontWeight: FontWeight.normal
                                                                                        ),
                                                                                    ),
                                                                                    trailing: Text(
                                                                                        '${env.Currency} ${claimedservices.service.price.toString()}',
                                                                                        style: TextStyle(
                                                                                            fontSize: 14.0,
                                                                                            fontWeight: FontWeight.w300
                                                                                        ),
                                                                                    ),
                                                                                ),
                                                                            );
                                                                        });
                                                                } else {
                                                                    return Center(
                                                                        child: CircularProgressIndicator()
                                                                    );
                                                                }
                                                            }),
                                                    )
                                                ],
                                            ),
                                        ),
                                    ],
                                ),
                            )),
                    ),
                ],
            ));
    }
    
    List<Widget> _getNotifications() {
        List<Widget> notifications = [];
        notifications.add(_getNotification(
            'You have memories with Taliah Rossi and Mabel Quintero to look back on today.',
            '3 hours ago',
            false));
        notifications.add(_getNotification(
            'Susan Preece changed his profile picture.',
            'Yesterday at 11:22pm',
            true));
        notifications.add(_getNotification(
            'David Beckham changed his profile picture.',
            'Yesterday at 8:28pm',
            false));
        notifications.add(_getNotification(
            'Macaulay Dolan\'s birthday was yesterday.', '10 hours ago', true));
        notifications.add(_getNotification(
            'David Beckham changed his profile picture.',
            'Yesterday at 8:28pm',
            false));
        notifications.add(_getNotification(
            'David Beckham changed his profile picture.',
            'Yesterday at 8:28pm',
            false));
        notifications.add(_getNotification(
            'David Beckham changed his profile picture.',
            'Yesterday at 8:28pm',
            false));
        notifications.add(_getNotification(
            'David Beckham changed his profile picture.',
            'Yesterday at 8:28pm',
            false));
        notifications.add(_getNotification(
            'David Beckham changed his profile picture.',
            'Yesterday at 8:28pm',
            false));
        return notifications;
    }
    
    Widget _getNotification(String notificaiton, String time, bool hasStory) {
        return Container(
            decoration: BoxDecoration(
                color: (hasStory == true)
                    ? Theme.of(context).highlightColor
                    : Colors.transparent),
            child: ListTile(
                title: Text(
                    notificaiton,
                    style: TextStyle(fontWeight: FontWeight.w400),
                ),
                leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/notification-icon.png',
                    ), //NetworkImage(userProfileImage),
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
