
import 'package:card_app/blocks/auth_block.dart';
import 'package:flutter/material.dart';
import 'package:card_app/card/components/link_card_component.dart';
// import 'package:card_app/card/components/linked_card_component.dart';
import 'package:card_app/card/components/linked_cards_component.dart';
import 'package:provider/provider.dart';

class LinkCard extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            color: Color.fromRGBO(234, 239, 255, 1),
            child:  SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: Column(
                    children: <Widget>[
                        Container(
                            height: 360,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                    padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text("Linked Cards"),
                                            Divider(
                                                height: 45,
                                                thickness: 1,
                                            ),
                                            SizedBox(
                                                height: 200,
                                                child : LinkedCard(), //LinkedCardComponent(),
                                            ),
                                
                                            Container(
                                                width: double.infinity,
                                                child: RaisedButton(
                                                    onPressed: (){},
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    ),
                                                    padding: EdgeInsets.all(15),
                                                    child: Text(
                                                        "See All"
                                                    ),
                                                ),
                                            )
                                        ],
                                    ),
                                )
                            ),
                        ),
                        // // LinkCard(),
            
                        // LINK CARD
                        Container(
                            height: 200,
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                    padding: EdgeInsets.only(left: 25, top: 25, right: 25),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text("Link Card"),
                                            Divider(
                                                height: 45,
                                                thickness: 1,
                                            ),

                                            LinkCardComponent(),
                                        ],
                                    ),
                                )
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}