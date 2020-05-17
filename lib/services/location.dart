import 'package:geolocator/geolocator.dart';

class Location {

  double latitude;
  double longitude;
  Position position;

  Future<Position> getCurrentLocation() async {

    try {
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      latitude = position.latitude;
      longitude = position.longitude;

    } catch (e) {
      print(e);
    }

    return position;
  }

}

