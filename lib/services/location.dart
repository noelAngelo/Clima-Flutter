import 'package:geolocator/geolocator.dart';

class Location {

  double latitude;
  double longitude;
  Position position;

  Future<Position> getCurrentLocation() async {

    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
          .timeout(const Duration(seconds: 5));

    } catch (e) {
      position = Position(latitude: 0, longitude: 0);
    }

    latitude = position.latitude;
    longitude = position.longitude;

    return position;
  }

}

