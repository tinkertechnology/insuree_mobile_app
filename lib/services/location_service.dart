import 'dart:async';

import 'package:openimis_web_app/models/user_location.dart';
import 'package:location/location.dart';
class LocationService {
  UserLocation _currentLocation;
  var location = Location();
  bool _serviceEnabled;



  StreamController<UserLocation> _locationController =
  StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;



  LocationService() {
    // Request permission to use location
   
   
    location.requestPermission().then((granted) {
      if (granted== PermissionStatus.granted) {
//        location.enableBackgroundMode(enable: true);
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
      if (granted != PermissionStatus.granted)
      {
        return;
      }
      
    }
    
    );
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }

  Future<bool> checkService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

  }

}