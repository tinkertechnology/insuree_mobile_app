import 'dart:convert';

import 'package:card_app/card/link_card.dart';
import 'package:card_app/homescreen/homepage_link_sync_event.dart';
import 'package:card_app/localization/language/languages.dart';
import 'package:flutter/material.dart';
import 'package:card_app/services/app_state.dart';
import 'package:provider/provider.dart';
// import 'package:card_app/homescreen/recent_card_used.dart';
import 'package:card_app/homescreen/recent_card_component.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/services/auth_service.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState(){
        super.initState();
        handleGQLQuery();
    }
    handleGQLQuery() async {

        final response = await http.post(Uri.parse('https://oi.tinker.com.np/api/graphql'),
            headers: {
                "Content-Type": "application/json",
//                "Accept" : "application/json"
            },
            body:
                jsonEncode({"query":"query {\n  medicalServicesStr {  edges{    node{      id      name    }  }      }}","variables":null})

        );


        if (response.statusCode  == 200) {
            final decodedJson = jsonDecode(response.body);
        }
        print('tara baji lai lai');
    }
    @override
    Widget build(BuildContext context) {
      final appState = Provider.of<AppState>(context);
    if(appState.isApiLoading==false){
      appState.fetchData();
      appState.isApiServiceLoading(true);
    }

    appState.isApiServiceLoading(false);
        final orientation = MediaQuery.of(context).orientation;
//        var userlocation = Provider.of<UserLocation>(context);
        return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Container(
                    height: 300,
                    width: double.infinity,
                    color: Color.fromRGBO(234, 239, 255, 50),
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            SizedBox(height: 20.0),

//                    Text(
//                        'Location: Lat${userlocation?.latitude}, Long: ${userlocation?.longitude}'),
                            CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: Image.asset("assets/dp.jpg", fit: BoxFit.contain,),
                                ),
                            ),
                            SizedBox(height: 4,),
                            Text(
                                Languages
                                    .of(context)
                                    .labelWelcome,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                            ),
                            SizedBox(height: 4.0),
                            ListTile(
                                title: Text(
                                    "21",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.orange
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                    "Cards Linked",
                                    style: TextStyle(
                                        fontSize: 14
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                            ),
                            SizedBox(height: 10.0),

                            HomeLinkSyncEvent(),
                        ],
                    )
                ),

                SizedBox(height: 24.0),
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text("Recently used cards"),
                            Divider(
                                height: 40,
                                thickness: 1,
                                endIndent: 25.0,
                            ),
                        ],
                    ),
                ),
                Container(
                    height: 390,
                    child: LinkedCardComponent(),
                    //RecentCard(),
                ),

            ],
        ),
        );
    }
}