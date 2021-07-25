import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:openimis_web_app/ui/RegisterMobilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openimis_web_app/auth/auth.dart';
import 'package:openimis_web_app/common/env.dart' as env;
import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:provider/provider.dart';
class PageViewScreen extends StatefulWidget {
  static const String id = "page_view_screen";

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  AuthBlock auth;
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.pinkAccent : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(auth==null) {
      auth = Provider.of<AuthBlock>(context);
      env.setAuth(auth);

    }
    if(auth.isLoggedIn){
      Navigator.pushNamed(context, '/home');
    }
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            color: Colors.white,
            /* decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color(0xFF3594DD),
                  Color(0xFF4563DB),
                  Color(0xFF5036D5),
                  Color(0xFF5B16D0),
                ],
              ),
            ),*/
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'images/openimis_web_app_logo.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'work from',
                                      ),
                                      Text(
                                        ' HOME!',
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                    ]),
                                SizedBox(height: 5.0),
                                Center(
                                  child: Text(
                                    'In this pandemic we provide you',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'a home based job.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'images/flower.png',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'earn with',
                                      ),
                                      Text(
                                        ' openimis_web_app!',
                                        style:
                                            TextStyle(color: Colors.pinkAccent),
                                      ),
                                    ]),
                                SizedBox(height: 5.0),
                                Center(
                                  child: Text(
                                    'In this pandemic we provide you',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'a home based job.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 40.0,
                    width: 350.0,
                    color: Colors.pinkAccent,
                    child: FlatButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('seen', true);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                // return RegisterMobilePage();
                              }));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // return RegisterMobilePage();
                          }));
                        },
                        child: Text(
                          "NEXT",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ))),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 40.0,
                    width: 350.0,
                    color: Colors.pinkAccent,
                    child: FlatButton(
                        onPressed: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('seen', true);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // return RegisterMobilePage();
                          }));
                        },
                        child: Text(
                          "SKIP",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ))),
              ));
  }
}
