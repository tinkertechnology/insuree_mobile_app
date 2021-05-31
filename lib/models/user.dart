import 'package:shared_preferences/shared_preferences.dart';

class UserCredential {
  String chfid;
  String fhchfid;
  String dob;
  String otp;
//  String firstname;
//  String lastname;
  bool isRegisterSuccess;
  UserCredential({this.chfid, this.fhchfid, this.dob, this.otp});
  factory UserCredential.fromJson(Map<String, dynamic> json) {
    return UserCredential(
      chfid: json['chfid'],
      fhchfid: json['fhchfid'],
      dob: json['dob'],
      otp: json['otp'],
    );
  }
}

class UserRegister {
  String password;
  String firstname;
  String lastname;
  String mobile;
  String email;

  UserRegister({this.password, this.firstname, this.lastname, this.mobile, this.email});

}

class ValidateOtp {
  String otpCode;
  String mobile;

  ValidateOtp(this.otpCode, this.mobile);
}
