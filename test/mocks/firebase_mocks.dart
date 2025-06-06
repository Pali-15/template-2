import 'package:mockito/annotations.dart';
import 'package:template/core/firebase/analytics_cubit.dart';
import 'package:template/core/firebase/crashlytics_cubit.dart';

@GenerateNiceMocks([MockSpec<CrashlyticsCubit>(), MockSpec<AnalyticsCubit>()])
export 'firebase_mocks.mocks.dart';
