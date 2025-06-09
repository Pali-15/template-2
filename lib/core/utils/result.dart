import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {
  const Result();
}

final class ResultData<T> extends Result<T> {
  const ResultData(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

class ResultError<T> extends Result<T> {
  const ResultError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ResultErrorWithData<T, S extends Object?> extends ResultError<T> {
  const ResultErrorWithData(super.message, {required this.data});

  final S data;

  @override
  List<Object?> get props => [data, message];
}
