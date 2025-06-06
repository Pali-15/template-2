import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'state.dart';
part 'event.dart';
part 'bloc.freezed.dart';

class Page1Bloc extends Bloc<Page1BlocEvent, Page1BlocState> {
  Page1Bloc() : super(Page1BlocState.initial()) {
    on<Page1BlocLoad>((event, emit) {
      emit(Page1BlocState.loaded(['test1', 'test2']));
    });
  }
}
