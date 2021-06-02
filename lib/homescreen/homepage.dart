import 'dart:convert';

import 'package:card_app/card/link_card.dart';
import 'package:card_app/homescreen/homepage_link_sync_event.dart';
import 'package:card_app/localization/language/languages.dart';
import 'package:card_app/models/claimed.dart';
import 'package:card_app/models/insuree_claims.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:card_app/homescreen/recent_card_used.dart';
import 'package:card_app/homescreen/recent_card_component.dart';
import 'package:card_app/models/user_location.dart';
import 'package:card_app/services/auth_service.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/models/medical_services.dart';
import 'package:card_app/services/api_graphql_services.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    Future<MedicalServices> _medicalservices;
    Future<Claims> _insureeclaims;
    Future<Claimed> _claimed;
    @override
    void initState(){
        super.initState();

        _medicalservices = ApiGraphQlServices().MedicalServicesGQL('medicalservice');
        _insureeclaims = ApiGraphQlServices().ClaimsServicesGQL();
        _claimed = ApiGraphQlServices().ClaimedServicesGQL();

    }
    @override
    Widget build(BuildContext context) {

        final orientation = MediaQuery.of(context).orientation;
//        var userlocation = Provider.of<UserLocation>(context);
        /*return Container(
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
        );*/
        return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.01,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)
                        ),
                        /*gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            *//*stops: [
                                0.1,
                                0.4,
                                0.6,
                            ],*//*
                            colors: [
                                CustomTheme.lightTheme.primaryColor,
                                CustomTheme.lightTheme.splashColor,
                                //Color.fromRGBO(234, 239, 255, 1),
                                CustomTheme.lightTheme.accentColor
                            ]
                        ),*/
                        color: Color.fromRGBO(234, 239, 255, 1),
                    ),
                    child: FutureBuilder<MedicalServices>(
                      future: _medicalservices,
                      builder: (context, snapshot) {
                          if(snapshot.hasData) {
                        return ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data.data.medicalServicesStr.edges.length,
                            itemBuilder: (BuildContext context, int index) {
                                var medical_services = snapshot.data.data
                                    .medicalServicesStr.edges[index];
                                return ListTile(
                                    title: Text('${medical_services.node.name}'));
                            }

                        );
                      } else{
                              return Center(child: CircularProgressIndicator());
                          }
                      }
                    ),
                );
            },
        );
    }
}