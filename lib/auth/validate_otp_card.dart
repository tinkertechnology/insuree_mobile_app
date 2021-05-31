import 'package:flutter/material.dart';
import 'package:card_app/auth/otp_component/size_config.dart';

import 'package:card_app/auth/otp_component/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(),
    );
  }
}