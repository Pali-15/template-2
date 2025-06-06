import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalDependencies {
  // Wrap every global dependencies in a Repository provider and store them in this array
  Iterable<RepositoryProvider> get dependencies => [];
}
