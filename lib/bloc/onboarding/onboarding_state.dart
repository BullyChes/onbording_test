part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {
  final int pageIndex;
  final OnBoardingModel? pageData;

  OnboardingInitial({this.pageData, this.pageIndex = 0});
}

// final class OnboardingPageChanged extends OnboardingState {
//   // final OnBoardingModel page;
//   final int pageIndex;

//   OnboardingPageChanged({this.pageIndex = 0});
// }
