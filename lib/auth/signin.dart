import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:openimis_web_app/models/user.dart';
import 'package:provider/provider.dart';
import  'package:openimis_web_app/common/env.dart' as env;

class SignIn extends StatefulWidget {
    @override
    _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

    final _formKey = GlobalKey<FormState>();
    final UserCredential userCredential = UserCredential();

    @override
    void initState() {
    // TODO: implement initState
    super.initState();
//    env.asyncThenloadSaveUserMobileNumber();
  }
    @override
    Widget build(BuildContext context) {

        Widget _buildLoginBtn() {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
                child: Consumer<AuthBlock>(
                    builder: (BuildContext context, AuthBlock auth, Widget child){
                        return RaisedButton(
                            elevation: 5.0,
                            child: auth.loading && auth.loadingType == 'login' ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                            ) : Text(
                                'Login',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 153, 182, 50),
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Futura',
                                ),
                            ),
                            onPressed: () async {
                                // Validate form
                                if (_formKey.currentState.validate() && !auth.loading) {
                                    // Update values
                                    _formKey.currentState.save();
                                    // Hit Api
                                    var login = await auth.login(userCredential);
                                    Timer.periodic(Duration(milliseconds: 500), (timer) {
                                        print(DateTime.now());
                                        print('sign in');
                                        if(auth.isLoggedIn){
                                            timer.cancel();
                                            Navigator.pushNamed(context, '/card');
                                        }
                                        timer.cancel();
                                    });
                                }
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                        );
                    },
                ),
            );
        }

        return Scaffold(

            body: Stack(
                children: <Widget>[
                    Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 153, 182, 50),
                        ),
                    ),

                    Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                            // physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0,
                                vertical: 0.0,
                            ),

                        child: Form(
                            key: _formKey,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    SizedBox(height: 50),
                                    Image.asset('assets/images/white_logo.png', fit: BoxFit.fitWidth,),
                                    SizedBox(height: 30),
                                    SizedBox(height: 20),
                                    _buildLoginBtn(),

                                    Text(
                                        'or',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'futura',
                                            fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 10),


                                    /*Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            _buildSignUpBtn(),
                                            _buildForgotPasswordBtn(),
                                        ],
                                    ),*/
                                ],
                            ),
                        ),
                        ),
                    ),
                ],
            ),
        );
    }
}
