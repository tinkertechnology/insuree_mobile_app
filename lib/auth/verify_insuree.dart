import 'package:card_app/auth/login_card.dart';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:card_app/services/verify_insuree_service.dart';
import 'package:card_app/models/insuree.dart';

class VerifyInsuree extends StatefulWidget {
    @override
    _VerifyInsureeState createState() => _VerifyInsureeState();
}

class _VerifyInsureeState extends State<VerifyInsuree> {
    final _formKey = GlobalKey<FormState>();

    @override
    void initState() {
    // TODO: implement initState
    super.initState();
    print("auth/verify_insuree.dart");
  }
    final Insuree _insuree = Insuree();
    
    final double circleRadius = 100.0;
    final double circleBorderWidth = 8.0;
    
    TextEditingController _yearController = TextEditingController();
    TextEditingController _monthController = TextEditingController();
    TextEditingController _dayController = TextEditingController();
    dynamic verify;

     validateYear(val){
        if(val.length!=4 && val.isNotEmpty ){
            return "Year is invalid please enter valid one";
        }
    }
     validateMonth(val){
        if(val.length!=2 && val.isNotEmpty && val <=12){
            return "Month is invalid please enter valid one";
        }
    }
     validateDay(val){
        if(val.length!=2 && val.isNotEmpty && val <=31 ){
            return "Day is invalid please enter valid one";
        }
    }
    
    @override
    Widget build(BuildContext context) {
        Size deviceSize = MediaQuery.of(context).size;
        return Scaffold(
            backgroundColor: CustomTheme.lightTheme.primaryColor, //Color.fromRGBO(41, 127, 141, 25),,
            body: Container(
                margin: EdgeInsets.only(top: 70),
                height: MediaQuery.of(context).size.height,
                child: Column(
                    children: <Widget>[
                        /*Container(
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Icon(
                                        Icons.clear,
                                        size: 30,
                                        color: Colors.white,
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                            Navigator.pushNamed(context, '/reset-password');
                                        },
                                        child: Text(
                                            "Forget your credentials?",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Open-sans",
                                                color: Colors.white),
                                        ),
                                    ),
                                ],
                            ),
                        ),*/
                        Expanded(
                            child: Form(
                                key: _formKey,
                                child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(top: circleRadius / 2.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(40),
                                                        topRight: Radius.circular(40),
                                                    ),
                                                ),
                                            ),
                                        ),
                                        SingleChildScrollView(
                                            // physics: NeverScrollableScrollPhysics(),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                    Container(
                                                        width: circleRadius,
                                                        height: circleRadius,
                                                        decoration: ShapeDecoration(
                                                            shape: CircleBorder(), color: Colors.white),
                                                        child: Padding(
                                                            padding: EdgeInsets.all(circleBorderWidth),
                                                            child: DecoratedBox(
                                                                decoration: ShapeDecoration(
                                                                    shape: CircleBorder(),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: AssetImage('assets/images/openimis-logo.png'),
                                                                    ),
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                    
                                                    SizedBox(height: 8.0),
                                                    ListTile(
                                                        title: Text(
                                                            "Let's Sign You In",
                                                            style: TextStyle(
                                                                fontSize: 24, fontWeight: FontWeight.w400),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                        subtitle: Text(
                                                            "Welcome back, you've been missed!",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.grey),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                    ),
                                                    
                                                    // PHONE NUMBER CONTAINER
                                                    SizedBox(height: 8.0),
                                                    _buildInsureeCHFID(),
                                                    _buildFamilyCHFID(),
                                                    _buildDOBTF(),
                                                    SizedBox(height: 16.0),
                                                    // VERIFY BUTTON
                                                    _buildVerifyTF(),
                                                ],
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        )
                    ],
                ),
            ),
            bottomNavigationBar: BottomAppBar(
                child: Container(
                    height: 50,
                    color: CustomTheme.lightTheme.primaryColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
//                            IconButton(
//                                icon: Icon(Icons.location_on),
//                                color: Colors.white,
//                                onPressed: () => showDialog(
//                                    context: context,
//                                    builder: (BuildContext context){
//                                        return _OfficeDetailWidget();
//                                    }),
//                            ),
                            IconButton(
                                icon: Icon(Icons.work),
                                color: Colors.white,
                                onPressed: () {
                                    print('OfficeRelated clicked...');
                                    Navigator.pushNamed(context, '/offices');
                                },
                            ),
//                            IconButton(
//                                icon: Icon(Icons.phone_in_talk),
//                                color: Colors.white,
//                                onPressed: () => showDialog(
//                                    context: context,
//                                    builder: (BuildContext context){
//                                        return _ContactDetailsWidget();
//                                    }),
//                            ),
                            IconButton(
                                icon: Icon(Icons.info_outline),
                                color: Colors.white,
                                onPressed: () {
                                    Navigator.pushNamed(context, '/faq');
                                },
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    // INSUREE CHFID
    Widget _buildInsureeCHFID() {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Text(
                        "Insurance Number",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Open-sans",
                            color: Colors.grey),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'Please enter insurance number';
                            }
                            return null;
                        },
                        onSaved: (value) {
                            setState(() {
                                _insuree.chfid = value;
                            });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Colors.white,
                                )),
                            hintText: 'Insurance Number',
                            hintStyle: TextStyle(fontFamily: 'Montserrat'),
                            filled: true,
                            contentPadding: EdgeInsets.all(16.0),
                            prefixIcon: Icon(Icons.dialpad),
                        ),
                    ),
                ],
            ),
        );
    }

    // FAMILY HEAD CHFID
    Widget _buildFamilyCHFID() {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Text(
                        "Family Head Insurance Number",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Open-sans",
                            color: Colors.grey),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                        validator: (value) {
                            if (value.isEmpty) {
                                return 'Please enter family head insurance number';
                            }
                            return null;
                        },
                        onSaved: (value) {
                            setState(() {
                                _insuree.fhchfid = value;
                            });
                        },
                        decoration: InputDecoration(
                            hintText: 'Family Head Insurance Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            hintStyle: TextStyle(fontFamily: 'Montserrat'),
                            filled: true,
                            contentPadding: EdgeInsets.all(16.0),
                            prefixIcon: Icon(Icons.dialpad)),
                        keyboardType: TextInputType.number,
                        //obscureText: true,
                    ),
                ],
            ));
    }

    // DATE OF BIRTH (YYY-MM-DD)
    Widget _buildDOBTF() {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    Text(
                        "Date of Birth (BS)",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Open-sans",
                            color: Colors.grey),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                            Expanded(
                                child: Column(
                                    children: <Widget>[
                                        TextFormField(
                                            decoration: InputDecoration(
                                                hintText: 'YYYY',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10.0))),
                                                hintStyle: TextStyle(fontFamily: 'Montserrat'),
                                                filled: true,
                                                contentPadding: EdgeInsets.all(16.0),
                                                errorText: validateYear(_yearController.text),
                                            ),
                                            keyboardType: TextInputType.number,
                                            obscureText: false,
                                            controller: _yearController,
                                            maxLength: 4,
                                        )
                                    ],
                                )),
                            SizedBox(width: 8.0),
                            Expanded(
                                child: Column(
                                    children: <Widget>[
                                        TextFormField(
                                            decoration: InputDecoration(
                                                hintText: 'MM',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10.0))),
                                                hintStyle: TextStyle(fontFamily: 'Montserrat'),
                                                filled: true,
                                                contentPadding: EdgeInsets.all(16.0),
                                                errorText: validateMonth(_monthController.text)
                                            ),
                                            keyboardType: TextInputType.number,
                                            obscureText: false,
                                            controller: _monthController,
                                            maxLength: 2,
                                        )
                                    ],
                                )),
                            SizedBox(width: 8),
                            Expanded(
                                child: Column(
                                    children: <Widget>[
                                        TextFormField(
                                            decoration: InputDecoration(
                                                hintText: 'DD',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10.0))),
                                                hintStyle: TextStyle(fontFamily: 'Montserrat'),
                                                filled: true,
                                                contentPadding: EdgeInsets.all(16.0),
                                                errorText: validateDay(_dayController.text),
                                            ),
                                            keyboardType: TextInputType.number,
                                            obscureText: false,
                                            controller: _dayController,
                                            maxLength: 2,
                                        )
                                    ],
                                )),
                        ],
                    )
                ],
            )
        );
    }

    // VERIFY BUTTON
    Widget _buildVerifyTF(){
        return Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: double.infinity,
            child: RaisedButton(
                onPressed: () async {
                    _insuree.dob = "${_yearController.text}-${_monthController.text}-${_dayController.text}";
                    // Validate form
                    if (_formKey.currentState.validate()) {
                        // Update values
                        _formKey.currentState.save();
                        // Hit Api
                    }
                    var verify = await VerifyInsureeService()
                        .VerifyInsureeData(_insuree);

//                    if (verify == null) {
//                        Fluttertoast.showToast(
//                            msg: "Incorrect Details ",
//                            toastLength: Toast.LENGTH_SHORT,
//                            gravity: ToastGravity.CENTER,
//                            timeInSecForIos: 1,
//                            fontSize: 16.0);
//                    } else {
                        Fluttertoast.showToast(
                            msg: "Verify Your Otp for Login",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                    chfid: _insuree.chfid,
                                ),
                            ));
//                    }
                },
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                ),
                color: CustomTheme.lightTheme.primaryColor, //Color.fromRGBO(254, 196, 45, 50),
                child: VerifyInsureeService().isLoading
                    ? CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white))
                    : Text(
                    "Verify".toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Open-sans",
                        color: Colors.white
                    ),
                ),
            )
        );
    }
    
    // ALERT DIALOG - OFFICE DETAIL
    Widget _OfficeDetailWidget(){
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)
            ),
            contentPadding: EdgeInsets.all(0.0),
    
            content:  Container(
                height: 260,
                color: CustomTheme.lightTheme.primaryColor,
                child: Column(
                    children: [
                        Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(top: 4.0),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                        Text('Office Details',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ],
                                )
                            ),
                        ),
                
                        Container(
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    ListTile(
                                        title: Text('openIMIS'),
                                        subtitle: Text('Phone: 01-42xxxxx'),
                                    ),
                                    ListTile(
                                        title: Text('Email'),
                                        subtitle: Text('openimis@gmail.com'),
                                    ),
                                    ListTile(
                                        title: Text('Address'),
                                        subtitle: Text('Kathmandu, Nepal'),
                                    ),
                                ],
                            ),
                        )
                    ],
                ),
            ),
        );
    }

    // ALERT DIALOG - CONTACT DETAIL
    Widget _ContactDetailsWidget(){
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)
            ),
            contentPadding: EdgeInsets.all(0.0),
    
            content:  Container(
                height: 120,
                color: CustomTheme.lightTheme.primaryColor,
                child: Column(
                    children: [
                        Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(top: 4.0),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                        Text('Contact Details',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ],
                                )
                            ),
                        ),
                
                        Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    ListTile(
                                        title: Text('openIMIS'),
                                        subtitle: Text('Phone: 01-42xxxxx'),
                                    )
                                ],
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}
