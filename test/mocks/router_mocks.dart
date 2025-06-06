import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'router_mocks.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GoRouter>(),
  MockSpec<GoRouterDelegate>(),
  MockSpec<GoRouterState>()
])
export 'router_mocks.mocks.dart';

/// Creates a mock GoRouter and sets the current path (returned by the location getter)
/// to the given path.
MockGoRouter createGoRouterWithCurrentPath(String currentPath) {
  final router = MockGoRouter();
  final delegate = MockGoRouterDelegate();
  when(router.routerDelegate).thenReturn(delegate);
  final matchList = RouteMatchList(
    matches: const [],
    uri: Uri(path: currentPath),
    pathParameters: const {},
  );
  when(delegate.currentConfiguration).thenReturn(matchList);
  return router;
}
