import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/design/app_colors.dart';

class AppTextStyles {
  final BuildContext context;

  AppTextStyles(this.context);

  AppColors get _colors => AppColors(context);

  TextStyle get headline => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: _colors.defaultTextColor,
  );

  TextStyle get subtitle => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: _colors.defaultTextColor,
  );

  TextStyle get body => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: _colors.defaultTextColor,
  );
}
