import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:template/app/template_app.dart';
import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/di/di_module.dart';
import 'package:template/core/l10n/locale_cubit.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return _BlocInsertWrapper();
  }
}

class _BlocInsertWrapper extends HookWidget {
  const _BlocInsertWrapper();

  @override
  Widget build(BuildContext context) {
    final blocProviders = useMemoized(_baseBlocProviders);
    // final repositories = useMemoized(_baseRepositories);
    return MultiBlocProvider(
      providers: blocProviders,
      child: TemplateApp(),
      // child: MultiRepositoryProvider(
      //   providers: repositories,
      //   child: TemplateApp(),
      // ),
    );
  }
}

List<BlocProvider> _baseBlocProviders() {
  return [
    BlocProvider<ThemeCubit>.value(value: DiModule.getInstance<ThemeCubit>()),
    BlocProvider<LocaleCubit>.value(value: DiModule.getInstance<LocaleCubit>()),
  ];
}

List<RepositoryProvider> _baseRepositories() {
  return [];

  // return [
  //   RepositoryProvider<AnalyticsRepository>.value(value: DiModule.getInstance<AnalyticsRepository>()..init()),
  //   RepositoryProvider<CrashlyticsRepository>.value(
  //     value: DiModule.getInstance<CrashlyticsRepository>()..initializeCrashlytics(),
  //   ),
  //   RepositoryProvider<FirebaseMessagingRepository>.value(value: DiModule.getInstance<FirebaseMessagingRepository>()),
  // ];
}
