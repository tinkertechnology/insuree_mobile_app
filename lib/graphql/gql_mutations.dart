class openimisGQLMutation {
  createFeedbackMutation(String fullname, String email, String mobile_no, String queries){
    return

          {"query":"mutation {\n  createFeedback(fullname: \"${fullname}\", emailAddress: \"${email}\", mobileNumber:\"${mobile_no}\", queries: \"${queries}\")\n  {\n    feedback{\n      fullname\n      mobileNumber\n      emailAddress\n      queries\n    }\n  }\n}","variables":null};

  }
}