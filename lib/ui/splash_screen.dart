import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:card_app/ui/onboarding/onboarding_card.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/blocks/auth_block.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash-screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBlock auth;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds:3000), () async {
      checkFirstSeen();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OpenimisOnboardingPage(); //PageViewScreen();
      }));
    });
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      if(auth.isLoggedIn) {
        Navigator.popAndPushNamed(context, '/card');

      }
      else {
      Navigator.popAndPushNamed(context, '/insuree_verify');

      }
    }

  }
  @override
  Widget build(BuildContext context) {
    if(auth==null) {
      auth = Provider.of<AuthBlock>(context);
      env.setAuth(auth);

    }
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return;
      },
      child: Stack(
        children: <Widget>
        [
          Positioned.fill(  //
            child: Image(
              image: AssetImage('assets/images/100-welcome.png'),
              fit : BoxFit.fill,
           ),
          ), 
         
         ]
 ),
    );

  }
}
