import 'package:flutter/material.dart';

import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SmartWalletOnboardingPage extends StatelessWidget {
  static final String path = "lib/src/ui/onboarding/onboarding_card.dart";
  final pages = [
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
        bubbleBackgroundColor: Colors.indigo,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text('Welcome to Smart Card'),
            Text(
              'Carry your cards everywhere anytime.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
              ),
            ),
          ],
        ),
        mainImage: Image.asset(
          'assets/images/smcard/wallet1.png',
          width: 285.0,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
        iconColor: null,
        bubbleBackgroundColor: Colors.indigo,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text('One Touch card Verify'),
            Text(
              'Organize your important personal and business card digitally.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
              ),
            ),
          ],
        ),
        mainImage: Image.asset(
          'assets/images/smcard/wallet2.png',
          width: 285.0,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.black),
    ),
    PageViewModel(
      pageColor: Color(0xF6F6F7FF),
        iconColor: null,
        bubbleBackgroundColor: Colors.indigo,
        title: Container(),
        body: Column(
          children: <Widget>[
            Text('Automatically Organize'),
            Text(
              'Organize your expenses and incomes and secure your wallet with pin.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0
              ),
            ),
          ],
        ),
        mainImage: Image.asset(
          'assets/images/smcard/wallet3.png',
          width: 285.0,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            IntroViewsFlutter(
              pages,
              onTapDoneButton: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('seen', true);
                Navigator.popAndPushNamed(context, '/insuree_verify');
              },
              showSkipButton: false,
              doneText: Text("Get Started",),
              pageButtonsColor: Colors.indigo,
              pageButtonTextStyles: new TextStyle(
                  // color: Colors.indigo,
                  fontSize: 16.0,
                  fontFamily: "Regular",
              ),
            ),
            Positioned(
              top: 20.0,
              left: MediaQuery.of(context).size.width/2 - 50,
              child: Image.asset('assets/images/smcard/logo.png', width: 100,)
            )
          ],
        ),
      ),
    );
  }
}