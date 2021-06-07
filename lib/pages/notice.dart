import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
    @override
    _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
    bool hasNotification = false;
    @override
    Widget build(BuildContext context) {
        int _itemCount = 5;
        return Scaffold(
            backgroundColor: CustomTheme.lightTheme.primaryColor,
            appBar: AppBar(
                elevation: 0.0,
                title: Text(
                    'Notice Board',
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
                                child: ListView.builder(
                                    itemCount: _itemCount,
                                    itemBuilder: (BuildContext context, int index){
                                        return Container(
                                            height: 235,
                                            margin: EdgeInsets.only(bottom: 8.0),
                                            child: GestureDetector(
                                                onTap: (){
                                                    print('Notice $index clicked...');
                                                },
                                                child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0)
                                                    ),
                                                    child: Column(
                                                        children: [
                                                            Container(
                                                                height: 160,
                                                                width: double.infinity,
                                                                /*decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(color: Colors.red, width: 1.0)
                                                                )
                                                            ),*/
                                                                child: Image.asset(
                                                                    'assets/images/100-welcome.png',
                                                                    fit: BoxFit.fitWidth,
                                                                ),
                                                            ),
            
                                                            Expanded(
                                                                child: ListTile(
                                                                    title: Text(
                                                                        'Notice about COVID-19',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            color: CustomTheme.lightTheme.primaryColor
                                                                        ),
                                                                        textAlign: TextAlign.center,
                                                                    ),
                                                                    subtitle: Padding(
                                                                        padding: EdgeInsets.only(top: 4.0),
                                                                        child: Text(
                                                                            'ajdfslksafklasdfjsdflsfaljsflsfaj',
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                            ),
                                                                            textAlign: TextAlign.center,
                                                                        ),
                                                                    )
                                                                ),
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            )
                                        );
                                    }
                                )
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
            child: Card(
                child: Column(
                    children: [
                        Expanded(
                            child: Container(
                                child: Image.asset('assets/images/100-welcom.png'),
                            )
                        )
                    ],
                )
            )
        );
    }
}
