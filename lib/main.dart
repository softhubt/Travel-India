import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelindia/Constant/color_constant.dart';
import 'package:travelindia/Services/local_storage_services.dart';
import 'package:travelindia/Views/Splash_Section/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageServices.initializeSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primary),
            useMaterial3: true),
        home: const SplashView());
  }
}
