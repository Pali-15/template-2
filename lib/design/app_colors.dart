import 'package:flutter/material.dart';

class AppColors {
  final BuildContext context;

  AppColors(this.context);

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get navbarItem => Colors.blue;
  Color get switcherActive => Colors.green;
  Color get background =>
      MultiThemeColor(
        light: Color(0xFFFFFFFF),
        dark: Color(0xFF121212),
        context: context,
      ).color;
  Color get defaultTextColor =>
      MultiThemeColor(
        light: Colors.black,
        dark: Colors.white,
        context: context,
      ).color;
  Color get invertedTextColor =>
      MultiThemeColor(
        light: Colors.white,
        dark: Colors.black,
        context: context,
      ).color;
  Color get buttonColor =>
      MultiThemeColor(
        light: Color.fromARGB(255, 55, 55, 55),
        dark: Color.fromARGB(255, 200, 200, 200),
        context: context,
      ).color;
}

class MultiThemeColor {
  final Color light;
  final Color dark;
  final BuildContext context;

  const MultiThemeColor({
    required this.light,
    required this.dark,
    required this.context,
  });

  Color get color =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}
