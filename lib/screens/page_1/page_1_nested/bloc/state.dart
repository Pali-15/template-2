part of 'bloc.dart';

@freezed
class Page1BlocState with _$Page1BlocState {
  const factory Page1BlocState.initial() = Page1BlocStateInitial;
  const factory Page1BlocState.loaded(List<String> data) = Page1BlocStateLoaded;
}
