import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding/bloc/onboarding/onboarding_bloc.dart';
import 'package:flutter_onboarding/bloc/timer/timer_cubit.dart';
import 'package:flutter_onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(
            create: (BuildContext context) => OnboardingBloc(),
          ),
          BlocProvider<TimerCubit>(
            create: (BuildContext context) => TimerCubit(),
          ),
        ],
        child: const OnBoardingScreen(),
      ),
    );
  }
}
