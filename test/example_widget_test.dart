import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/app/page_1/page_1.dart';
import 'package:template/app/page_1_nested/page_1_nested.dart';
import 'package:template/core/router/routes.dart';
import 'package:template/core/utils/result.dart';

import 'mocks/mock_repository.dart';
import 'test_extension.dart';

void main() {
  testWidgets('Page 1 nested screen show loaded data', (
    WidgetTester tester,
  ) async {
    // Arrange
    final mockRepository = MockPage1Repository();

    when(
      () => mockRepository.getData(any()),
    ).thenReturn(ResultData(['Item 0', 'Item 1', 'Item 2']));

    final router = buildMockRouter(page1Repository: mockRepository);
    // Act
    await tester.testAppWrapper(
      router: router,
      route: '${AppRoutes.page1}/${AppRoutes.page1Nested}',
    );

    // Assert
    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('Test routing on page 1', (WidgetTester tester) async {
    final mockRepository = MockPage1Repository();

    when(
      () => mockRepository.getData(any()),
    ).thenReturn(ResultData(['Item 0', 'Item 1', 'Item 2']));

    final router = buildMockRouter(page1Repository: mockRepository);
    // Act
    await tester.testAppWrapper(router: router, route: AppRoutes.page1);
    expect(find.byType(Page1), findsOneWidget);

    await tester.tap(find.text("Go to nested page"));
    await tester.pumpAndSettle();

    expect(find.byType(Page1Nested), findsOneWidget);
  });
}
