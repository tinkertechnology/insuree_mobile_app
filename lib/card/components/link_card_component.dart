import 'package:flutter/material.dart';
import 'package:card_app/services/linked_card_state.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_app/services/affiliate_services.dart';
import 'package:card_app/models/affiliate.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:card_app/services/add_card_service.dart';
import 'package:card_app/models/affiliate.dart';
import 'package:card_app/card/add_card.dart';
class LinkCardComponent extends StatefulWidget {
  LinkCardComponent({Key key}) : super(key: key);
  

  @override
  _LinkCardComponent createState() => _LinkCardComponent();
}

class _LinkCardComponent extends State<LinkCardComponent> {
 Future<List<Post>> posts;
 
  @override
  void initState() {
    super.initState();
    posts = fetchAllAffiliates();


  }
  @override
  Widget build(BuildContext context) {
    return (
    SizedBox(
          height: 85,
          child: FutureBuilder<List<Post>>(
            future: posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return (
                        Container(
                      child: Column(
                          children: <Widget>[
                              InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddCard(affiliate_id: snapshot.data[index].id,),
                                  )),
                             child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(243, 245, 248, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child:  CachedNetworkImage(
                                    imageUrl: snapshot.data[index].logo,// value['affiliate']['logo'], //"http://via.placeholder.com/350x150",
                                    placeholder: (context, url) => new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ), //Image.network("https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"), //Icon(Icons.date_range, color: Colors.blue[900], size: 30,),
                                  padding: EdgeInsets.all(12),
                              )
                              ),
                              SizedBox(
                                  height: 4,
                              ),
                              // Text(value['card_id'], style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                          ],
                      ),
                  )
                        );
          });
          
        }
          return Center(child: CircularProgressIndicator());
        }
     
     ),
    )
    );
  }
          
    //       posts.length > 0  ?  GridView.count(
    //           physics: NeverScrollableScrollPhysics(),
    //           crossAxisCount: 3,
    //           children: appState.getResponseJson().map<Widget>((value){
                  //   return Container(
                  //     child: Column(
                  //         children: <Widget>[
                  //             Container(
                  //                 decoration: BoxDecoration(
                  //                     color: Color.fromRGBO(243, 245, 248, 1),
                  //                     borderRadius: BorderRadius.all(Radius.circular(18))
                  //                 ),
                  //                 child:  CachedNetworkImage(
                  //                   imageUrl: value['affiliate']['logo'], //"http://via.placeholder.com/350x150",
                  //                   placeholder: (context, url) => new CircularProgressIndicator(),
                  //                   errorWidget: (context, url, error) => new Icon(Icons.error),
                  //                 ), //Image.network("https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"), //Icon(Icons.date_range, color: Colors.blue[900], size: 30,),
                  //                 padding: EdgeInsets.all(12),
                  //             ),
                  //             SizedBox(
                  //                 height: 4,
                  //             ),
                  //             Text(value['card_id'], style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                  //         ],
                  //     ),
                  // );
    //               }).toList(),

                  
              
    //       ) : 
    //       Align(
    //         alignment: Alignment.center,
    //         child: Text('You have not linked any cards yet',textAlign: TextAlign.center,),
    //       )
    //   )
    // );
    
  
}
