import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/common_widgets/bottom_navbar.dart';
import 'package:template/router/app_routes.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router;

  GoRouter get router => _router;

  AppRouter() {
    _router = GoRouter(
      initialLocation: const Page1Route().location,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BottomNavbar(navigationShell: navigationShell);
          },
          branches:
              $appRoutes
                  .map((route) => StatefulShellBranch(routes: [route]))
                  .toList(),
        ),
      ],
    );
  }
}
