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
                IconButton(
                  iconSize: 65,
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(duration: timerState.duration)),
                  icon: Icon(Icons.play_circle_fill_rounded),
                ),
              ],
              if (timerState is TimerRunInProgress) ...[
                IconButton(
                    iconSize: 65,
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerPaused()),
                    icon: Icon(Icons.pause_circle_outline_rounded)),
                IconButton(
                    iconSize: 65,
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    icon: Icon(Icons.replay_circle_filled_rounded)),
              ],
              if (timerState is TimerRunPause) ...[
                IconButton(
                  iconSize: 65,
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResumed()),
                  icon: Icon(Icons.play_circle_outline_rounded),
                ),
                IconButton(
                    iconSize: 65,
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    icon: Icon(Icons.replay_circle_filled_rounded)),
              ],
              if (timerState is TimerRunComplete) ...[
                IconButton(
                    iconSize: 65,
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    icon: Icon(Icons.replay_circle_filled_rounded)),
              ],
            ],
          );
        });
  }
}
