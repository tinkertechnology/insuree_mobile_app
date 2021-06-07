import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
    @override
    _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
    final double circleRadius = 30.0;
    final double circleBorderWidth = 8.0;
    Color mainColor = Color(0xFF177767);
    TextEditingController dateCtl = TextEditingController();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromRGBO(41,127,141, 25), //mainColor,
            appBar: AppBar(
                elevation: 0.0,
                title: Text('Feedback'),
                backgroundColor: Color.fromRGBO(41,127,141, 0), //mainColor,
            ),
            body: Column(
                children: <Widget>[
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)
                                )
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                                child: ListView(
                                    children: [
                                        SizedBox(height: 8.0),
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                                CircleAvatar(
                                                    radius: circleRadius,
                                                    backgroundColor: CustomTheme.lightTheme.primaryColor.withOpacity(0.25),
                                                    child: Icon(Icons.message_rounded, color: Colors.white, size: 30,),
                                                ),
                                                SizedBox(height: 16.0),
                                                Text(
                                                    'Fill in your query if you have any issue regarding our app',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                    ),
                                                )
                                            ],
                                        ),
                                        // FULL NAME
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Text(
                                                        "Full Name",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "Open-sans",
                                                            color: Colors.grey
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    TextFormField(
                                                        keyboardType: TextInputType.text,
                                                        validator: (value) {
                                                            if (value.isEmpty) {
                                                                return 'Please enter full name';
                                                            }
                                                            return null;
                                                        },
                                                        onSaved: (value) {
                                                            setState(() {
                                                                // userCredential.usernameOrEmail = value;
                                                            });
                                                        },
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(10.0)
                                                                ),
                                                                borderSide: BorderSide(
                                                                    color: Colors.white,
                                                                )
                                                            ),
                                                            hintText: 'Full Name',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.person_outline),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                            
                                        // MOBILE NUMBER
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Text(
                                                        "Mobile Number",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "Open-sans",
                                                            color: Colors.grey
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        validator: (value) {
                                                            if (value.isEmpty) {
                                                                return 'Please enter mobile number';
                                                            }
                                                            return null;
                                                        },
                                                        onSaved: (value) {
                                                            setState(() {
                                                                // userCredential.usernameOrEmail = value;
                                                            });
                                                        },
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(10.0)
                                                                ),
                                                                borderSide: BorderSide(
                                                                    color: Colors.white,
                                                                )
                                                            ),
                                                
                                                            hintText: '9841xxxxxx',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.dialpad),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                            
                                        // EMAIL
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Text(
                                                        "Email Address",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "Open-sans",
                                                            color: Colors.grey
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    TextFormField(
                                                        keyboardType: TextInputType.emailAddress,
                                                        validator: (value) {
                                                            if (value.isEmpty) {
                                                                return 'Please enter email address';
                                                            }
                                                            return null;
                                                        },
                                                        onSaved: (value) {
                                                            setState(() {
                                                                // userCredential.usernameOrEmail = value;
                                                            });
                                                        },
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(10.0)
                                                                ),
                                                                borderSide: BorderSide(
                                                                    color: Colors.white,
                                                                )
                                                            ),
                                                
                                                            hintText: 'Email Address',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.alternate_email),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                            
                                        // FeedbackPage
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Text(
                                                        "Query Description (max. 150 words)",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "Open-sans",
                                                            color: Colors.grey
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    TextFormField(
                                                        keyboardType: TextInputType.text,
                                                        validator: (value) {
                                                            if (value.isEmpty) {
                                                                return 'Please enter FeedbackPage';
                                                            }
                                                            return null;
                                                        },
                                                        onSaved: (value) {
                                                            setState(() {
                                                                // userCredential.usernameOrEmail = value;
                                                            });
                                                        },
                                                        maxLines: 5,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(10.0)
                                                                ),
                                                                borderSide: BorderSide(
                                                                    color: Colors.white,
                                                                )
                                                            ),
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                            
                                        // CANCEL & SUBMIT BUTTON
                                        SizedBox(height: 20.0),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                                Expanded(
                                                    // padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                                    child: RaisedButton(
                                                        onPressed: () async {},
                                                        padding: EdgeInsets.all(16.0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                        ),
                                                        color: Colors.red.shade500,
                                                        child: Text(
                                                            "cancel".toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: "Open-sans",
                                                                color: Colors.white
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                                SizedBox(width: 16.0),
                                                Expanded(
                                                    // padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
                                                    child: RaisedButton(
                                                        onPressed: () async {},
                                                        padding: EdgeInsets.all(16.0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                        ),
                                                        color: CustomTheme.lightTheme.primaryColor,
                                                        child: Text(
                                                            "submit".toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: "Open-sans",
                                                                color: Colors.white
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        )
                                    ],
                                ),
                            ),
                        )
                    )
                ],
            ),
        );
    }
}
