import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
    @override
    ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
    final _formKey = GlobalKey<FormState>();
    final double circleRadius =100.0;
    final double circleBorderWidth = 8.0;
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromRGBO(234, 239, 255, 30),
            body: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 8.0, top: 20.0, right: 20.0, bottom: 20.0),
                            margin: EdgeInsets.only(top: 30),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.clear, size: 30),
                                        onPressed: (){
                                        	Navigator.popAndPushNamed(context, '/');
                                        }
                                    )
                                ],
                            ),
                        ),
                    
                        Expanded(
                            child: Form(
                                key: _formKey,
                                child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(top: circleRadius/2.0),
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
                                            physics: NeverScrollableScrollPhysics(),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                    Container(
                                                        width: circleRadius,
                                                        height: circleRadius,
                                                        decoration: ShapeDecoration(
                                                            shape: CircleBorder(),
                                                            color: Colors.white
                                                        ),
                                                        child: Padding(
                                                            padding: EdgeInsets.all(circleBorderWidth),
                                                            child: DecoratedBox(
                                                                decoration: ShapeDecoration(
                                                                    shape: CircleBorder(),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/a/a0/Bill_Gates_2018.jpg',)
                                                                    )
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                
                                                    SizedBox(height: 30.0),
                                                    // REGISTER DESCRIPTION
                                                    ListTile(
                                                        title: Text(
                                                            "Reset your password",
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight: FontWeight.w400
                                                            ),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                        subtitle: Expanded(
                                                            child: Text(
                                                                "At least 8 characters, with uppercase and lowercase letters",
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: Colors.grey
                                                                ),
                                                                textAlign: TextAlign.center,
                                                            ),
                                                        )
                                                    ),
                                                
                                                    // PHONE NUMBER CONTAINER
                                                    SizedBox(height: 30.0),
                                                    Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                                Text(
                                                                    "New Password",
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
                                                                            return 'Please Enter mobile number';
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
                                                                    
                                                                        hintText: 'Mobile or Email',
                                                                        hintStyle: TextStyle(
                                                                            fontFamily: 'Montserrat'
                                                                        ),
                                                                        filled: true,
                                                                        contentPadding: EdgeInsets.all(16.0),
                                                                        prefixIcon: Icon(Icons.person_outline),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                
                                                    // PASSWORD CONTAINER
                                                    SizedBox(height: 8.0),
                                                    Container(
                                                        padding: EdgeInsets.all(20.0),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                                Text(
                                                                    "Confirm Password",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontFamily: "Open-sans",
                                                                        color: Colors.grey
                                                                    ),
                                                                ),
                                                                SizedBox(height: 8.0),
                                                                TextFormField(
                                                                    validator: (value) {
                                                                        if (value.isEmpty) {
                                                                            return 'Please enter password';
                                                                        }
                                                                        return null;
                                                                    },
                                                                    onSaved: (value) {
                                                                        setState(() {
                                                                            // userCredential.password = value;
                                                                        });
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        hintText: 'Password',
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.all(
                                                                                Radius.circular(10.0)
                                                                            )
                                                                        ),
                                                                        hintStyle: TextStyle(
                                                                            fontFamily: 'Montserrat'
                                                                        ),
                                                                        filled: true,
                                                                        contentPadding: EdgeInsets.all(16.0),
                                                                        prefixIcon: Icon(Icons.lock_outline)
                                                                    ),
                                                                    keyboardType: TextInputType.text,
                                                                    obscureText: true,
                                                                ),
                                                            ],
                                                        )
                                                    ),
                                                
                                                    SizedBox(height: 30.0),
                                                    // SIGN IN BUTTON
                                                    Container(
                                                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                                        width: double.infinity,
                                                        child: Consumer<AuthBlock>(
                                                            builder: (BuildContext context, AuthBlock auth, Widget child){
                                                                return RaisedButton(
                                                                    onPressed: () async {
                                                                    
                                                                    },
                                                                    padding: EdgeInsets.all(16.0),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                    ),
                                                                    color: Color.fromRGBO(254, 196, 45, 50),
                                                                    child: auth.loading && auth.loadingType == 'login'
                                                                        ? CircularProgressIndicator(
                                                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                                                                        : Text(
                                                                        "Sign In",
                                                                        style: TextStyle(
                                                                            fontSize: 16.0,
                                                                            fontWeight: FontWeight.w400,
                                                                            fontFamily: "Open-sans"
                                                                        ),
                                                                    ),
                                                                );
                                                            }
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        )
                                    ],
                                ),
                            ),
                        )
                    ],
                ),
            )
        );
    }
}