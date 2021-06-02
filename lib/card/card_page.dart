import 'package:card_app/card/sync.dart';
import 'package:card_app/theme/dark_theme_provider.dart';
import 'package:flutter/material.dart';
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
                return new LinkCard();
            case 2:
                return new Sync();
            case 3:
                return new Sync();
            case 4:
                return new ProfilePageView();
            default:
                return new Text("Error");
        }
    }

    List<String> titleList = ["Home", "Cards", "Dashboard", "Sync", "Profile"];

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
                backgroundColor: Color.fromRGBO(234, 239, 255, 50),
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
                color: Colors.orange[300],
                height: 50,
                // index: 0,
                // backgroundColor: colorScheme.surface,
                // selectedFontSize: 24,
                // selectedItemColor: Color.fromRGBO(252, 65, 3, 0.8),
                // unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
                // selectedLabelStyle: textTheme.caption,
                // unselectedLabelStyle: textTheme.caption,

                // currentIndex: bottom_nav.currentIndex,
                // initialIndex: 0,
                onTap: (index) {

                    bottom_nav.currentIndex = index;
                },
                backgroundColor: Colors.white,
                items: <Widget>[
                    Icon(Icons.home, size: 30),
                    Icon(Icons.credit_card, size: 30),
                    Icon(Icons.camera, size: 30),
                    Icon(Icons.sync, size: 30),
                    Icon(Icons.person, size: 30),
                ],
                // items: [
                //     BottomNavigationBarItem(
                //         icon: new Icon(Icons.home),
                //         title: new Text(''),
                //     ),
                //     BottomNavigationBarItem(
                //         icon: new Icon(Icons.card_giftcard),
                //         title: new Text('Cards'),
                //     ),
                //     BottomNavigationBarItem(
                //         icon: Icon(Icons.settings),
                //         title: Text('Settings'),
                //     ),
                //     BottomNavigationBarItem(
                //         icon: Icon(Icons.sync),
                //         title: Text('Sync'),
                //     ),
                //     BottomNavigationBarItem(
                //         icon: Icon(Icons.person),
                //         title: Text('Profile'),
                //     )
                // ],

            ),
        );


    }
}