import 'package:flutter/material.dart';
import 'package:template/core/extensions/context_extensions/context_design_extension.dart';

class AppTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color color;

  const AppTextButton._({
    required this.label,
    this.onPressed,
    required this.color,
  });

  factory AppTextButton.transparent({
    Key? key,
    required String label,
    void Function()? onPressed,
  }) {
    return AppTextButton._(
      label: label,
      onPressed: onPressed,
      color: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 1),
      ),
      onPressed: onPressed,
      child: Text(label, style: context.textStyles.subtitle),
    );
  }
}

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color backgroundColor;

  const AppElevatedButton._({
    required this.label,
    this.onPressed,
    required this.backgroundColor,
  });

  factory AppElevatedButton.primary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    required BuildContext context,
  }) {
    return AppElevatedButton._(
      label: label,
      onPressed: onPressed,
      backgroundColor: context.colors.buttonColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: context.textStyles.subtitle.copyWith(
          color: context.colors.invertedTextColor,
        ),
      ),
    );
  }
}
