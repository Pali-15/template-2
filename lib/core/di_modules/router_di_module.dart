import 'package:template/app/page_1_nested/repository.dart';
import 'package:template/core/di/di_module.dart';
import 'package:template/core/router/app_router.dart';

class RouterDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton(RoutesBuilder())
      ..registerSingleton(
        AppRouter(
          builder: getIt<RoutesBuilder>(),
          page1Repository: getIt<Page1Repository>(),
        ),
      );
  }
}
