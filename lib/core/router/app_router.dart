import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/single_child_widget.dart';
import 'package:template/app/page_1/page_1.dart';
import 'package:template/app/page_1_nested/bloc/bloc.dart';
import 'package:template/app/page_1_nested/page_1_nested.dart';
import 'package:template/app/page_1_nested/repository.dart';
import 'package:template/app/page_2/page_2.dart';
import 'package:template/core/common_widgets/bottom_navbar.dart';
import 'package:template/core/router/route_wrapper.dart';
import 'package:template/core/router/routes.dart';

class AppRouter {
  // Dependencies
  late final RoutesBuilder _builder;
  late final Page1Repository _page1Repository;
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router;

  GoRouter get router => _router;

  AppRouter({required builder, required Page1Repository page1Repository})
    : _builder = builder,
      _page1Repository = page1Repository {
    _router = GoRouter(
      initialLocation: AppRoutes.page1,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
          builder:
              (context, state, navigationShell) =>
                  BottomNavbar(navigationShell: navigationShell),
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.page1,
                  name: AppRoutes.page1,
                  builder: _builder.page1Builder,
                  routes: [
                    routeWithBloc(
                      path: AppRoutes.page1Nested,
                      providers: [
                        BlocProvider<Page1Bloc>(
                          create:
                              (_) =>
                                  Page1Bloc(_page1Repository)
                                    ..add(Page1BlocLoad()),
                        ),
                      ],
                      builder: _builder.page1NestedBuilder,
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.page2,
                  name: AppRoutes.page2,
                  builder: _builder.page2Builder,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class RoutesBuilder {
  RoutesBuilder();
  //Builder functions here
  Widget page1Builder(BuildContext context, GoRouterState state) {
    // If needed read params from routing here, and wrap the child with BlocProviders
    return RouteWrapper(child: Page1());
  }

  Widget page2Builder(BuildContext context, GoRouterState state) {
    return RouteWrapper(child: Page2());
  }

  Widget page1NestedBuilder(BuildContext context, GoRouterState state) {
    return RouteWrapper(child: Page1Nested());
  }
}

/// Only use to provide blocs to this single route.
/// For blocs that are used on multiple screens down the hierarchy, use `routeWithInheritedBloc`.
GoRoute routeWithBloc({
  required String path,
  required List<SingleChildWidget> providers,
  List<SingleChildWidget Function(BuildContext, GoRouterState)>
      providerBuilders =
      const [],
  required GoRouterWidgetBuilder builder,
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    path: path,
    name: path,
    builder:
        (context, state) => MultiBlocProvider(
          providers: [
            ...providers,
            ...providerBuilders.map((builder) => builder(context, state)),
          ],
          child: builder(context, state),
        ),
    routes: routes,
  );
}

/// Only use to provide blocs to all routes under this route.
/// For blocs that are used only on a single screen, continue to provide them in the builders.
ShellRoute routeWithInheritedBloc({
  required String path,
  required List<SingleChildWidget> providers,
  required GoRouterWidgetBuilder builder,
  required NavigatorObserver observer,
  List<RouteBase> routes = const [],
}) {
  return ShellRoute(
    builder: (_, _, child) {
      return PopScope(
        child: MultiBlocProvider(providers: providers, child: child),
      );
    },
    routes: [GoRoute(path: path, name: path, builder: builder, routes: routes)],
    observers: [observer],
  );
}
