import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// For any dependenciy that should be avaliable from the buildcontext define them here
// GlobalDep get globalDep => _get<GlobalDep>();
extension GlobalDependenciesExtension on BuildContext {
  // ignore: unused_element
  T _get<T>() => RepositoryProvider.of<T>(this);
}
