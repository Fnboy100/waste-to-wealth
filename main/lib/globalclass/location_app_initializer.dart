import 'package:location/location.dart';

class LocationAppInitializer {
  final Location
      _location =
      Location();

  Future<bool>
      initializeApp() async {
    return await checkLocationPermissions();
  }

  Future<bool>
      checkLocationPermissions() async {
    bool
        serviceEnabled =
        await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }

    PermissionStatus
        permissionGranted =
        await _location.hasPermission();
    if (permissionGranted ==
        PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      return false;
    }
    return true;
  }

  Future<LocationData?>
      fetchUserLocation() async {
    try {
      final response = await checkLocationPermissions();
      if (response) {
        _location.changeSettings(accuracy: LocationAccuracy.high);
        final currentLocation = await _location.getLocation();
        return currentLocation;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
