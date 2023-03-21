import 'package:geolocator/geolocator.dart';
import 'package:yandex_maps_exm/domain/app_lat_long.dart';
import 'package:yandex_maps_exm/domain/app_location.dart';

class LocationService implements AppLocation {
  final defLocation = const MoscowLocation();

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<AppLatLong> getCurrentLocation() {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError((_) => defLocation);
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
        value == LocationPermission.always ||
        value == LocationPermission.whileInUse
    ).catchError((_) => false);
  }
}