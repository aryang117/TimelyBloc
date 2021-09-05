import 'dart:async';

import 'package:bloctimerflutter/ticker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timerState.dart';
part 'timerEvent.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  //static const int _duration = 60;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSub;
  TimerBloc({required Ticker ticker, required int duration})
      : _ticker = ticker,
        super(TimerInitial(duration));

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is TimerStarted) yield* _mapTimerStartedToState(event);
    if (event is TimerTicked) yield* _mapTimerTickedToState(event);
    if (event is TimerPaused) yield* _mapTimerPausedState(event);
    if (event is TimerResumed) yield* _mapTimerResumedState(event);
    if (event is TimerReset) yield* _mapTimerResetState(event);
  }

  @override
  Future close() {
    _tickerSub?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted timerStarted) async* {
    yield TimerRunInProgress(timerStarted.duration);
    _tickerSub?.cancel();
    _tickerSub = _ticker
        .tick(ticks: timerStarted.duration)
        .listen((event) => {add(TimerTicked(duration: event))});
  }

  Stream<TimerState> _mapTimerPausedState(TimerPaused timerPaused) async* {
    if (state is TimerRunInProgress) _tickerSub?.pause();
    yield TimerRunPause(state.duration);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked ticked) async* {
    yield ticked.duration > 0
        ? TimerRunInProgress(ticked.duration)
        : TimerRunComplete();
  }

  Stream<TimerState> _mapTimerResumedState(TimerResumed timerResumed) async* {
    if (state is TimerRunPause) _tickerSub?.resume();
    yield TimerRunInProgress(state.duration);
  }

  Stream<TimerState> _mapTimerResetState(TimerReset timerReset) async* {
    _tickerSub?.cancel();
    yield TimerInitial(300);
  }
}
