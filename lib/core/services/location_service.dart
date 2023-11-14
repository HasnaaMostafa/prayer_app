import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  static Future<void> requestLocationPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    }
  }

  static Future<Placemark> getCurrentLocation() async {
    final Position currentLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print('Latitude: ${currentLocation.latitude}');
    print('Longitude: ${currentLocation.longitude}');

    return reverseGeocode(currentLocation.latitude, currentLocation.longitude);
  }

  static Future<Placemark> reverseGeocode(
      double latitude, double longitude) async {
    final List<Placemark> placeMarks = await placemarkFromCoordinates(
        latitude, longitude,
        localeIdentifier: "en_US");

    if (placeMarks != null && placeMarks.isNotEmpty) {
      final Placemark placemark = placeMarks[0];

      print(
          'Address: ${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}');
      return placemark;
    }
    return placeMarks[1];
  }
}
