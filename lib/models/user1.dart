import 'package:shared_preferences/shared_preferences.dart';

class User {
  String username;
  String email;
  String password;
  String firstname;
  String lastname;
  bool isRegisterSuccess;
  User({this.username, this.email, this.password, this.firstname, this.lastname});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      firstname: json['firstname'],
      lastname : json['lastname'],

    );
  }
}

class UserCredential {
  String usernameOrEmail;
  String password;
  UserCredential({this.usernameOrEmail, this.password});
  static Future<String> loadSaveUserMobileNumber(mobile_no) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(mobile_no!=null) {
      prefs.setString('user_mobile_no', mobile_no);
    }
    else {
      return prefs.getString('user_mobile_no');
    }
    return mobile_no;
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
