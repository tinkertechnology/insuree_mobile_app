import 'package:card_app/card/sync.dart';
import 'package:card_app/pages/policy.dart';
import 'package:card_app/pages/services.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:card_app/theme/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:card_app/services/app_state.dart';
import 'package:provider/provider.dart';
import 'package:card_app/card/card_homepage.dart';
import 'package:card_app/services/bottom_nav_bar_service.dart';
import 'package:card_app/card/link_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:card_app/profile/profile_main.dart';
import 'package:card_app/services/location_service.dart';
import 'package:card_app/localization/language/languages.dart';
import 'package:card_app/localization/locale_constant.dart';
import 'package:card_app/models/language_data.dart';

class Display extends StatefulWidget {
  final int initIndex;
  Display({Key key, @required this.initIndex}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
    _getDrawerItemWidget(int pos) {
        switch (pos) {
            case 0:
                return new CardHome();
            case 1:
                //return new LinkCard();
                return new PolicyInformation();
            case 2:
                return new ServicesPage();
            case 3:
                return new ProfilePageView();
            default:
                return new Text("Error");
        }
    }

    List<String> titleList = ["openIMIS", "Policy Information", "Services", "Settings"];

    _createLanguageDropDown() {
        return DropdownButton<LanguageData>(
            iconSize: 30,
            hint: Text(Languages
                .of(context)
                .labelSelectLanguage),
            onChanged: (LanguageData language) {
                changeLanguage(context, language.languageCode);
            },
            items: LanguageData.languageList()
                .map<DropdownMenuItem<LanguageData>>(
                    (e) =>
                    DropdownMenuItem<LanguageData>(
                        value: e,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                                Text(
                                    e.flag,
                                    style: TextStyle(fontSize: 30),
                                ),
                                Text(e.name)
                            ],
                        ),
                    ),
            )
                .toList(),
        );
    }
    Widget build(BuildContext context) {
        final appState = Provider.of<AppState>(context);
        final bottom_nav = Provider.of<BottomNavigationBarProvider>(context);
        final themeChange = Provider.of<DarkThemeProvider>(context);

        print('123');

        // appState.fetchData();

        return Scaffold(
            // extendBodyBehindAppBar: true,
            // extendBody: true,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                // backgroundColor: Colors.transparent,
                backgroundColor: CustomTheme.lightTheme.primaryColor,//Color.fromRGBO(234, 239, 255, 50),
                // Remove any elevation to avoid seeing a shadow underneath the translucent material of the app bar.
                elevation: 0.0,

                //title: Text('Photo frame'),
                actions: <Widget>[
                    Switch(
                        value: themeChange.darkTheme,
                        onChanged: (bool value) {
                            themeChange.darkTheme = value;
                        }),
                    _createLanguageDropDown()
                ],
                title: Text(titleList[bottom_nav.currentIndex], textAlign: TextAlign.center,),

            ),
            body:  _getDrawerItemWidget(bottom_nav.currentIndex),
            bottomNavigationBar: CurvedNavigationBar(
                color: CustomTheme.lightTheme.primaryColor,
                height: 50,
                onTap: (index) {
                    bottom_nav.currentIndex = index;
                },
                backgroundColor: CustomTheme.lightTheme.splashColor.withOpacity(0.25),
                items: <Widget>[
                    Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.white,
                    ),
                    Icon(
                        Icons.credit_card,
                        size: 30,
                        color: Colors.white,
                    ),
                    Icon(
                        Icons.camera,
                        size: 30,
                        color: Colors.white,
                    ),
                    Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.white,
                    ),
                ],
            ),
        );


    }
}