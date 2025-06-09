import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/app/page_1_nested/repository.dart';
import 'package:template/core/design/app_dimensions.dart';
import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/l10n/locale_cubit.dart';
import 'package:template/core/router/app_router.dart';

import 'mocks/mock_bloc.dart';
import 'mocks/mock_repository.dart';

extension PumpAppExtension on WidgetTester {
  Future<void> testAppWrapper({
    required AppRouter router,
    ThemeCubit? themeCubit,
    LocaleCubit? localeCubit,
    String? route,
    Map<String, dynamic>? extra,
  }) async {
    final mockThemeCubit = MockThemeCubit();
    final mockLocaleCubit = MockLocaleCubit();

    when(() => mockThemeCubit.state).thenReturn(ThemeMode.light);
    when(
      () => mockLocaleCubit.state,
    ).thenReturn(Locale(Locales.en.languageCode));

    Widget app = ScreenUtilInit(
      designSize: Size(AppDimensions.DESIGN_WIDTH, AppDimensions.DESIGN_HEIGHT),
      minTextAdapt: true,
      builder:
          (context, _) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'App',
            routerConfig: router.router,
          ),
    );

    await pumpWidget(app);
    await pumpAndSettle();

    if (route != null) {
      var context = router.router.routerDelegate.navigatorKey.currentContext;
      context?.go(route, extra: extra);
    }
    await pumpAndSettle();
  }
}

AppRouter buildMockRouter({Page1Repository? page1Repository}) {
  return AppRouter(
    builder: RoutesBuilder(),
    page1Repository: page1Repository ?? MockPage1Repository(),
  );
}
