import 'package:template/app/page_1_nested/repository.dart';
import 'package:template/core/di/di_module.dart';

class Page1NestedDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingleton<Page1Repository>(Page1Repository());
  }
}
