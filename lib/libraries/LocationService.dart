import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Map<String, double>> detectCurrentLocation() async {
    try {
      Position _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      double _latitude = _currentPosition.latitude;
      double _longitude = _currentPosition.longitude;

      return {'latitude': _latitude, 'longitude': _longitude};
    } catch (e) {
      return null;
    }
  }
}
