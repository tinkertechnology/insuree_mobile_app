class openimisGQLMutation {


  createFeedbackMutation(fullname, email, mobile_no, queries){
    return
        {
          {"query":"mutation {\n  createFeedback(fullname: ${fullname}, emailAddress: ${email}, mobileNumber: ${mobile_no}, queries: ${queries})\n  {\n    feedback{\n      fullname\n    }\n  }\n}"}
        };
  }
}