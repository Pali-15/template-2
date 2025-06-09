import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsCubit extends Cubit<void> {
  final FirebaseAnalytics analytics;

  AnalyticsCubit({required this.analytics}) : super(null);

  /// Logs a generic event
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  /// Sets the current screen
  Future<void> logScreenView({required String screenName}) async {
    await analytics.logEvent(
      name: 'screen_view',
      parameters: {'firebase_screen': screenName},
    );
  }

  /// Sets a user ID
  Future<void> setUserId(String userId) async {
    await analytics.setUserId(id: userId);
  }

  /// Sets a user property
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await analytics.setUserProperty(name: name, value: value);
  }
}
