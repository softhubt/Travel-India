import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxString currentAddress = "".obs;

  Future initialFunctioun() async {
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        log("----------------------------------------------------------------------------------------------------");
        log("Name ::: ${place.name}");
        log("Administrative area ::: ${place.administrativeArea}");
        log("Country ::: ${place.country}");
        log("Iso country code ::: ${place.isoCountryCode}");
        log("Locality ::: ${place.locality}");
        log("Postal code ::: ${place.postalCode}");
        log("Street ::: ${place.street}");
        log("SubAdministrative Area ::: ${place.subAdministrativeArea}");
        log("SubLocality ::: ${place.subLocality}");
        log("SubThoroughfare ::: ${place.subThoroughfare}");
        log("Thoroughfare ::: ${place.thoroughfare}");
        log("----------------------------------------------------------------------------------------------------");
        currentAddress.value =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.isoCountryCode}";
      } else {
        log("No place mark available");
      }
    } catch (error) {
      log("Something went wrong during getting current location ::: $error");
    }
  }
}
