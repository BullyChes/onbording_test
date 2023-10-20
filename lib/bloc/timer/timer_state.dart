part of 'timer_cubit.dart';

@immutable
sealed class TimerState {
  final int seconds;
  final double indicatorValue;
  final double pageIndex;

  const TimerState({
    required this.seconds,
    required this.indicatorValue,
    required this.pageIndex,
  });
}

final class TimerInitial extends TimerState {
  const TimerInitial() : super(seconds: 0, indicatorValue: 0, pageIndex: 0.0);
}

final class TimerStart extends TimerState {
  const TimerStart({
    required super.seconds,
    required super.indicatorValue,
    required super.pageIndex,
  });
}

final class TimerPause extends TimerState {
  const TimerPause({
    required super.seconds,
    required super.indicatorValue,
    required super.pageIndex,
  });
}

final class TimerStop extends TimerState {
  const TimerStop({
    required super.seconds,
    required super.indicatorValue,
    required super.pageIndex,
  });
}
