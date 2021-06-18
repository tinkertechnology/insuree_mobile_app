import 'package:card_app/models/notices.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
    @override
    _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
    bool hasNotification = false;

    Future<Notice> _notice;
    @override
    initState(){
        super.initState();
        _notice = ApiGraphQlServices().NoticesServicesGQL();
    }
    
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
                                child: FutureBuilder<Notice>(
                                    future: _notice,
                                    builder: (context, snapshot) {
                                        if(snapshot.hasData) {
                                            return ListView.builder(
                                                itemCount: snapshot.data.data.notices.edges.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                    var notices = snapshot.data.data.notices.edges[index];
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
                                                                            decoration: BoxDecoration(
                                                                                border: Border(
                                                                                    bottom: BorderSide(color: Colors.red, width: 1.0)
                                                                                )
                                                                            ),
                                                                            child: Image.asset(
                                                                                'assets/images/100-welcome.png',
                                                                                fit: BoxFit.fitWidth,
                                                                            ),
                                                                        ),
                    
                                                                        Expanded(
                                                                            child: ListTile(
                                                                                title: Text(
                                                                                    '${notices.node.title}',
                                                                                    style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: CustomTheme.lightTheme.primaryColor
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                ),
                                                                                subtitle: Padding(
                                                                                    padding: EdgeInsets.only(top: 4.0),
                                                                                    child: Text(
                                                                                        '${notices.node.description}',
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
                                            );
                                        }
                                        else{
                                            return Center(child: CircularProgressIndicator());
                                        }
                                    }
                                ),
                            )
                        )
                    )
                ],
            ),
        );
    }
}
