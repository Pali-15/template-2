import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

/// Based on bloc_test:whenListen
/// Triggers state changes in a way BlocListener can handle.
/// Need to pump() between state changes.
///
/// With delayBetweenStates it is possible to delay state changes. In that case
/// pump(const Duration()) can be used to get to the next state.
BlocBase<S> mockitoWhenListen<S>(
  BlocBase<S> bloc, {
  Iterable<S>? nextStates,
  Iterable<Completer> nextStateTriggers = const [],
  S? initState,
  Duration? delayBetweenStates,
}) {
  if (nextStateTriggers.isNotEmpty && delayBetweenStates != null) {
    throw ArgumentError(
        'nextStateTriggers and delayBetweenStates cannot be used together');
  }
  if (initState != null) {
    when(bloc.state).thenReturn(initState);
  }
  if (nextStates != null && nextStateTriggers.isNotEmpty) {
    final stream = _createNextStateStreamWithTriggers(
      nextStates,
      nextStateTriggers: nextStateTriggers.toList(growable: false),
    ).asBroadcastStream();
    when(bloc.stream).thenAnswer(
      (_) => stream.map((state) {
        when(bloc.state).thenReturn(state);
        return state;
      }),
    );
  } else if (nextStates != null) {
    final stream =
        _createNextStateStream(nextStates, delayBetween: delayBetweenStates)
            .asBroadcastStream();
    when(bloc.stream).thenAnswer(
      (_) => stream.map((state) {
        when(bloc.state).thenReturn(state);
        return state;
      }),
    );
  }
  return bloc;
}

Stream<S> _createNextStateStream<S>(Iterable<S> nextStates,
    {Duration? delayBetween}) async* {
  for (final nextState in nextStates) {
    if (delayBetween != null) {
      await Future.delayed(delayBetween);
    }
    yield nextState;
  }
}

Stream<S> _createNextStateStreamWithTriggers<S>(
  Iterable<S> nextStates, {
  List<Completer> nextStateTriggers = const [],
}) async* {
  for (final (index, nextState) in nextStates.indexed) {
    if (nextStateTriggers.length > index) {
      await nextStateTriggers[index].future;
    }
    yield nextState;
  }
}
