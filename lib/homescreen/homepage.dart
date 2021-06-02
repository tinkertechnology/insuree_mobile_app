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
        return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.05,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)
                        ),
                        color: Color.fromRGBO(234, 239, 255, 1),
                    ),
                    child: FutureBuilder<Claims>(
                      future: _insureeclaims,
                      builder: (context, snapshot) {
                          if(snapshot.hasData) {
                        return ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data.data.insureeProfile.insureeClaim.length,
                            itemBuilder: (BuildContext context, int index) {
                                var claims = snapshot.data.data.insureeProfile.insureeClaim
                                    [index];
                                return ListTile(
                                    title: Text('${claims.dateClaimed}'));
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