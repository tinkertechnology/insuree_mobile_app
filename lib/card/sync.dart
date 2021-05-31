import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_app/services/bottom_nav_bar_service.dart';
import 'package:provider/provider.dart';
class Sync extends StatelessWidget {
    final double circleRadius =100.0;
    final double circleBorderWidth = 8.0;
    @override
    Widget build(BuildContext context) {
        return Container(
            color: Color.fromRGBO(234, 239, 255, 50),
            child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                        children: <Widget>[
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        // color of linked cards container
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                        ),
                                    ),
                        
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Container(
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
                                                            child: GridView.count(
                                                                crossAxisCount: 3,
                                                                shrinkWrap: true,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                children: <Widget>[
                                                                    Container(
                                                                        padding: EdgeInsets.all(5.0),
                                                                        child: Column(
                                                                            children: <Widget>[
                                                                                Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color.fromRGBO(243, 245, 248, 1),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(18))
                                                                                    ),
                                                                                    child: Icon(Icons.credit_card, color: Colors.orange[700], size: 30,),
                                                                                    padding: EdgeInsets.all(12),
                                                                                ),
                                                                                SizedBox(
                                                                                    height: 4,
                                                                                ),
                                                                                Text("Link Card", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                                                                            ],
                                                                        ),
                                                                    ),
                                                                    Container(
                                                                        padding: EdgeInsets.all(5.0),
                                                                        child: Column(
                                                                            children: <Widget>[
                                                                                Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color.fromRGBO(243, 245, 248, 1),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(18))
                                                                                    ),
                                                                                    child: Icon(Icons.credit_card, color: Colors.orange[700], size: 30,),
                                                                                    padding: EdgeInsets.all(12),
                                                                                ),
                                                                                SizedBox(
                                                                                    height: 4,
                                                                                ),
                                                                                Text("Link Card", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                                                                            ],
                                                                        ),
                                                                    ),
                                                                    Container(
                                                                        padding: EdgeInsets.all(5.0),
                                                                        child: Column(
                                                                            children: <Widget>[
                                                                                Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color.fromRGBO(243, 245, 248, 1),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(18))
                                                                                    ),
                                                                                    child: Icon(Icons.credit_card, color: Colors.orange[700], size: 30,),
                                                                                    padding: EdgeInsets.all(12),
                                                                                ),
                                                                                SizedBox(
                                                                                    height: 4,
                                                                                ),
                                                                                Text("Link Card", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                                                                            ],
                                                                        ),
                                                                    ),
                                                                    Container(
                                                                        padding: EdgeInsets.all(5.0),
                                                                        child: Column(
                                                                            children: <Widget>[
                                                                                Container(
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color.fromRGBO(243, 245, 248, 1),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(18))
                                                                                    ),
                                                                                    child: Icon(Icons.credit_card, color: Colors.orange[700], size: 30,),
                                                                                    padding: EdgeInsets.all(12),
                                                                                ),
                                                                                SizedBox(
                                                                                    height: 4,
                                                                                ),
                                                                                Text("Link Card", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                                                                            ],
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
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
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}