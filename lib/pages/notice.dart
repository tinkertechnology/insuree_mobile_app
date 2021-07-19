import 'package:card_app/blocks/auth_block.dart';
import 'package:card_app/langlang/app_translation.dart';
import 'package:card_app/models/notices.dart';
import 'package:card_app/screen_size_reducers.dart';
import 'package:card_app/services/api_graphql_services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_app/langlang/application.dart';

class NoticePage extends StatefulWidget {
    @override
    _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
    bool hasNotification = false;

    Future<Notice> _notice;
    AuthBlock auth;
    @override
    initState(){
        super.initState();
        application.onLocaleChanged = onLocaleChange;
        _notice = ApiGraphQlServices().NoticesServicesGQL("332D7B1");
    }

    void onLocaleChange(Locale locale) async {
        setState(() {
            AppTranslations.load(locale);
        });
    }
    
    @override
    Widget build(BuildContext context) {
        auth = Provider.of<AuthBlock>(context);
        print(auth.user['data']['insureeAuthOtp']);
        // print(auth.user['data']['insureeAuthOtp']);
        return Scaffold(
            backgroundColor: CustomTheme.lightTheme.primaryColor,
            appBar: AppBar(
                elevation: 0.0,
                title: Text(
                    AppTranslations.of(context).text('notice'),
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
                                    future: ApiGraphQlServices().NoticesServicesGQL(auth.user['data']['insureeAuthOtp']['token']),
                                    builder: (context, snapshot) {
                                        if(snapshot.hasData && snapshot.data.data!=null) {
                                            return ListView.builder(
                                                itemCount: snapshot.data.data.notices.edges.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                    var notices = snapshot.data.data.notices.edges[index];
                                                    return Container(
                                                        height: screenHeight(context, dividedBy: 3),//200,
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
                                                                            height: screenHeight(context, dividedBy: 6),
                                                                            width: double.infinity,
                                                                            decoration: BoxDecoration(
                                                                                /*border: Border(
                                                                                    bottom: BorderSide(color: Colors.red, width: 1.0)
                                                                                )*/
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
