part of 'bloc.dart';

@freezed
class Page1BlocEvent with _$Page1BlocEvent {
  const factory Page1BlocEvent.load() = Page1BlocLoad;
}
