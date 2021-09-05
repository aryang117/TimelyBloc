part of 'timerBloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState({required this.duration});

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration: duration);

  @override
  String toString() => 'Timer Initial {duration : $duration}';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration: duration);

  @override
  String toString() => 'TimerRunPause {duration : $duration}';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration: duration);

  @override
  String toString() => 'TimerRunInProgress {duration : $duration}';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(duration: 0);
}
