// import 'package:flutter/material.dart';

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late final AppRouter router;
//   @override
//   void initState() {
//     super.initState();
//     router = AppRouter();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ThemeCubit()),
//         BlocProvider(
//           create: (context) => LocaleCubit(Locale(Locales.en.languageCode)),
//         ),
//       ],
// child: Builder(
//   builder: (context) {
//     // Rebuild when one of them change states
//     final themeMode = context.watch<ThemeCubit>().state;
//     final locale = context.watch<LocaleCubit>().state;

//     return MaterialApp.router(
//       locale: locale,
//       supportedLocales: context.read<LocaleCubit>().supportedLocales,
//       localizationsDelegates: AppI18N.localizationsDelegates,
//       debugShowCheckedModeBanner: false,
//       title: 'App',
//       routerConfig: router.router,
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       themeMode: themeMode,
//     );
//   },
// ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/design/app_dimensions.dart';
import 'package:template/core/design/theme/theme.dart';
import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/l10n/app_localizations.dart';
import 'package:template/core/l10n/locale_cubit.dart';
import 'package:template/core/router/app_router.dart';

class TemplateApp extends HookWidget {
  final AppRouter router;
  const TemplateApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      designSize: const Size(
        AppDimensions.DESIGN_WIDTH,
        AppDimensions.DESIGN_HEIGHT,
      ),
      minTextAdapt: true,
      child: Builder(
        builder: (context) {
          // Rebuild when one of them change states
          final themeMode = context.watch<ThemeCubit>().state;
          final locale = context.watch<LocaleCubit>().state;

          return MaterialApp.router(
            locale: locale,
            supportedLocales: context.read<LocaleCubit>().supportedLocales,
            localizationsDelegates: AppI18N.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            title: 'App',
            routerConfig: router.router,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
