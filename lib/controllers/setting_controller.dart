import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingController extends GetxController {
  static final fonts = ['Noto Sans', 'Battambang', 'Kantumruy Pro'];
  final fontFamily = fonts.first.obs;

  TextTheme textTheme(TextTheme base) =>
      GoogleFonts.getTextTheme(fontFamily.value, base);

  void changeLanguage(String language) {
    Get.updateLocale(
      language == "km" ? Locale('km', 'KH') : Locale('en', 'US'),
    );
  }
}
