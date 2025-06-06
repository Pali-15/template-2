import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'state.dart';
part 'event.dart';
part 'bloc.freezed.dart';

class {{bloc_name.pascalCase()}}Bloc extends Bloc<{{bloc_name.pascalCase()}}BlocEvent, {{bloc_name.pascalCase()}}BlocState> {
  {{bloc_name.pascalCase()}}Bloc() : super({{bloc_name.pascalCase()}}BlocState.initial()) {
    on<{{bloc_name.pascalCase()}}BlocStarted>((event, emit) {
      // handle _Started
    });
  }
}