import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CrashlyticsCubit extends Cubit<void> {
  final FirebaseCrashlytics crashlytics;

  CrashlyticsCubit({required this.crashlytics}) : super(null);

  Future<void> log(String message) async {
    await crashlytics.log(message);
  }

  Future<void> recordError(
    dynamic error,
    StackTrace stack, {
    bool fatal = false,
    Map<String, dynamic>? context,
  }) async {
    await crashlytics.recordError(
      error,
      stack,
      fatal: fatal,
      reason: context?['reason'],
    );
  }

  Future<void> setUserIdentifier(String id) async {
    await crashlytics.setUserIdentifier(id);
  }

  Future<void> setCustomKey(String key, String value) async {
    await crashlytics.setCustomKey(key, value);
  }
}
