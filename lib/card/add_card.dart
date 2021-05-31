import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_app/models/userform.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_app/services/add_card_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
  final int affiliate_id;
  final int cardpk;
  AddCard({Key key, @required this.affiliate_id, this.cardpk})
      : super(key: key);
}

class _AddCardState extends State<AddCard> {
  // int cardId = widget.cardpk;
  final _formKey = GlobalKey<FormState>();
  // final _user = UserForm();
  UserForm _user = new UserForm();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _cardIdController = TextEditingController();
  final TextEditingController _validFromController = TextEditingController();
  final TextEditingController _validToController = TextEditingController();

  dynamic cardDetails;
  @override
  void initState() {
    super.initState();
  }

  Future<UserForm> save(String cardId, String accountName, String validFrom,
      String validTo) async {
    _showDialog(context);
    final String apiUrl = env.API_BASE_URL + "/api/card/";

    final response = await http.post(Uri.parse(apiUrl), headers: {
      "Authorization": 'JWT ' + env.getAuthToken(null)
    }, body: {
      "card_id": cardId, //_user.card_id,
      "card_holder_name": accountName, //_user.cardHolderName,
      "affiliates_id": widget.affiliate_id.toString(),
      "month": validFrom,
      "year": validTo
    });

    if (response.statusCode == 201) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      final String responseString = response.body;
      _showSuccessDialog(context);
      AnimatedButton(
        text: 'Succes Dialog',
        color: Colors.orange,
        pressEvent: () {
          AwesomeDialog(
              context: context,
              animType: AnimType.LEFTSLIDE,
              headerAnimationLoop: false,
              dialogType: DialogType.SUCCES,
              title: 'Succes',
              desc:
                  'Dialog description here..................................................',
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              onDissmissCallback: () {
                debugPrint('Dialog Dissmiss from callback');
              })
            ..show();
        },
      );
      return UserFormFromJson(responseString);
    } else {
      // _scaffoldKey.currentState.removeCurrentSnackBar();
      _showErrorDialog(context, response.body);
    }
  }

  Color getColor(arg) {
    if (arg == 'blue') {
      return Colors.blue;
    }
    if (arg == 'red') {
      return Colors.red;
    }
    if (arg == 'green') {
      return Colors.green;
    }
    if (arg == 'purple') {
      return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = "add_card.dart";
    print(page);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(234, 239, 255, 1),
      appBar: AppBar(
        title: widget.cardpk != null
            ? Text("Card View")
            : Text('Add Your New Card'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white),
        backgroundColor: Color.fromRGBO(234, 239, 255, 1),
        elevation: 0.0,
      ),
      body: widget.cardpk != null
          ? FutureBuilder(
              future: RetriveLinkedCard(widget.cardpk),
              builder: (BuildContext context, dynamic snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: SingleChildScrollView(
                      // physics: NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Card(
                                          color: getColor(snapshot
                                              .data
                                              .affiliate
                                              .cardColor), //Color.fromRGBO(234, 239, 255, 50),
                                          elevation: 0.0,
                                          margin: EdgeInsets.fromLTRB(
                                              15.0, 2.0, 15.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                top: 20,
                                                right: 20,
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: getColor(snapshot
                                                  .data.affiliate.cardColor),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                // CARD LOGO
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: snapshot
                                                              .data
                                                              .affiliate
                                                              .logo,
                                                          // value['affiliate']['logo'],"http://via.placeholder.com/350x150",
                                                          placeholder: (context,
                                                                  url) =>
                                                              new CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Icon(
                                                                  Icons.error),
                                                        ),
                                                      ),
                                                      //

                                                      Text(
                                                        snapshot.data
                                                            .cardHolderName,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                "Open-sans",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 10.0),
                                                // CARD NUMBER
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Text(
                                                        snapshot.data.cardId
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 28.0,
                                                            fontFamily:
                                                                "Open-sans",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(height: 20.0),
                                                // CARD HOLDER & EXPIRED
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20.0),
                                                          child: Text(
                                                              "Card Holder"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 16.0),
                                                          child: Text(snapshot
                                                              .data
                                                              .cardHolderName),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 16.0),
                                                          child:
                                                              Text("Expires"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 16.0),
                                                          child: Text(
                                                            "09/22",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    "Open-sans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // CARD NUMBER
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 8),
                                              child: Text(
                                                "Card Number",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Open-sans",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 80,
                                              child: TextFormField(
                                                initialValue:
                                                    snapshot.data.cardId,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                // onChanged: ,
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 19,
                                                maxLengthEnforced: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      borderSide:
                                                          BorderSide.none),
                                                  filled: true,
                                                  prefixIcon: Icon(
                                                    Icons.dialpad,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  fillColor: Colors.grey
                                                      .withOpacity(0.1),
                                                  hintText: "Cardholder Number",
                                                  // errorText: snapshot.error,
                                                ),
                                              ),
                                            ),

                                            // CARD HOLDER NAME
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, bottom: 8),
                                              child: Text(
                                                "Card Holder Name",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Open-sans",
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 70,
                                              child: TextFormField(
                                                initialValue: snapshot
                                                    .data.cardHolderName,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                // onChanged: ,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      borderSide:
                                                          BorderSide.none),
                                                  filled: true,
                                                  prefixIcon: Icon(
                                                    Icons.account_circle,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  fillColor: Colors.grey
                                                      .withOpacity(0.1),
                                                  hintText: "Cardholder Name",
                                                  // errorText: snapshot.error,
                                                ),
                                              ),
                                            ),

                                            // MONTH & YEAR
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                    width: 160.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Text(
                                                            "Month",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Open-sans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          maxLength: 2,
                                                          maxLengthEnforced:
                                                              true,
                                                          decoration:
                                                              InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            filled: true,
                                                            prefixIcon: Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 25,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            fillColor: Colors
                                                                .grey
                                                                .withOpacity(
                                                                    0.1),
                                                            hintText: 'MM',
                                                            counterText: '',
                                                            // errorText: snapshot.error,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Container(
                                                    width: 160.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  bottom: 8),
                                                          child: Text(
                                                            "Year",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Open-sans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          maxLength: 2,
                                                          maxLengthEnforced:
                                                              true,
                                                          decoration:
                                                              InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            filled: true,
                                                            prefixIcon: Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 25,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            fillColor: Colors
                                                                .grey
                                                                .withOpacity(
                                                                    0.1),
                                                            hintText: 'YYYY',
                                                            counterText: '',
                                                            // errorText: snapshot.error,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            ),

                                            SizedBox(height: 10.0),
                                            Container(
                                              width: 150.0,
                                              height: 150.0,
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data.qrImage,
                                                // value['affiliate']['logo'], //"http://via.placeholder.com/350x150",
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            ),

                                            SizedBox(height: 30.0),
                                            // NEXT BUTTON
                                            Container(
                                              // padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                              width: double.infinity,
                                              child: RaisedButton(
                                                onPressed: () {},
                                                padding: EdgeInsets.all(16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                color: Color.fromRGBO(
                                                    254, 196, 45, 50),
                                                child: Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Open-sans"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return (Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
          : Container(
              child: SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // CARD
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Card(
                                    color: Color.fromRGBO(234, 239, 255, 50),
                                    elevation: 0.0,
                                    margin: EdgeInsets.fromLTRB(
                                        15.0, 2.0, 15.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                          right: 20,
                                          bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.red),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          // CARD LOGO
                                          Container(
                                            // padding: EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Image(
                                                  image: AssetImage(
                                                      'assets/images/wallet_card.png'),
                                                  width: 65.0,
                                                  height: 60.0,
                                                ),
                                                Text(
                                                  "Card Name",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                      fontFamily: "Open-sans",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 10.0),
                                          // CARD NUMBER
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  _cardIdController.text,
                                                  style: TextStyle(
                                                      fontSize: 28.0,
                                                      fontFamily: "Open-sans",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 8.0),
                                          // CARD HOLDER & EXPIRED
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0),
                                                    child: Text(
                                                        _accountHolderNameController
                                                            .text),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16.0),
                                                    child: Text("Hari Bahadur"),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16.0),
                                                    child: Text("Expires"),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16.0),
                                                    child: Text(
                                                      "09/22",
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontFamily:
                                                              "Open-sans",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // CARD DETAILS
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // CARD NUMBER
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 8),
                                        child: Text(
                                          "Card Number",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Open-sans",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: SizedBox(
                                          height: 80,
                                          child: TextFormField(
                                            controller: _cardIdController,
                                            // initialValue: snapshot.data.cardHod,
                                            textCapitalization:
                                                TextCapitalization.characters,
                                            // onChanged: ,
                                            keyboardType: TextInputType.number,
                                            maxLength: 19,
                                            maxLengthEnforced: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              prefixIcon: Icon(
                                                Icons.dialpad,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              fillColor:
                                                  Colors.grey.withOpacity(0.1),
                                              hintText: "Cardholder Number",
                                              // errorText: snapshot.error,
                                            ),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter Card Holder Name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      // CARD HOLDER NAME
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 8),
                                        child: Text(
                                          "Card Holder Name",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Open-sans",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 70,
                                        child: TextFormField(
                                          controller:
                                              _accountHolderNameController,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          // onChanged: ,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide.none),
                                            filled: true,
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              size: 25,
                                              color: Colors.black,
                                            ),
                                            fillColor:
                                                Colors.grey.withOpacity(0.1),
                                            hintText: "Cardholder Name",
                                            // errorText: snapshot.error,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter Card Holder Name';
                                            }
                                            return null;
                                          },
                                          onSaved: (val) => setState(
                                              () => _user.cardHolderName = val),
                                        ),
                                      ),

                                      // MONTH & YEAR
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              width: 160.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8, bottom: 8),
                                                    child: Text(
                                                      "Month",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Open-sans",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _validFromController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 2,
                                                    maxLengthEnforced: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      filled: true,
                                                      prefixIcon: Icon(
                                                        Icons.calendar_today,
                                                        size: 25,
                                                        color: Colors.black,
                                                      ),
                                                      fillColor: Colors.grey
                                                          .withOpacity(0.1),
                                                      hintText: 'MM',
                                                      counterText: '',
                                                      // errorText: snapshot.error,
                                                    ),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter month';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              )),
                                          Container(
                                              width: 160.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8, bottom: 8),
                                                    child: Text(
                                                      "Year",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "Open-sans",
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _validToController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    maxLength: 2,
                                                    maxLengthEnforced: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      filled: true,
                                                      prefixIcon: Icon(
                                                        Icons.calendar_today,
                                                        size: 25,
                                                        color: Colors.black,
                                                      ),
                                                      fillColor: Colors.grey
                                                          .withOpacity(0.1),
                                                      hintText: 'YYYY',
                                                      counterText: '',
                                                      // errorText: snapshot.error,
                                                    ),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter year';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),

                                      // NEXT BUTTON
                                      SizedBox(height: 20.0),
                                      Container(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            final form = _formKey.currentState;
                                            if (form.validate()) {
                                              form.save();
                                              // _user.save();
                                              // save,
                                              final UserForm user = await save(
                                                _cardIdController.text,
                                                _accountHolderNameController
                                                    .text,
                                                _validFromController.text,
                                                _validToController.text,
                                              );
                                              setState(() {
                                                _user = user;
                                              });
                                              // _showDialog(context);
                                            }
                                          },
                                          padding: EdgeInsets.all(16.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          color:
                                              Color.fromRGBO(254, 196, 45, 50),
                                          child: Text(
                                            "Next",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Open-sans"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // _showDialog(BuildContext context) {
  //   Scaffold.of(context)
  //       .showSnackBar(SnackBar(content: Text('Submitting form')));
  // }
  _showDialog(BuildContext context) {
    final snackBar = SnackBar(content: Text('Working on...'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showSuccessDialog(BuildContext context) {
    final snackBar = SnackBar(content: Text('Card added'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _showErrorDialog(BuildContext context, text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Color.fromARGB(255, 255, 0, 0),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
