part of 'bloc.dart';

@freezed
class {{bloc_name.pascalCase()}}BlocEvent with _${{bloc_name.pascalCase()}}BlocEvent {
  const factory {{bloc_name.pascalCase()}}BlocEvent.started() = {{bloc_name.pascalCase()}}BlocStarted;
}
