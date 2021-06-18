class openimisGQLMutation {


  createFeedbackMutation(String fullname, String email, String mobile_no, String queries){
    return

          {"query":"mutation {\n  createFeedback(fullname: \"tero bau\", emailAddress: \"terobau@gmail.com\", mobileNumber:\"12121212\", queries: \"tero bau ho teo bau\")\n  {\n    feedback{\n      fullname\n      mobileNumber\n      emailAddress\n      queries\n    }\n  }\n}","variables":null};

  }
}