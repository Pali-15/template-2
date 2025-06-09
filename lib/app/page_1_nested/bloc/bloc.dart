import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template/app/page_1_nested/repository.dart';
import 'package:template/core/utils/result.dart';
part 'state.dart';
part 'event.dart';
part 'bloc.freezed.dart';

class Page1Bloc extends Bloc<Page1BlocEvent, Page1BlocState> {
  final Page1Repository _repository;
  Page1Bloc(this._repository) : super(Page1BlocState.initial()) {
    on<Page1BlocLoad>((event, emit) {
      final data = _repository.getData();
      if (data is ResultData<List<String>>) {
        emit(Page1BlocState.loaded(data.value));
      } else if (data is ResultError<List<String>>) {
        emit(Page1BlocState.error(data.message));
      }
    });
  }
}
