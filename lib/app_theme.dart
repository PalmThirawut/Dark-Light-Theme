import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switch_theme/constant/constant.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeProvider({required this.isLightTheme});

  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColor.navColor,
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  toggleThemeData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (isLightTheme) {
      sharedPreferences.setBool(SPref.isLight, false);
      isLightTheme = !isLightTheme;
      notifyListeners();
    } else {
      sharedPreferences.setBool(SPref.isLight, true);
      isLightTheme = !isLightTheme;
      notifyListeners();
    }
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  ThemeData themeData() {
    return ThemeData(
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      scaffoldBackgroundColor: isLightTheme ? AppColor.yellow : AppColor.black,
      textTheme: TextTheme(
        headline1: GoogleFonts.stickNoBills(
            fontSize: 70,
            fontWeight: FontWeight.w600,
            color: isLightTheme ? AppColor.black : AppColor.orange),
        headline2: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.w500,
            color: isLightTheme ? AppColor.black : AppColor.orange),
      ),
    );
  }

  ThemeMode themeMode() {
    return ThemeMode(
      gredientColor: isLightTheme
          ? [AppColor.yellow, AppColor.yellowDark]
          : [AppColor.black, AppColor.black],
      switchColor: isLightTheme ? AppColor.black : AppColor.orange,
      thumColor: isLightTheme ? AppColor.orange : AppColor.black,
      switchBgColor: isLightTheme
          ? AppColor.black.withOpacity(.1)
          : AppColor.grey.withOpacity(.3),
    );
  }
}

class ThemeMode {
  List<Color>? gredientColor;
  Color? switchColor;
  Color? thumColor;
  Color? switchBgColor;

  ThemeMode(
      {this.gredientColor,
      this.switchColor,
      this.thumColor,
      this.switchBgColor});
}
