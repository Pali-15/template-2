part of 'bloc.dart';

@freezed
class {{bloc_name.pascalCase()}}BlocState with _${{bloc_name.pascalCase()}}BlocState {
  const factory {{bloc_name.pascalCase()}}BlocState.initial() = {{bloc_name.pascalCase()}}BlocStateInitial;
}
