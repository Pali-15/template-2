import 'package:flutter/material.dart';
import 'package:template/app_root.dart';
import 'package:template/core/di/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await createDependencies();
  runApp(AppRoot());
}
