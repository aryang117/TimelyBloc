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
                padding: EdgeInsets.symmetric(vertical: 100.0),
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
    const TextInputType textInputType = TextInputType.number;
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = ((duration % 60)).floor().toString().padLeft(2, '0');

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
                  Container(
                    width: 110,
                    child: TextFormField(
                        decoration: InputDecoration(
                            hintText: '00',
                            focusColor: Colors.amber,
                            counterText: '',
                            border: InputBorder.none),
                        controller: _minController,
                        keyboardType: textInputType,
                        readOnly:
                            (timerState is TimerRunInProgress) ? true : false,
                        maxLength: 2,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .fontSize! -
                                20),
                        onFieldSubmitted: (String? value) {
                          value = value == null ? '600' : value;
                          context.read<TimerBloc>().add(TimerStarted(
                              duration: _getTime(int.parse(value),
                                  int.parse(_secController.text))));
                          print('hehe' + value);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                    child:
                        Text(':', style: Theme.of(context).textTheme.headline1),
                  ),
                  Container(
                    width: 110,
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            hintText: '00',
                            focusColor: Colors.amber,
                            counterText: '',
                            border: InputBorder.none),
                        controller: _secController,
                        keyboardType: textInputType,
                        readOnly:
                            (timerState is TimerRunInProgress) ? true : false,
                        maxLength: 2,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .fontSize! -
                                  20,
                            ),
                        onFieldSubmitted: (String? value) {
                          value = value == null ? '600' : value;
                          context.read<TimerBloc>().add(TimerStarted(
                              duration: _getTime(int.parse(_minController.text),
                                  int.parse(value))));
                          print('weorfhsdidfh');
                          print('hehe' +
                              _minController.text.toString() +
                              ":" +
                              value);

                          //TODO : make another smol bloc for updation via formfields,
                          //the play button will track changes and when pressed will give new values to the timer

                          // context.read<FormBloc>().newString(_getTime(
                          //         int.parse(_minController.text), int.parse(value))
                          //     .toString());
                        }),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 120,
                //height: MediaQuery.of(context).size.width - 50,
                child: LinearProgressIndicator(
                    valueColor: timerState is TimerRunInProgress
                        ? const AlwaysStoppedAnimation<Color>(Colors.redAccent)
                        : const AlwaysStoppedAnimation<Color>(
                            Colors.blueAccent),
                    minHeight: 3,
                    backgroundColor: Colors.grey[900],
                    value: timerState.duration / ttime
                    //TODO: track total timer value via observer
                    ),
              ),
            )
          ],
        );
      },
    );
  }
}
