import 'dart:io';
import 'package:card_app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:card_app/pages/card_details.dart';
import 'package:card_app/common/env.dart' as env;
import 'package:card_app/langlang/app_translation.dart';
import 'package:card_app/langlang/application.dart';

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
        application.onLocaleChanged = onLocaleChange;
    }
    
    void onLocaleChange(Locale locale) async {
        setState(() {
            AppTranslations.load(locale);
        });
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
            MaterialPageRoute(builder: (c) => CardDetailPage(message: value)),
                (route) => false);
    }
    
    void showMessage(String val){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(val), duration: Duration(milliseconds: 3000),),);
    }
    
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: CustomTheme.lightTheme.primaryColor,
            appBar: AppBar(
                elevation: 0.0,
                title: Text(AppTranslations.of(context).text('page_payment_submission'),),
                backgroundColor: CustomTheme.lightTheme.primaryColor,
            ),
            body: Column(
                children: <Widget>[
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: CustomTheme.lightTheme.backgroundColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)
                                ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ListView(
                                    children: [
                                        SizedBox(height: 8.0),
                                        Text(
                                            'Upload image of your paid voucher',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w300
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
    
                                        Container(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                                children: [
                                                    _image != null ?
                                                        _imageCardWidget()
                                                        : _addImageCardWidget()
                                                ],
                                            )
                                        ),
    
                                        isLoading ?
                                        Center(
                                            child: CircularProgressIndicator()
                                        )
                                        :Center(
                                            child: _uploadImageValidationWidget(),
                                        ),
                                    ],
                                )
                            )
                        )
                    ),
                ],
            ),
        );
    }
    
    Widget _imageCardWidget(){
        return GestureDetector(
            onTap: (){
                _showPicker(context);
            },
            child: Card(
                child: Image.file(
                    _image,
                    fit: BoxFit.fill,
                ),
            ),
        );
    }
    
    Widget _addImageCardWidget(){
        return GestureDetector(
            onTap: (){
                _showPicker(context);
            },
            child: Card(
                elevation: 3.0,
                child: Container(
                    height: 120,
                    width: 120,
                    child: Center(
                        child: Icon(Icons.note_add, size: 30, color: Colors.grey.withOpacity(0.5),),
                    )
                ),
            ),
        );
    }
    
    Widget _uploadImageValidationWidget(){
        return Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            width: double.infinity,
            child: RaisedButton(
                onPressed: () async {
                    _image!=null ? uploadPic(): showMessage('Please upload image of your Paid Voucher ');
                },
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)),
                ),
                color: CustomTheme.lightTheme.primaryColor,
                child: Text(
                    AppTranslations.of(context).text('submit').toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Open-sans",
                        color: Colors.white
                    ),
                ),
            ),
        );
    }
}




