// To parse this JSON data, do
//
//     final feedback = feedbackFromJson(jsonString);

import 'dart:convert';

Feedback feedbackFromJson(String str) => Feedback.fromJson(json.decode(str));

String feedbackToJson(Feedback data) => json.encode(data.toJson());

class Feedback {
  Feedback({
    this.data,
  });

  Data data;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.createFeedback,
  });

  CreateFeedback createFeedback;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    createFeedback: CreateFeedback.fromJson(json["createFeedback"]),
  );

  Map<String, dynamic> toJson() => {
    "createFeedback": createFeedback.toJson(),
  };
}

class CreateFeedback {
  CreateFeedback({
    this.feedback,
  });

  FeedbackClass feedback;

  factory CreateFeedback.fromJson(Map<String, dynamic> json) => CreateFeedback(
    feedback: FeedbackClass.fromJson(json["feedback"]),
  );

  Map<String, dynamic> toJson() => {
    "feedback": feedback.toJson(),
  };
}

class FeedbackClass {
  FeedbackClass({
    this.fullname,
    this.mobileNumber,
    this.emailAddress,
    this.queries,
  });

  String fullname;
  String mobileNumber;
  String emailAddress;
  String queries;

  factory FeedbackClass.fromJson(Map<String, dynamic> json) => FeedbackClass(
    fullname: json["fullname"],
    mobileNumber: json["mobileNumber"],
    emailAddress: json["emailAddress"],
    queries: json["queries"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "mobileNumber": mobileNumber,
    "emailAddress": emailAddress,
    "queries": queries,
  };
}
