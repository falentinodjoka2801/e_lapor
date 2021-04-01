import 'package:geolocator/geolocator.dart';

class Location {
  final double latitude;

  final double longitude;
  Location({this.latitude, this.longitude});
}

class LocationService {
  static Future<Location> detectCurrentLocation() async {
    Position _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return Location(
        latitude: _currentPosition.latitude,
        longitude: _currentPosition.longitude);
  }

  static Future<bool> isLocationServiceActive() async {
    bool _isActive = await Geolocator.isLocationServiceEnabled();
    return _isActive;
  }
}
