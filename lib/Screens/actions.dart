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
          if (timerState is TimerRunComplete)
            context.read<TimerBloc>().add(TimerReset());

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (timerState is TimerInitial) ...[
                MaterialButton(
                  color: Colors.redAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: 90,
                      width: 60,
                      child: Text('START')),
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(duration: timerState.duration)),
                ),
              ],
              if (timerState is TimerRunInProgress) ...[
                MaterialButton(
                  color: Colors.redAccent,
                  elevation: 0,
                  minWidth: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: 90,
                      width: 60,
                      child: Text('PAUSE')),
                  onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                ),
                MaterialButton(
                  color: Colors.grey[900],
                  elevation: 0,
                  minWidth: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: 90,
                      width: 60,
                      child: Text('RESET')),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],
              if (timerState is TimerRunPause) ...[
                MaterialButton(
                  color: Colors.blueAccent.shade700,
                  elevation: 0,
                  minWidth: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: 90,
                      width: 60,
                      child: Text('RESUME')),
                  onPressed: () =>
                      context.read<TimerBloc>().add(TimerResumed()),
                ),
                MaterialButton(
                  color: Colors.grey[900],
                  elevation: 0,
                  minWidth: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      height: 90,
                      width: 60,
                      child: Text('RESET')),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                ),
              ],
              // if (timerState is TimerRunComplete) ...[
              //   IconButton(
              //       iconSize: 65,
              //       onPressed: () =>
              //           context.read<TimerBloc>().add(TimerReset()),
              //       icon: Icon(Icons.replay_circle_filled_rounded)),
              // ],
            ],
          );
        });
  }
}
