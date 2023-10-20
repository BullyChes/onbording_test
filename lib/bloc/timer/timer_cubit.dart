import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerInitial());

  Timer? _timer;
  double _indicatorValue = 0;

  void startTimer() {
    if (state is TimerInitial) {
      emit(
        const TimerStart(
          seconds: 0,
          indicatorValue: 0,
          pageIndex: 0.0,
        ),
      );
    } else {
      emit(
        TimerStart(
          seconds: state.seconds,
          indicatorValue: state.indicatorValue,
          pageIndex: state.pageIndex,
        ),
      );
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state is TimerStart) {
        TimerStart timerStart = state as TimerStart;

        if (timerStart.seconds < 7) {
          _indicatorValue += 0.15;

          emit(
            TimerStart(
              seconds: timerStart.seconds + 1,
              indicatorValue: _indicatorValue,
              pageIndex: state.pageIndex,
            ),
          );
        }
        if (timerStart.seconds == 7) {
          emit(
            TimerStop(
              seconds: timerStart.seconds,
              indicatorValue: 1,
              pageIndex: state.pageIndex,
            ),
          );
        }
      } else {
        _timer!.cancel();
      }
    });
  }

  void pauseTimer() {
    emit(
      TimerPause(
        seconds: state.seconds,
        indicatorValue: state.indicatorValue,
        pageIndex: state.pageIndex,
      ),
    );
    _timer?.cancel();
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer({required double pageIndex}) {
    emit(
      TimerStart(
        seconds: 0,
        indicatorValue: 0,
        pageIndex: pageIndex,
      ),
    );
    _indicatorValue = 0;
    _timer?.cancel();
    startTimer();
  }
}
