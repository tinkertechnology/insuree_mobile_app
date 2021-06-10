import 'package:card_app/homescreen/homepage.dart';
import 'package:card_app/pages/history.dart';
import 'package:card_app/pages/policy.dart';
import 'package:card_app/pages/services.dart';
import 'package:card_app/screen_size_reducers.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_app/card/card_homepage.dart';
import 'package:card_app/services/bottom_nav_bar_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:card_app/pages/settings.dart';
import 'package:card_app/models/language_data.dart';
import 'package:card_app/langlang/app_translation.dart';
import 'package:card_app/langlang/application.dart';

class Display extends StatefulWidget {
  final int initIndex;
  Display({Key key, @required this.initIndex}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {

    @override
    initState(){
        super.initState();
        application.onLocaleChanged = onLocaleChange;

    }

    void onLocaleChange(Locale locale) async {
        setState(() {
            AppTranslations.load(locale);
        });
    }
    _getDrawerItemWidget(int pos) {
        switch (pos) {
            case 0:
                return new CardHome();
	        case 1:
		        return new HistoryPage();
            case 2:
                return new PolicyInformationPage();
            case 3:
                return new SettingsPage();
            default:
                return new Text("Error");
        }
    }

    List<String> titleList = ["page_title_openimis", "page_title_history", "page_title_policy_information", "page_title_settings"];

    Widget build(BuildContext context) {
        final bottom_nav = Provider.of<BottomNavigationBarProvider>(context);
        var connectionStatus = Provider.of<ConnectivityResult>(context);
        if(connectionStatus==ConnectivityResult.none){setState(() {});}

        return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: CustomTheme.lightTheme.primaryColor, //Color.fromRGBO(234, 239, 255, 50),
                elevation: 0.0,
                actions: <Widget>[
                    // _createLanguageDropDown()
                    IconButton(
                        icon: Icon(Icons.credit_card_rounded, color: Colors.white, size: 30,),
                        onPressed: (){
                            print('Show Card Clicked...');
                            Navigator.pushNamed(context, '/show-card');
                        }
                    )
                ],
                title: Text(
                    AppTranslations.of(context).text(titleList[bottom_nav.currentIndex]),
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                ),
            ),
           
            body : connectionStatus==ConnectivityResult.none ?
                    Container(child: Center(child: Text(AppTranslations.of(context).text('no_internet_connection')),),)
                :_getDrawerItemWidget(bottom_nav.currentIndex),
            bottomNavigationBar: CurvedNavigationBar(
                color: CustomTheme.lightTheme.primaryColor,
                height: 60,
                onTap: (index) {
                    bottom_nav.currentIndex = index;
                },
                backgroundColor: CustomTheme.lightTheme.backgroundColor,
                items: <Widget>[
                    Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.white,
                    ),
                    Icon(
                        Icons.history,
                        size: 30,
                        color: Colors.white,
                    ),
                    Icon(
                        Icons.policy_rounded,
                        size: 30,
                        color: Colors.white,
                    ),
                    Icon(
                        Icons.more_vert,
                        size: 30,
                        color: Colors.white,
                    ),
                ],
            ),
        );


    }
}