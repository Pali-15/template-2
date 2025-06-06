import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/common_widgets/base_screen.dart';
import 'package:template/core/design/spacing.dart';
import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/extensions/context_extensions/context_design_extension.dart';
import 'package:template/core/extensions/context_extensions/context_localization_extensions.dart';
import 'package:template/core/extensions/locals_extension.dart';
import 'package:template/core/l10n/locale_cubit.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Page 2',
      children: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder:
                  (context, themeMode) => Switch(
                    activeTrackColor: context.colors.switcherActive,
                    value: themeMode == ThemeMode.light,
                    onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                  ),
            ),
            SizedBox(height: AppSpacing.xs.value),
            Text(
              'Switch to ${Theme.of(context).brightness == Brightness.dark ? "Light" : "Dark"} Theme',
              style: context.textStyles.subtitle,
            ),
            BlocBuilder<LocaleCubit, Locale>(
              builder:
                  (context, locale) => Switch(
                    activeTrackColor: context.colors.switcherActive,
                    value: Locales.en.sameAs(locale),
                    onChanged:
                        (_) => context.read<LocaleCubit>().changeLocale(
                          Locales.en.sameAs(locale) ? Locales.hu : Locales.en,
                        ),
                  ),
            ),
            SizedBox(height: AppSpacing.xs.value),
            Text(
              'Switch to ${context.l10n.localeName == Locales.hu.languageCode ? "English" : "Hungarian"}',
              style: context.textStyles.subtitle,
            ),
            SizedBox(height: AppSpacing.xs.value),
            Text(
              "This is localized text: ${context.l10n.appTitle}",
              style: context.textStyles.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
