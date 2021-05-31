import 'package:flutter/material.dart';
class HomeLinkSyncEvent extends StatefulWidget {
  HomeLinkSyncEvent({Key key}) : super(key: key);

  @override
  _HomeLinkSyncEventState createState() => _HomeLinkSyncEventState();
}

class _HomeLinkSyncEventState extends State<HomeLinkSyncEvent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: <Widget>[
                Container(
                    child: Column(
                        children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/add_card');
                              }, // Handle your callback
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                ),
                                child: Icon(Icons.credit_card, color: Colors.orange[700], size: 30,),
                                padding: EdgeInsets.all(12),
                            
                            ),
                            ),
                            SizedBox(
                                height: 4,
                            ),
                            Text("Link Card", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                            
                            
                        ],
                    ),
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                ),
                                child: Icon(Icons.sync, color: Colors.orange[700], size: 30,),
                                padding: EdgeInsets.all(12),
                            ),
                            SizedBox(
                                height: 4,
                            ),
                            Text("Sync", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                        ],
                    ),
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(243, 245, 248, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                ),
                                child: Icon(Icons.date_range, color: Colors.orange[700], size: 30,),
                                padding: EdgeInsets.all(12),
                            ),
                            SizedBox(
                                height: 4,
                            ),
                            Text("Events", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),),
                        ],
                    ),
                ),
            ],
        ),
    );
                        
    
  }
}
