import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

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

  final double value;

  /// Overwrites the default padding values. Useful when a Widget expects an
  /// RsgSpacing instance, but we need custom padding values.
  final EdgeInsetsGeometry? _customInsets;

  const AppSpacing(this.value) : _customInsets = null;

  AppSpacing.only({
    AppSpacing? top,
    AppSpacing? bottom,
    AppSpacing? start,
    AppSpacing? end,

    /// The value for those insets which are not explicitly given.
    AppSpacing? rest,
  }) : this.custom(
         EdgeInsetsDirectional.only(
           top: top?.value ?? rest?.value ?? 0.0,
           bottom: bottom?.value ?? rest?.value ?? 0.0,
           start: start?.value ?? rest?.value ?? 0.0,
           end: end?.value ?? rest?.value ?? 0.0,
         ),
       );

  AppSpacing.symmetric({AppSpacing? horizontal, AppSpacing? vertical})
    : this.custom(
        EdgeInsets.symmetric(
          horizontal: horizontal?.value ?? 0.0,
          vertical: vertical?.value ?? 0.0,
        ),
      );

  @visibleForTesting
  const AppSpacing.custom(EdgeInsetsGeometry customInsets)
    : value = 0,
      _customInsets = customInsets;

  AppSpacing get withHorizontalOnly => AppSpacing.custom(insetsHorizontal);

  AppSpacing get withVerticalOnly => AppSpacing.custom(insetsVertical);

  AppSpacing get withTopOnly => AppSpacing.custom(insetsTop);

  AppSpacing get withBottomOnly => AppSpacing.custom(insetsBottom);

  AppSpacing get withStartOnly => AppSpacing.custom(insetsStart);

  AppSpacing get withEndOnly => AppSpacing.custom(insetsEnd);

  EdgeInsetsGeometry get insetsAll =>
      _customInsets ?? (this == zero ? EdgeInsets.zero : EdgeInsets.all(value));

  EdgeInsetsGeometry get insetsHorizontal =>
      EdgeInsets.symmetric(horizontal: _customInsets?.horizontal ?? value);

  EdgeInsetsGeometry get insetsVertical =>
      EdgeInsets.symmetric(vertical: _customInsets?.vertical ?? value);

  EdgeInsetsGeometry get insetsTop => switch (_customInsets) {
    EdgeInsets(:final top) ||
    EdgeInsetsDirectional(:final top) => EdgeInsets.only(top: top),
    _ => this == zero ? EdgeInsets.zero : EdgeInsets.only(top: value),
  };

  EdgeInsetsGeometry get insetsBottom => switch (_customInsets) {
    EdgeInsets(:final bottom) ||
    EdgeInsetsDirectional(:final bottom) => EdgeInsets.only(bottom: bottom),
    _ => this == zero ? EdgeInsets.zero : EdgeInsets.only(bottom: value),
  };

  EdgeInsetsGeometry get insetsStart => switch (_customInsets) {
    EdgeInsets(left: final start) || EdgeInsetsDirectional(:final start) =>
      EdgeInsetsDirectional.only(start: start),
    _ =>
      this == zero ? EdgeInsets.zero : EdgeInsetsDirectional.only(start: value),
  };

  EdgeInsetsGeometry get insetsEnd => switch (_customInsets) {
    EdgeInsets(right: final end) ||
    EdgeInsetsDirectional(:final end) => EdgeInsetsDirectional.only(end: end),
    _ =>
      this == zero ? EdgeInsets.zero : EdgeInsetsDirectional.only(end: value),
  };

  Widget padAll(Widget child) => Padding(padding: insetsAll, child: child);

  Widget padTop(Widget child) => Padding(padding: insetsTop, child: child);

  Widget padBottom(Widget child) =>
      Padding(padding: insetsBottom, child: child);

  Widget padStart(Widget child) => Padding(padding: insetsStart, child: child);

  Widget padEnd(Widget child) => Padding(padding: insetsEnd, child: child);

  Widget padHorizontal(Widget child) =>
      Padding(padding: insetsHorizontal, child: child);

  Widget padVertical(Widget child) =>
      Padding(padding: insetsVertical, child: child);

  // coverage:ignore-start
  @override
  List<Object?> get props => [value, _customInsets];

  @override
  String toString() => 'RsgSpacing(${_customInsets ?? value})';
  // coverage:ignore-end
}
