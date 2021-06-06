# Insuree_APP

A new Flutter project.

Multipart file upload for graphql api
curl -X POST http://localhost:8000/api/graphql \
     -H 'content-type: multipart/form-data; boundary=----GraphQlFileUpload' \
     -F 'query=mutation {createVoucherPayment(file: "file"){   ok  }  }' \
     -F 'file=@selfie.jpg'



