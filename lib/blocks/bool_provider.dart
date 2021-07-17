import 'package:flutter/cupertino.dart';

class LoadingProvider with ChangeNotifier {

  bool loading = false; //loading the page


  bool isLoading() {
    return loading; //return true if the app is loading the data
  }

  void setLoading(value) {
    loading = value;
    notifyListeners(); //This method is called when the objects is changed
  }
}


