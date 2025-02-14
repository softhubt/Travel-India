import 'package:get/get.dart';
import 'package:travelindia/Constant/storage_key_constant.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Dashboard_Section/dashboard_view.dart';
import 'package:travelindia/Views/Splash_Section/onboarding_view.dart';

class SplashController extends GetxController {
  RxBool isAuthenticate = false.obs;
  RxBool isGuest = false.obs;

  changeView() async {
    isAuthenticate.value = await StorageServices.getData(
            dataType: StorageKeyConstant.boolType,
            prefKey: StorageKeyConstant.isAuthenticate) ??
        false;

    isGuest.value = await StorageServices.getData(
            dataType: StorageKeyConstant.boolType,
            prefKey: StorageKeyConstant.isGuest) ??
        false;

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (isAuthenticate.value || isGuest.value) {
          Get.offAll(() => const DashboardView());
        } else {
          Get.offAll(() => const OnboardingView());
        }
      },
    );
  }
}
