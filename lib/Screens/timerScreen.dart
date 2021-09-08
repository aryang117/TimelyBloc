import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/Screens/actions.dart';
import '/Screens/background.dart';
import '/timerBloc/timerBloc.dart';

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
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 100, bottom: 300.0),
                child: TimerTextField(),
              ),
              ActionsWidget(),
            ],
          ),
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

class TimerTextField extends StatelessWidget {
  const TimerTextField({Key? key}) : super(key: key);

  int _getTime(int min, int sec) {
    int time = ((min * 60) + sec);
    print("getTime =" + time.toString());
    return time;
  }

  @override
  Widget build(BuildContext context) {
    final _minController = TextEditingController(text: '00');
    final _secController = TextEditingController(text: '00');

    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = ((duration % 60)).floor().toString().padLeft(2, '0');

    int totalTime = context.read<TimerBloc>().getTotalTime();

    void updateDuration() {
      context.read<TimerBloc>().setTotalTime(_getTime(
          int.parse(_minController.text), int.parse(_secController.text)));

      print(_minController.text + 'eheh');
    }

    return BlocBuilder<TimerBloc, TimerState>(
      builder: (_, timerState) {
        _minController.text = minutesStr;
        _secController.text = secondsStr;

        print(timerState);

        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 100.0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerField(
                      controller: _minController,
                      isReadOnly: () =>
                          (timerState is TimerRunInProgress) ? true : false,
                      onSubmit: updateDuration),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                    child:
                        Text(':', style: Theme.of(context).textTheme.headline1),
                  ),
                  TimerField(
                      controller: _secController,
                      isReadOnly: () =>
                          (timerState is TimerRunInProgress) ? true : false,
                      onSubmit: updateDuration),
                ],
              ),
            ),
            TimeProgressIndicator(
                getVal: () => timerState.duration / totalTime,
                colorBool: () =>
                    timerState is TimerRunInProgress ? true : false),
          ],
        );
      },
    );
  }
}

// timer fields for both sec and min
class TimerField extends StatelessWidget {
  const TimerField(
      {Key? key,
      required this.controller,
      required this.isReadOnly,
      required this.onSubmit})
      : super(key: key);

  final TextEditingController controller;
  final Function isReadOnly;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      child: TextFormField(
          decoration: InputDecoration(
              hintText: '00',
              focusColor: Colors.amber,
              counterText: '',
              border: InputBorder.none),
          controller: controller,
          keyboardType: TextInputType.number,
          readOnly: isReadOnly(),
          maxLength: 2,
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: Theme.of(context).textTheme.headline1!.fontSize! - 20),
          onFieldSubmitted: (String? x) {
            onSubmit();
          }),
    );
  }
}

// a progress indicator below the timer, well, showing the progress
class TimeProgressIndicator extends StatelessWidget {
  const TimeProgressIndicator(
      {Key? key, required this.getVal, required this.colorBool})
      : super(key: key);
  final Function getVal;
  final Function colorBool;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 120,
        child: LinearProgressIndicator(
            valueColor: colorBool()
                ? const AlwaysStoppedAnimation<Color>(Colors.redAccent)
                : const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            minHeight: 3,
            backgroundColor: Colors.grey[900],
            value: getVal()),
      ),
    );
  }
}
