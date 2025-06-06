import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/core/extensions/router_extensions/go_router_extensions.dart';
import 'package:template/core/router/app_routes.dart';

extension ContextRouterExtension on BuildContext {
  void popNavigate<T>([T? result]) => GoRouter.of(this).popNavigate(result);

  bool canPop() => GoRouter.of(this).canPop();

  /// Navigate to a named route such as 'travel' (targets the name parameter of GoRoute()).
  void navigate(AppRoute route) => GoRouter.of(this).navigate(route);

  /// Navigate to path such as '/my-trip/travel' (targets the full path).
  void navigateToPath(AppRoute route) =>
      GoRouter.of(this).navigateToPath(route);

  bool routeExists(String route) {
    try {
      final uri = Uri.parse(route);

      return GoRouter.of(
        this,
      ).routeInformationParser.configuration.findMatch(uri).matches.isNotEmpty;
    } catch (err) {
      return false;
    }
  }

  Future<T?> navigatePush<T>(AppRoute<T> route) =>
      GoRouter.of(this).navigatePush(route);

  Future<T?> navigatePushWithEvent<T>(
    AppRoute<T> route, {
    required String event,
    Map<String, Object?>? parameters,
  }) {
    // read<AnalyticsRepository>().logEvent(
    //   eventName: event,
    //   parameters: parameters,
    // );
    return GoRouter.of(this).navigatePush(route);
  }

  /// Only use in the same branch for proper analytics triggering
  void navigatePushReplacement(AppRoute route) =>
      unawaited(GoRouter.of(this).navigatePushReplacement(route));

  void navigateWithEvent(
    AppRoute route, {
    required String event,
    Map<String, Object?>? parameters,
  }) {
    // unawaited(
    //   read<AnalyticsRepository>().logEvent(
    //     eventName: event,
    //     parameters: parameters,
    //   ),
    // );
    return GoRouter.of(this).navigate(route);
  }
}
