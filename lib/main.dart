import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: 'Travel India',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const SplashView());
  }

  ThemeData buildAppTheme() {
    return ThemeData(
        // Set Material 3 for the latest design
        useMaterial3: true,

        // Define the color scheme with your primary color
        colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstant.primary,
            primary: ColorConstant.primary,
            secondary: ColorConstant.goldenrodYellow,
            background: ColorConstant.white,
            onPrimary: ColorConstant.white,
            onBackground: ColorConstant.black),

        // Set the default font to Poppins
        textTheme: GoogleFonts.poppinsTextTheme(),

        // Customize AppBar theme
        appBarTheme: const AppBarTheme(
            backgroundColor: ColorConstant.primary,
            foregroundColor: ColorConstant.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorConstant.black)),

        // Customize Bottom Navigation Bar theme
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: ColorConstant.white,
            selectedItemColor: ColorConstant.primary,
            unselectedItemColor: ColorConstant.grey,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),

        // Customize Elevated Button style
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primary,
                foregroundColor: ColorConstant.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600))),

        // Customize Input Decoration for text fields
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ColorConstant.cloudWhite,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: ColorConstant.softSilverGrey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: ColorConstant.primary)),
            hintStyle:
                const TextStyle(fontSize: 14, color: ColorConstant.grey)));
  }
}

// About Site, Things to do, Food/Drinks, Hotels&Homes, Transpot, Hire Guides

//BottomBar Categories: explore, likes, ticket, profile

// Show the finded list location in dashboard first(the location list will be based on user's current city)
// Show the category list under this finded location list
// Show the package list under the category list
// Make sure to add rate location module in each and every location
//
