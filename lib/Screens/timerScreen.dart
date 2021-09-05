import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloctimerflutter/Screens/actions.dart';
import 'package:bloctimerflutter/Screens/background.dart';
import 'package:bloctimerflutter/timerBloc/timerBloc.dart';

import '../ticker.dart';
import '../timer/timer.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker(), duration: 120),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BackgroundWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0),
              child: Center(child: TimerText()),
            ),
            ActionsWidget(),
          ],
        ),
      ],
    ));
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = ((duration % 60)).floor().toString().padLeft(2, '0');

    print('$minutesStr : $secondsStr');

    return Text('$minutesStr : $secondsStr',
        style: Theme.of(context).textTheme.headline1);
  }
}
