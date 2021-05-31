
// import 'dart:async';
// import 'package:geolocator/geolocator.dart';
// Position currentLocationPosition;
// ////String _currentAddress;
// //Future <Position> getCurrentLocation() async{
// //  Position _currentPosition;
// //  _currentPosition = geolocator
// //      .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
// //      .then((Position position) {
// ////    setState(() {
// ////      _currentPosition = position;
// ////      if(_currentPosition!=null) {
// ////        order_latitude = _currentPosition.latitude.toString();
// ////        order_longitude = _currentPosition.longitude.toString();
// ////        print(order_latitude);
// ////        print(order_longitude);
// ////        obtainStores();
// ////      }
// ////    });
// //    _currentPosition = position;
// //    return _currentPosition;
// //
// //    //_getAddressFromLatLng();
// //  }).catchError((e) {
// //    print(e);
// //  }) as Position;
// //  return _currentPosition;
// //}
// //
// //Future<String> getCurrentPositionUrlQuery() async{
// //  Future<Position> position = getCurrentLocation();
// //  var query;
// //  await position.then((Position position){
// //      if(position!=null) {
// //        query = "latitude=" + position.latitude.toString() +
// //            "&longitude=" + position.longitude.toString();
// //      }
// //  });
// //  return query;
// //
// //}
// //
// //String getLocationQuery(Position position) {
// //  var query="";
// //  if(position!=null) {
// //     query = "latitude=" + position.latitude.toString() +
// //        "&longitude=" + position.longitude.toString();
// //  }
// //  return query;
// //}

// String getLocationLatitudeStr(){
//   var str= "";
//   if(currentLocationPosition!=null){
//     str = currentLocationPosition.latitude.toString();
//   }
//   return str;
// }

// String getLocationLongitudeStr(){
//   var str= "";
//   if(currentLocationPosition!=null){
//     str = currentLocationPosition.longitude.toString();
//   }
//   return str;
// }

// class EnvLocationService {
//   Position position;
//   Position lastKnownPosition;
//   var result = '';
//   Future<String> lastKnownLocationAsync() async{

//     Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
//     lastKnownPosition = await geolocator.getLastKnownPosition(desiredAccuracy: LocationAccuracy.low);
//     print('last known '+lastKnownPosition.toString());
//     result = lastKnownPosition.toString();
//     return result;
//   }

//   Position currentPosition;
//   Future<String> currentLocationAsync() async{
//     Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
//     currentPosition = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//     print('current position = '+ currentPosition.toString()) ;
//     result = currentPosition.toString();
//     return result;
//   }
//   Position onChangedLocationPosition;
//   Future<String> onChangedLocation() async {
//     var geolocator = Geolocator();
//     var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
//     StreamSubscription<Position> positionStream = geolocator.getPositionStream(
//         locationOptions).listen(
//             (Position cPosition) {
//               if(cPosition!=null){
//                 position = cPosition;
//               }
//               onChangedLocationPosition = cPosition;
//               currentLocationPosition = cPosition;
//           print(cPosition == null ? 'Unknown' : 'onchanged location: '+cPosition.latitude.toString() +
//               ', ' + cPosition.longitude.toString());
//         });
//   }

//   getLocationAsync() async {
//     onChangedLocation();
//     Timer.periodic(Duration(milliseconds: 200), (timer) {
//       print(DateTime.now());
//       print('envlocationService');
//       if (position == null) {
//         if(onChangedLocationPosition!=null){
//           position = onChangedLocationPosition;
//           currentLocationPosition = position;
//           timer.cancel();
//           return;
//         }
//         lastKnownLocationAsync();
//         currentLocationAsync();
//         if (lastKnownPosition != null) {
//           position = lastKnownPosition;
//           currentLocationPosition = position;
//           timer.cancel();
//           return;
//         }
//         if (currentPosition != null) {
//           position = currentPosition;
//           currentLocationPosition = position;
//           timer.cancel();
//           return;
//         }
// //            _getCurrentLocation();
//       }
//       else {
//         currentLocationPosition = position;
//         timer.cancel();
//         return;
//       }
//     });
//   }




// }