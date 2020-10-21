

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationHelper{
  Location location = new Location();
  PermissionStatus _permissionGranted;
  bool _serviceEnabled;
  double latitude=8.353080823162513;  // agregue unas por defecto
  double longitude=-62.616415163327815;

  static final LocationHelper _singleton = LocationHelper._internal();

  factory LocationHelper() {
    return _singleton;
  }

  LocationHelper._internal();

  Future<bool> locationGranted() async  {
    //print("_permissionStatusCamera:$_permissionStatusCamera");

    if(_permissionGranted == null)
      _permissionGranted = await location.hasPermission();

    return _permissionGranted == PermissionStatus.GRANTED;
  }

  Future<bool> serviceEnable() async {
    //print("_permissionStatusCamera:$_permissionStatusCamera");
    if(_serviceEnabled==null)
      _serviceEnabled = await location.serviceEnabled();

    return _serviceEnabled;
  }

  Future<void> requestPermission() async {
    _permissionGranted = await location.hasPermission();


    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        print('permiso denegado');
      }
    }
  }

  Future<void> requestServicioEnable() async {

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('servicio de geolocalizacion no esta habilitado');
      }
    }
  }

  initService(){
    location.onLocationChanged().listen((LocationData currentLocation) {
      //print("latitud: ${currentLocation.latitude}");
      //print("longitud: ${currentLocation.longitude}");
      latitude= currentLocation.latitude;
      longitude= currentLocation.longitude;

      /*Fluttertoast.showToast(
          msg: "Location: ${currentLocation.latitude},  ${currentLocation.longitude} Distancia: ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );*/


    });

  }

  Future<String> distance(String endLat, String endLog) async{ /** devuelve el calculo en Km **/
    //double endLat = -33.408041, double endLog = -70.572656
    if(endLat==null ||  endLat.isEmpty)
      return "0";

    if(endLog==null ||  endLog.isEmpty)
      return "0";

    if(latitude==0 || longitude==0)
      return '0';

    double distanceInMeters = await Geolocator().distanceBetween(latitude, longitude, double.parse(endLat), double.parse(endLog));

    return (distanceInMeters/1000).round().toString();
  }

}