import 'dart:convert';
import 'dart:io';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:card_app/pages/card.dart';
import 'package:card_app/common/env.dart' as env;

class SubmissionPage extends StatefulWidget {
  @override
  _SubmissionPageState createState() => _SubmissionPageState();

}

class _SubmissionPageState extends State<SubmissionPage> {
  File _image;
  String message;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    bool isLoading = false;

  _imgFromCamera() async {
    // File image = (await _picker.getImage(source: ImageSource.camera, imageQuality: 50)) as File;  // await ImagePicker.getImage(
    //source: ImageSource.camera, imageQuality: 50
    //);
    PickedFile image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadPic() async{
    setState(() {
      isLoading = !isLoading;
    });
    String url = env.API_BASE_URL;
    var request = new http.MultipartRequest("POST", Uri.parse(url));
//		request.headers.addAll(headers);
    request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(Uri.parse(_image.path)).readAsBytes(), filename: "jpt.jpg"));
//		request.fields['address'] = 'address';
//		request.fields['query'] ='mutation {createVoucherPayment(file: ${Uri.parse(_image.path)}){   ok  }  }","variables":null"}';
    request.fields['query'] ='mutation {createVoucherPayment(file: "file"){   ok  }  }';
    print(request);
    request.send().then((response) {
      print(response.stream.bytesToString().toString());
      if (response.statusCode == 200) {
        if (response.reasonPhrase == "OK") {
          RedirectToCardPage('Uplaad Bhayo la bhai haru');
        }
        else{
          RedirectToCardPage('Server Error cha hai bhai haru');
        }
        setState(() {
          isLoading = !isLoading;
          //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
        });
      }
    });

  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void RedirectToCardPage(String value) {

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => ShowCard(message: value)),
              (route) => false);
  }
  void showMessage(String val){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(val), duration: Duration(milliseconds: 3000), ), );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41,127,141, 25), //mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Submit your Paid Voucher'),
        backgroundColor: Color.fromRGBO(41,127,141, 0), //mainColor,
      ),
      body:
      Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 200,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 400,
                    height: 400,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10.0
          ),
          isLoading ? Center(child: CircularProgressIndicator()):Center(
            child:
            Container(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                 _image!=null ? uploadPic(): showMessage('Please Select Image of your Paid Voucher ');
                  },
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)),
                ),
                color: CustomTheme.lightTheme.primaryColor,
                //Color.fromRGBO(41,127,141, 100),
                child: Text(
                  "Submit".toUpperCase(),
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open-sans",
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

}




