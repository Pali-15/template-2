import 'package:template/core/di/di_module.dart';
import 'package:template/core/di_modules/locale_di_module.dart';
import 'package:template/core/di_modules/router_di_module.dart';
import 'package:template/core/di_modules/theme_di_module.dart';

final resolveInstance = GetIt.instance;

Future<void> createDependencies() async {
  await Bootstrap.initialize();
}

void disposeDependencies() {
  DiModule.resetDependencies();
}

sealed class Bootstrap {
  static Future<void> initialize() async {
    // Initialize all the modules here
    List<DiModule> modules = [
      ThemeDiModule(),
      LocaleDiModule(),
      RouterDiModule(),
    ];

    for (final module in modules) {
      await module.initialize();
    }
  }

  static Future<void> restartDependencies() async {
    await DiModule.resetDependencies();
    await initialize();
  }
}
