import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:template/core/router/app_routes.dart';
import 'package:template/app/page_1/page_1.dart';
import 'package:template/app/page_1_nested/bloc/bloc.dart';
import 'package:template/app/page_1_nested/page_1_nested.dart';

import 'mocks/bloc_mocks.mocks.dart';
import 'mocks/router_mocks.mocks.dart';
import 'test_extension.dart';
import 'utils/bloc_test_utils.dart';

void main() {
  testWidgets('Page 1 nested screen show loaded data', (
    WidgetTester tester,
  ) async {
    // Arrange
    final mockPage1Bloc = MockPage1Bloc();
    mockitoWhenListen(
      mockPage1Bloc,
      initState: Page1BlocStateLoaded(['Item 1', 'Item 2', 'Item 3']),
    );

    // Act
    await tester.pumpAppScreen(
      BlocProvider<Page1Bloc>.value(
        value: mockPage1Bloc,
        child: const Page1Nested(),
      ),
    );

    // Assert
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
  });

  testWidgets('Test routing on page 1', (WidgetTester tester) async {
    final router = MockGoRouter();

    await tester.pumpAppScreen(const Page1(), router: router);

    await tester.tap(find.text("Go to nested page"));

    verify(router.go(const Page1NestedRoute().location)).called(1);
  });
}
