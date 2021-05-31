// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart';
// import 'dart:typed_data';
// import 'dart:async';
// import 'package:http_parser/http_parser.dart';
// import 'package:http/http.dart' as http;
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:flutter_scaffold/common/env.dart' as env;

// void main() => runApp(new ImageHelper());

// class ImageHelper extends StatefulWidget {
//   @override
//   _ImageHelperState createState() => new _ImageHelperState();
// }

// class _ImageHelperState extends State<ImageHelper> {
//   List<Asset> images = List<Asset>();
// //  String _error = 'No Error Dectected';
//   String doctor_name="";
//   bool isWidgetLoaded = false;
//   String hospital_name="";
//   bool isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   }

//   Future<void> loadAssets() async {
//     List<Asset> resultList = List<Asset>();
//     String error = '';

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 300,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Upload Photo",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       images = resultList;
// //      _error = error;
//     });
//   }

//   void uploadPrescription() async {
//     setState(() {
//       isLoading = true;
//     });

//     // string to uri
//     Uri uri = Uri.parse(env.API_BASE_URL +'/api/file_upload/');

// // create multipart request
//     MultipartRequest request = http.MultipartRequest("POST", uri,


//     );
//     var h= {

// //        'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'JWT ' + env.getAuthToken(null)//auth.user['token'],

//     };
//     request.headers.addAll(
//      h
//     );
//     ByteData byteData = await images[0].getByteData();
//     List<int> imageData = byteData.buffer.asUint8List();

//     MultipartFile multipartFile = MultipartFile.fromBytes(
//       'file',
//       imageData,
//       filename: 'some-file-name.jpg',
//       contentType: new MediaType("image", "jpg"),
//     );

// // add file to multipart
//     request.files.add(multipartFile);
// // send
//     var fields = {'doctor_name': doctor_name, 'hospital_name': hospital_name};
//     request.fields.addAll(fields);
//     var response = await request.send();
//     if(response.statusCode==200){
//       setState(() {
//         isLoading=false;
//       });

//       Fluttertoast.showToast(
// //          msg: e.toString(),
//           msg: 'Prescription Uploaded.',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,

//           //timeInSecForIosWeb: 1,
//           timeInSecForIos: 1,
//           backgroundColor: Colors.grey,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//     }
//     else {
//       Fluttertoast.showToast(
// //          msg: e.toString(),
//           msg: 'Uploaded Error.',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,

//           //timeInSecForIosWeb: 1,
//           timeInSecForIos: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//     }

//   }
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('Upload Your Prescription'),
//         ),
//         body: isLoading ? Container(
//            child: Center(
//              child: CircularProgressIndicator(),
//            )
//         ): Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12.0),
//               child: TextFormField(

//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Enter Doctor Name ';
//                   }
//                   return null;
//                 },
//                 onChanged: (text){
//                   doctor_name=text;

//                 },
// //                      onSaved: (value) {
// //                        setState(() {
// //                          street = value;
// //
// //                        });
// //                      },
//                 decoration: InputDecoration(
//                   hintText: 'Optional',
//                   labelText: 'Doctor Name',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12.0),
//               child: TextFormField(

//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Enter hospital name';
//                   }
//                   return null;
//                 },
//                 onChanged: (text){
//                   hospital_name=text;

//                 },
// //                      onSaved: (value) {
// //                        setState(() {
// //                          street = value;
// //
// //                        });
// //                      },
//                 decoration: InputDecoration(
//                   hintText: 'Optional',
//                   labelText: 'hospital name',
//                 ),
//               ),
//             ),
// //            Center(child: Text('Error: $_error')),
//             RaisedButton(
//               child: Text("Pick image"),
//               onPressed: loadAssets,
//             ),
//             RaisedButton(
//               child: Text('upload subscriptions'),
//               onPressed:  uploadPrescription,
//             ),
//             Expanded(
//               child: buildGridView(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }