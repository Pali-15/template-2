import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/design/theme/theme_cubit.dart';
import 'package:template/l10n/app_localizations.dart';
import 'package:template/l10n/locale_cubit.dart';
import 'package:template/router/router.dart';
import 'package:template/design/theme/theme.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// Global providers are commented out since, with an empty array it will throw an exception
class _MyAppState extends State<MyApp> {
  late final AppRouter router;
  // late final List<RepositoryProvider<dynamic>> _globalProviders;
  @override
  void initState() {
    super.initState();
    router = AppRouter();
    // _globalProviders = GlobalDependencies().dependencies.toList(growable: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return MultiRepositoryProvider(
    //   providers: _globalProviders,
    //   child:
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
          create: (context) => LocaleCubit(Locale(Locales.en.languageCode)),
        ),
      ],
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
    // );
  }
}
