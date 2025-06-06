import 'package:template/core/router/routes.dart';

class AppRoute<ReturnType> {
  static const QUERY_INPUT_KEY = 'app-route-input';

  final String name;
  final Map<String, dynamic> queryParameters;

  const AppRoute._(this.name, {this.queryParameters = const {}});

  static AppRoute page1Route() => AppRoute._(AppRoutes.page1);
  static AppRoute page1NestedRoute() => AppRoute._(AppRoutes.page1Nested);
  static AppRoute page2Route() => AppRoute._(AppRoutes.page2);
}
