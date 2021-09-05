import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloctimerflutter/timer/timer.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (_, timerState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (timerState is TimerInitial) ...[
                FloatingActionButton(
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(duration: timerState.duration)),
                  child: Icon(Icons.play_arrow_rounded),
                ),
              ],
              if (timerState is TimerRunInProgress) ...[
                FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerPaused()),
                    child: Icon(Icons.pause_circle_outline_rounded)),
                FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    child: Icon(Icons.replay_circle_filled_rounded)),
              ],
              if (timerState is TimerRunPause) ...[
                FloatingActionButton(
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResumed()),
                  child: Icon(Icons.play_circle_outline_rounded),
                ),
                FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    child: Icon(Icons.replay_circle_filled_rounded)),
              ],
              if (timerState is TimerRunComplete) ...[
                FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    child: Icon(Icons.replay_circle_filled_rounded)),
              ],
            ],
          );
        });
  }
}
