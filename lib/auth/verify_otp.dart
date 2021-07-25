import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:openimis_web_app/common/env.dart' as env;

class OtpPage extends StatefulWidget {
    @override
    OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {

    TextEditingController controller1 = new TextEditingController();
    TextEditingController controller2 = new TextEditingController();
    TextEditingController controller3 = new TextEditingController();
    TextEditingController controller4 = new TextEditingController();
    TextEditingController controller5 = new TextEditingController();
    TextEditingController controller6 = new TextEditingController();

    TextEditingController currController = new TextEditingController();
    String otpCode;
    String mobile;

    @override
    void dispose() {
        super.dispose();
        controller1.dispose();
        controller2.dispose();
        controller3.dispose();
        controller4.dispose();
        controller5.dispose();
        controller6.dispose();
    }

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        currController = controller1;

    }

    @override
    Widget build(BuildContext context) {
        final args = ModalRoute.of(context).settings.arguments;
        setState(() {
            mobile = args;
        });
        List<Widget> widgetList = [
            Padding(
                padding: EdgeInsets.only(left: 0.0, right: 2.0),
                child: new Container(
                    color: Colors.transparent,
                ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        border: new Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                        borderRadius: new BorderRadius.circular(4.0)
                    ),
                    child: new TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                        ],
                        enabled: false,
                        controller: controller1,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24.0, color: Colors.black),

                    )

                ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        border: new Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                        borderRadius: new BorderRadius.circular(4.0)
                    ),
                    child: new TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                        ],
                        controller: controller2,
                        autofocus: false,
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        border: new Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                        borderRadius: new BorderRadius.circular(4.0)
                    ),
                    child: new TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                        ],

                        keyboardType: TextInputType.number,
                        controller: controller3,
                        textAlign: TextAlign.center,
                        autofocus: false,
                        enabled: false,
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        border: new Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                        borderRadius: new BorderRadius.circular(4.0)
                    ),
                    child: new TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                        ],

                        textAlign: TextAlign.center,
                        controller: controller4,
                        autofocus: false,
                        enabled: false,
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        border: new Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                        borderRadius: new BorderRadius.circular(4.0)
                    ),
                    child: new TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                        ],

                        textAlign: TextAlign.center,
                        controller: controller5,
                        autofocus: false,
                        enabled: false,
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                child: new Container(
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        border: new Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(0, 0, 0, 0.1)
                        ),
                        borderRadius: new BorderRadius.circular(4.0)
                    ),
                    child: new TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                        ],

                        textAlign: TextAlign.center,
                        controller: controller6,
                        autofocus: false,
                        enabled: false,
                        style: TextStyle(fontSize: 24.0, color: Colors.black),
                    ),
                ),
            ),

            Padding(
                padding: EdgeInsets.only(left: 2.0, right: 0.0),
                child: new Container(
                    color: Colors.transparent,
                ),
            ),

        ];

        return new Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: Text(
                    "Enter OTP",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Futura',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                    ),
                ),
                backgroundColor: Color.fromRGBO(0, 153, 182, 50)),
            backgroundColor: Color(0xFFeaeaea),
            body: Container(
                child: Column(
                    children: <Widget>[
                        /*Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                                'Pharmacy',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 187, 148, 50)
                                ),
                                textAlign: TextAlign.center,
                            ),
                        ),*/

                        /*Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: Text(
                                'We deals with medicine',
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 3.0,
                                    color: Colors.grey
                                ),
                                textAlign: TextAlign.center,
                            ),
                        ),*/

                        Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Image(
                                image: AssetImage('assets/images/enter_otp.png'),
                                height: 100.0,
                                width: 80.0,),
                        ),

                        // const SizedBox(height: 10.0),
                        Flexible(
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                            "ENTER OTP",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(0, 153, 182, 50)
                                            ),
                                        ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0),
                                        child: Text(
                                            "We have sent you OTP to your mobile number for verification.",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.normal,
                                                wordSpacing: 3.0,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
//                                    Padding(
//                                        padding: const EdgeInsets.only(
//                                            left: 30.0, top: 2.0, right: 30.0),
//                                        child: Text(
//                                            "+977"+ args.toString(),
//                                            style: TextStyle(
//                                                fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.red),
//                                            textAlign: TextAlign.center,),
//                                    ),
                                ],
                            ),
                            // SIX DIGIT CODE RA VERIFY NUMBER KO PADDING
                            flex: 60,),

                        Flexible(child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                GridView.count (
                                    crossAxisCount: 8,
                                    mainAxisSpacing: 10.0,
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    children: List < Container>.generate(8, (int index) => Container(child: widgetList[index]))
                                ),
                            ]
                        )
                            , flex: 30,),

                        Flexible(child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                new Container(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 0.0, right:8.0, bottom: 0.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                                MaterialButton(onPressed: () {inputTextToField("1");},
                                                    child: Text(
                                                        "1",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () {inputTextToField("2");},
                                                    child: Text(
                                                        "2",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () {inputTextToField("3");},
                                                    child: Text(
                                                        "3",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),

                                new Container(
                                    child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children:<Widget>[
                                                MaterialButton(onPressed: () {inputTextToField("4");},
                                                    child: Text(
                                                        "4",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () {inputTextToField("5");},
                                                    child: Text(
                                                        "5",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () {inputTextToField("6");},
                                                    child: Text(
                                                        "6",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),

                                new Container(
                                    child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children:<Widget>[
                                                MaterialButton(onPressed: () {inputTextToField("7");},
                                                    child: Text(
                                                        "7",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () {inputTextToField("8");},
                                                    child: Text(
                                                        "8",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () {inputTextToField("9");},
                                                    child: Text(
                                                        "9",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ),

                                new Container(
                                    child: Padding(
                                        padding:const EdgeInsets.only(left: 90.0, top: 0.0, right: 8.0, bottom: 0.0),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children:<Widget>[
//                                                MaterialButton(onPressed: () {deleteText();},
//                                                    child: Image.asset('assets/images/delete.png', width: 25.0, height: 25.0)
//                                                ),

                                                MaterialButton(onPressed: () { inputTextToField("0");},
                                                    child: Text(
                                                        "0",
                                                        style: TextStyle(
                                                            fontSize: 25.0,
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                        textAlign: TextAlign.center
                                                    ),
                                                ),

                                                MaterialButton(onPressed: () { deleteText(); },
                                                    child: Image.asset('assets/images/delete.png', width: 25.0, height: 25.0)
                                                ),
                                            ],
                                        ),
                                    ),
                                ),
                            ],
                        ), flex: 95,),

                        Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: RaisedButton(
                                elevation: 5.0,
                                child: Text(
                                    'Proceed to Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Futura',
                                    ),
                                ),
                                onPressed: (){ matchOtp();},
                                padding: EdgeInsets.all(15.0),
                                color: Color.fromRGBO(1, 153, 182, 50),
                            ),
                        ),

                        SizedBox(height: 10),
                        Text.rich(
                            TextSpan(
                                children: [
                                    TextSpan(
                                        text: "Don't receive the OTP? ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Futura'
                                        )
                                    ),
                                    WidgetSpan(
                                        child: InkWell(
                                            onTap: (){
                                               _verifyMobileNumber();
                                            },
                                            child: Text(
                                                "Resend Code",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Futura',
                                                    color: Color.fromRGBO(0, 153, 182, 50)
                                                )
                                            ),
                                        ),
                                    ),
                                ]
                            ),
                        ),

//                        Padding(
//                            padding: const EdgeInsets.only(bottom: 3.0),
//                            child: Text(
//                                "Didn't receive the OTP? Resend Code",
//                                style: TextStyle(
//                                    color: Colors.black,
//                                    fontSize: 14.0,
//                                    fontWeight: FontWeight.bold,
//                                    fontFamily: 'OpenSans',
//                                ),
//                            ),
//                        ),
                    ],
                )
                ,
            ),
        );
    }

    void inputTextToField(String str) {
        //Edit first textField
        if (currController == controller1) {
            controller1.text = str;
            setState(() {
                otpCode = str;
            });
            currController = controller2;
        }

        //Edit second textField
        else if (currController == controller2) {
            controller2.text = str;
            setState(() {
                otpCode+= str;
            });
            currController = controller3;
        }

        //Edit third textField
        else if (currController == controller3) {
            controller3.text = str;
            setState(() {
                otpCode+= str;
            });
            currController = controller4;
        }

        //Edit fourth textField
        else if (currController == controller4) {
            controller4.text = str;
            setState(() {
                otpCode+= str;
            });
            currController = controller5;
        }

        //Edit fifth textField
        else if (currController == controller5) {
            controller5.text = str;
            setState(() {
                otpCode +=str;
            });
            currController = controller6;
        }

        //Edit sixth textField
        else if (currController == controller6) {
            controller6.text = str;
            setState(() {
                otpCode=controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text;
            });
            currController = controller6;
            print(otpCode);
        }
    }

    void deleteText() {
        if (currController.text.length == 0) {

        }
        else {
            currController.text = "";
            currController = controller5;
            return;
        }

        if (currController == controller1) {
            controller1.text = "";
        }
        else if (currController == controller2) {
            controller1.text = "";
            currController = controller1;
        }
        else if (currController == controller3) {
            controller2.text = "";
            currController = controller2;
        }
        else if (currController == controller4) {
            controller3.text = "";
            currController = controller3;
        }
        else if (currController == controller5) {
            controller4.text = "";
            currController = controller4;
        }
        else if (currController == controller6) {
            controller5.text = "";
            currController = controller5;
        }
    }

    void _verifyMobileNumber() async {
//    var category_url = Url + '/api/categories';

        var url = '';
        final response = await http.post(Uri.parse(url),

            headers: <String, String>{

                'Content-Type': 'application/json; charset=UTF-8',
//        'Authorization': 'JWT ' + auth.user['token'],

            },

            body: jsonEncode(<String, String>{
                "mobile": mobile,

            }),

        );
        if (response.statusCode == 200) {
            print(response.body);

            Fluttertoast.showToast(
//          msg: e.toString(),
                msg: 'OTP code sent',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,

                //timeInSecForIosWeb: 1,
                timeInSecForIos: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushNamed(context, '/verify_otp', arguments:
            mobile
            );
        }

        else if (response.statusCode == 400) {
            print(response.body);

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


    }

    void matchOtp() async{


        var validateOTP = '';
        final response = await http.post(Uri.parse(validateOTP),

            headers: <String, String>{

                'Content-Type': 'application/json; charset=UTF-8',
//        'Authorization': 'JWT ' + auth.user['token'],

            },

            body: jsonEncode(<String, String>{
                "mobile": mobile.toString(),
                "otp": otpCode,

            }),

        );
        if (response.statusCode == 200) {
            print(response.body);
            Fluttertoast.showToast(
//          msg: e.toString(),
                msg: 'OTP matched, Proceed with registration',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,

                //timeInSecForIosWeb: 1,
                timeInSecForIos: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );

            Navigator.pushNamed(context, '/signup_mobile',
                arguments: mobile);
//      Navigator.pushNamed(context, '/verify_otp', arguments: {
//        'mobile' : ''
//      });
        }

        else if (response.statusCode == 400) {
            print(response.body);

            Fluttertoast.showToast(
//          msg: e.toString(),
                msg: response.body,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,

                //timeInSecForIosWeb: 1,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
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


    }
}