import 'package:mocktail/mocktail.dart';
import 'package:template/app/page_1_nested/bloc/bloc.dart';
import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/firebase/analytics_cubit.dart';
import 'package:template/core/firebase/crashlytics_cubit.dart';
import 'package:template/core/l10n/locale_cubit.dart';

class MockCrashlyticsCubit extends Mock implements CrashlyticsCubit {}

class MockAnalyticsCubit extends Mock implements AnalyticsCubit {}

class MockLocaleCubit extends Mock implements LocaleCubit {}

class MockThemeCubit extends Mock implements ThemeCubit {}

class MockPage1Bloc extends Mock implements Page1Bloc {}
