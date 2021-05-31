import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
    @override
    _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    final double circleRadius =100.0;
    final double circleBorderWidth = 8.0;
    Color mainColor = Color(0xFF177767);
    TextEditingController dateCtl = TextEditingController();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromRGBO(41,127,141, 25), //mainColor,
            appBar: AppBar(
                elevation: 0.0,
                title: Text('Profile'),
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
                                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                                child: ListView(
                                    children: [
                                        SizedBox(height: 20.0),
                                        // PROFILE IMAGE
                                        Center(
                                            child: SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Stack(
                                                    children: <Widget>[
                                                        Ink(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.rectangle,
                                                                color: Colors.transparent,
                                                            ),
                                                            child: Image(
                                                                image: AssetImage('assets/images/100-welcome.png'),
                                                                fit: BoxFit.cover,
//                                                                color: Colors.black,
                                                                width: 100,
                                                                height: 100,
                                                                alignment: Alignment.center,
                                                            )
                                                        ),
                                                        Align(
                                                            alignment: Alignment(1.5,1.5),
                                                            child: MaterialButton(
                                                                minWidth: 0,
                                                                child: Icon(Icons.camera_alt),
                                                                onPressed: (){},
                                                                textColor: Colors.white,
                                                                color: Theme.of(context).accentColor,
                                                                elevation: 0,
                                                                shape: CircleBorder(),
                                                            ),
                                                        )
                                                    ],
                                                )
                                            ),
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
    
                                        // DATE OF BIRTH
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Text(
                                                        "Date of Birth",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: "Open-sans",
                                                            color: Colors.grey
                                                        ),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    /*TextFormField(
                                                        keyboardType: TextInputType.datetime,
                                                        validator: (value) {
                                                            if (value.isEmpty) {
                                                                return 'Please enter date of birth';
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
                        
                                                            hintText: 'DOB',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.person_outline),
                                                        ),
                                                    ),*/
                                                    
                                                    TextFormField(
                                                        controller: dateCtl,
                                                        decoration: InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(10.0)
                                                                ),
                                                                borderSide: BorderSide(
                                                                    color: Colors.white,
                                                                )
                                                            ),
        
                                                            hintText: 'DOB',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.person_outline),
                                                        ),
                                                        onTap: () async {
                                                            DateTime date = DateTime(1900);
                                                            FocusScope.of(context).requestFocus(new FocusNode());
                                                            date = await showDatePicker(
                                                                context: context,
                                                                initialDate: DateTime.now(),
                                                                firstDate: DateTime(1900),
                                                                lastDate: DateTime(2100)
                                                            );
                                                            dateCtl.text = date.toIso8601String();
                                                        },
                                                    )
                                                ],
                                            ),
                                        ),
    
                                        // ADDRESS
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                    Text(
                                                        "Address",
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
                                                                return 'Please enter address';
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
                        
                                                            hintText: 'Address',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.location_on),
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
                                                        "Phone Number",
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
                                                                return 'Please enter phone number';
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
                        
                                                            hintText: 'Phone Number',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Open-sans'
                                                            ),
                                                            filled: true,
                                                            contentPadding: EdgeInsets.all(16.0),
                                                            prefixIcon: Icon(Icons.phone),
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
    
                                        // SIGN UP BUTTON
                                        SizedBox(height: 20.0),
                                        Container(
                                            padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
                                            width: double.infinity,
                                            child: RaisedButton(
                                                onPressed: () async {},
                                                padding: EdgeInsets.all(20.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                ),
                                                color: CustomTheme.lightTheme.splashColor,
                                                child: Text(
                                                    "save changes".toUpperCase(),
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
                                ),
                            ),
                        )
                    )
                ],
            ),
        );
    }
}
