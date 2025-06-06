import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app/screens/page_1/page_1.dart';
import 'package:template/app/screens/page_1/page_1_nested/bloc/bloc.dart';
import 'package:template/app/screens/page_1/page_1_nested/page_1_nested.dart';
import 'package:template/app/screens/page_2/page_2.dart';

part 'app_routes.g.dart';

// Root: /page1
@TypedGoRoute<Page1Route>(
  path: '/page1',
  routes: [TypedGoRoute<Page1NestedRoute>(path: 'page1Nested')],
)
class Page1Route extends GoRouteData {
  const Page1Route();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Page1();
}

class Page1NestedRoute extends GoRouteData {
  const Page1NestedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => BlocProvider(
    create: (context) => Page1Bloc()..add(Page1BlocLoad()),
    child: const Page1Nested(),
  );
}

// Root: /page2
@TypedGoRoute<Page2Route>(path: '/page2')
class Page2Route extends GoRouteData {
  const Page2Route();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Page2();
}
