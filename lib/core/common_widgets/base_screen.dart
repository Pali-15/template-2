import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/core/design/app_dimensions.dart';
import 'package:template/core/design/spacing.dart';
import 'package:template/core/extensions/context_extensions/context_design_extension.dart';

class BasePage extends StatelessWidget {
  final Widget children;
  final String? title;
  final bool enableBackButton;
  final EdgeInsets? padding;
  const BasePage({
    super.key,
    required this.children,
    this.title,
    this.enableBackButton = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width =
            AppDimensions.MAX_SCREEN_WIDTH
                .clamp(0.0, constraints.maxWidth)
                .toDouble();
        return Container(
          color: context.colors.background,
          child: Center(
            child: SizedBox(
              width: width,
              child: Scaffold(
                backgroundColor: context.colors.background,
                appBar:
                    (!enableBackButton && title == null)
                        ? null
                        : AppBar(
                          backgroundColor: context.colors.background,
                          elevation: 0,
                          title:
                              title == null
                                  ? null
                                  : Text(
                                    title!,
                                    style: context.textStyles.headline,
                                  ),
                          leading:
                              enableBackButton
                                  ? IconButton(
                                    onPressed: () => context.pop(),
                                    icon: const Icon(Icons.arrow_back),
                                  )
                                  : null,
                        ),
                body: SafeArea(
                  child: Padding(
                    padding: padding ?? AppSpacing.m.insetsAll,
                    child: children,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
