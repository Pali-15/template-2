import 'package:template/core/di/di_module.dart';
import 'package:template/core/router/app_router.dart';

class RouterDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt
      ..registerSingleton(RoutesBuilder())
      ..registerSingleton(AppRouter(getIt.get<RoutesBuilder>()));
  }
}
