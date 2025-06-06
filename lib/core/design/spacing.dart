import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing extends Equatable {
  static const zero = AppSpacing(0);
  static const sHalf = AppSpacing(4);
  static const s1 = AppSpacing(8);
  static const s2 = AppSpacing(12);
  static const s3 = AppSpacing(16);
  static const s4 = AppSpacing(20);
  static const s5 = AppSpacing(24);
  static const s6 = AppSpacing(28);
  static const s7 = AppSpacing(32);
  static const s8 = AppSpacing(36);
  static const s9 = AppSpacing(40);
  static const s10 = AppSpacing(44);
  static const s11 = AppSpacing(48);
  static const s12 = AppSpacing(56);
  static const s13 = AppSpacing(64);
  static const s14 = AppSpacing(80);

  static const xs = sHalf;
  static const s = s1;
  static const m = s2;
  static const l = s3;
  static const xl = s5;
  static const xxl = s7;
  static const xxxl = s9;

  final double _value;
  double get height => _value.h;
  double get width => _value.w;

  const AppSpacing(this._value);

  EdgeInsets get insetsAll =>
      EdgeInsets.symmetric(horizontal: width, vertical: height);

  @override
  List<Object?> get props => [_value];
}
