import 'package:template/core/di/di_module.dart';
import 'package:template/core/extensions/locals_extension.dart';
import 'package:template/core/l10n/locale_cubit.dart';

class LocaleDiModule extends DiModule {
  @override
  void initializeModule(GetIt getIt) {
    getIt.registerSingleton<LocaleCubit>(LocaleCubit(Locales.en.toLocale));
  }
}
