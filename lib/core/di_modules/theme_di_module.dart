import 'package:template/core/design/theme/theme_cubit.dart';
import 'package:template/core/di/di_module.dart';

class ThemeDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingleton<ThemeCubit>(ThemeCubit());
  }
}
