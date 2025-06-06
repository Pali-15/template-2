import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:template/design/theme/theme_cubit.dart';
import 'package:template/l10n/locale_cubit.dart';

import 'mocks/bloc_mocks.mocks.dart';
import 'mocks/router_mocks.mocks.dart';
import 'utils/bloc_test_utils.dart';

extension PumpAppExtension on WidgetTester {
  Future<void> pumpAppScreen(
    Widget child, {
    ThemeCubit? themeCubit,
    LocaleCubit? localeCubit,
    GoRouter? router,
  }) async {
    final mockThemeCubit = MockThemeCubit();
    final mockLocaleCubit = MockLocaleCubit();

    mockitoWhenListen(mockThemeCubit, initState: ThemeData.light());
    mockitoWhenListen(
      mockLocaleCubit,
      initState: Locale(Locales.en.languageCode),
    );

    await pumpWidget(
      InheritedGoRouter(
        goRouter: router ?? MockGoRouter(),
        child: MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeCubit>.value(
                value: themeCubit ?? mockThemeCubit,
              ),
              BlocProvider<LocaleCubit>.value(
                value: localeCubit ?? mockLocaleCubit,
              ),
            ],
            child: child,
          ),
        ),
      ),
    );
  }
}
