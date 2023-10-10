part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

final class ChangePageEvent extends OnboardingEvent {
  final OnBoardingModel newPage;
  final int newPageIndex;

  ChangePageEvent({required this.newPage, required this.newPageIndex});
}
