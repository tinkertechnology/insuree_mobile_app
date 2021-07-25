import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openimis_web_app/blocks/auth_block.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import  'package:openimis_web_app/common/env.dart' as env;

class PasswordResetForm extends StatefulWidget {
    @override
    _PasswordResetFormState createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {

    String mobile;
    String new_password;
    String confirm_new_password;
    bool isLoading= false;

    void changePassword() async{
        var validateOTP = env.API_BASE_URL+'/api/change_password_afterotp/';
        if(this.mounted) {
            setState(() {
                isLoading = true;
            });
        }
        final response = await http.post(Uri.parse(validateOTP),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
//        'Authorization': 'JWT ' + auth.user['token'],

            },

            body: jsonEncode(<String, String>{
                "mobile": mobile.toString(),
                "new_password": new_password,
                "confirm_new_password": confirm_new_password

            }),

        );
        if (response.statusCode == 200) {
            print(response.body);
            Fluttertoast.showToast(
//          msg: e.toString(),
                msg: 'Password Sucessfully changed',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,

                //timeInSecForIosWeb: 1,
                timeInSecForIos: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );


            Navigator.popAndPushNamed(context, '/auth',
                arguments: mobile);

//      Navigator.pushNamed(context, '/verify_otp', arguments: {
//        'mobile' : ''
//      });
        }

        else {

            Fluttertoast.showToast(
//          msg: e.toString(),
                msg: response.body,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,

                //timeInSecForIosWeb: 1,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

        }
        if(this.mounted) {
            setState(() {
                isLoading = false;
            });
        }


    }

    @override
    Widget build(BuildContext context) {
        final args = ModalRoute.of(context).settings.arguments;
        setState(() {
          mobile=args;
        });

        Widget _buildMobileTF() {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(
                        'Mobile Number',
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Futura',
                        ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            enabled: false,
                            enableInteractiveSelection: false,
                            onTap: () { FocusScope.of(context).requestFocus(new FocusNode()); },
                            initialValue: args,
                        ),
                    ),
                ],
            );
        }


        Widget _buildPasswordTF() {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(
                        'New Password',
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Futura',
                        ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Please enter new password';
                                }
                                return null;
                            },
                            onSaved: (value) {
                                setState(() {
                                    new_password = value;
                                });
                            },
                            onChanged: (text) {
                                new_password= text;
                            },
                            decoration: InputDecoration(
                                hintText: "Enter New Password",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                ),
                            ),
                            obscureText: true,
                        ),
                    ),
                ],
            );
        }

        Widget _buildConfirmPasswordTF() {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(
                        'Confirm New Password',
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'futura',
                        ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextFormField(
                            validator: (value) {
                                if (value.isEmpty) {
                                    return 'Please enter same password';
                                }
                                else if(new_password != confirm_new_password){
                                    return 'Password fields do not match';
                                }
                                else if(new_password.length < 8){
                                    return 'Password must be 8 character long';
                                }
                                return null;
                            },
                            onChanged: (text) {
                                confirm_new_password = text;
                            },
                            decoration: InputDecoration(
                                hintText: "Confirm New Password",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                ),
                            ),
                            obscureText: true,
                        ),
                    ),
                ],
            );
        }

        Widget _buildRegisterBtn() {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
                child: Consumer<AuthBlock>(
                    builder: (BuildContext context, AuthBlock auth, Widget child){
                        return RaisedButton(
                            elevation: 5.0,
                            child: Text(
                                'Reset Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Futura',
                                ),
                            ),
                            onPressed: changePassword,
                            padding: EdgeInsets.all(15.0),
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(30.0),
//                            ),
                            color: Color.fromRGBO(0, 153, 182, 50),
                        );
                    },
                ),
            );
        }

        return Scaffold(
            appBar: new AppBar(
                elevation: 0.0,
                backgroundColor: Color.fromRGBO(0, 153, 182, 50),
                title: Text('Reset Password'),
            ),

            body: Stack(
                children: <Widget>[
                    Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                        ),
                    ),

                    isLoading ? Container(child: Center(child: CircularProgressIndicator()))
                        :Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0,
                                vertical: 0.0,
                            ),

                            child: Form(

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        const SizedBox(height: 30),
                                        _buildMobileTF(),
                                        SizedBox(height: 10.0),
                                        _buildPasswordTF(),
                                        SizedBox(height: 10.0),
                                        _buildConfirmPasswordTF(),
                                        SizedBox(height: 10.0),
                                        _buildRegisterBtn(),
                                        SizedBox(height: 20),
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
