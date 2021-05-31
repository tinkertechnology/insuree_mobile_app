
import 'package:card_app/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:card_app/services/linked_card_state.dart';
import 'package:card_app/card/add_card.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class LinkedCardComponent extends StatefulWidget {
  LinkedCardComponent({Key key}) : super(key: key);

  @override
  _LinkedCardComponent createState() => _LinkedCardComponent();
}

class _LinkedCardComponent extends State<LinkedCardComponent> {
  var card_api;
  bool isApiLoaded = false;
  @override
  void initState() {

  }
  @override
  Widget build(BuildContext context) {
      final appState = Provider.of<LinkedCardState>(context);
      if(isApiLoaded==false){
        appState.fetchData();
      }
      setState(() {
        isApiLoaded = true;
      });

    return (
      appState.isFetching
        ? Center(child:CircularProgressIndicator()): 

          SizedBox(
          height: 85,
          child: appState.getResponseJson().length > 0  ?  GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: appState.getResponseJson().map<Widget>((value){
                    return Container(
                      child: Column(
                          children: <Widget>[
                            InkWell(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddCard(affiliate_id: null, cardpk: value['id'],),
                                      )),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(243, 245, 248, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child:  CachedNetworkImage(
                                    imageUrl: value['affiliate']['logo'], //"http://via.placeholder.com/350x150",
                                    placeholder: (context, url) => new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ), //Image.network("https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"), //Icon(Icons.date_range, color: Colors.blue[900], size: 30,),
                                  padding: EdgeInsets.all(12),
                              ),
                            ),
                              SizedBox(
                                  height: 4,
                              ),
                              // Text(value['card_id'], style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                          ],
                      ),
                  );
                  }).toList(),

                  
              
          ) : 
          Align(
            alignment: Alignment.center,
            child: Text('You have not linked any cards yet',textAlign: TextAlign.center,),
          )
      )
    );
  }
}