import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:card_app/common/env.dart' as env;

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();

}

class _ProfileInfoState extends State<ProfileInfo> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
  }

  _imgFromCamera() async {
    // File image = (await _picker.getImage(source: ImageSource.camera, imageQuality: 50)) as File;  // await ImagePicker.getImage(
    //source: ImageSource.camera, imageQuality: 50
    //);
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadPic() async{
    //  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    //  StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    //  StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    Map<String, String> headers = { "Authorization": "JWT "+ env.getAuthToken(null)};
    String url = env.API_BASE_URL+ '/api/profile/';
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(Uri.parse(_image.path)).readAsBytes(), contentType: new MediaType('image', 'jpeg')));
    request.fields['address'] = 'address';
    print(request);
    request.send().then((response) {
      if (response.statusCode == 200)
        print("Uploaded!");
      setState(() {
        print("Profile Picture uploaded");
        //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 100,
                    height: 100,
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
          Container(
            height: 200.0,
          child:  Form(
          key: _formKey,
          child: new ListView(
          children: getFormWidget(),
    )),
          ),
        ],
      ),

    );
  }
  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name';
        }
      },
      onSaved: (value) {
        setState(() {
          //_name = value;
        });
      },
    ));

    formWidget.add(new TextFormField(
      decoration: InputDecoration(labelText: 'Enter Address', hintText: 'Address'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a Address';
        }
      },
      onSaved: (value) {
        setState(() {
          //_name = value;
        });
      },
    ));

  formWidget.add(
    FlatButton(
      onPressed: () async {

        await uploadPic();
        /*Navigator.pushNamed(context, '/verify_mobile');*/
      },
      child: Text(
        'Upload',
        style: TextStyle(
            fontFamily: 'Futura',
            fontWeight: FontWeight.bold,
            color: Colors.yellow
        ),
      ),
    ),
  );
    return formWidget;
  }
}




