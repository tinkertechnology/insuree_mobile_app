

class Feedback {
  String fullname;
  String email_address;
  String mobile_number;
  String queries;

  Feedback({this.fullname, this.email_address, this.mobile_number, this.queries});
  factory Feedback.fromJson(Map<String, String> json) {
    return Feedback(
      fullname: json['chfid'],
      email_address: json['email_address'],
      mobile_number: json['mobile_number'],
      queries: json['queries'],
    );
  }
}