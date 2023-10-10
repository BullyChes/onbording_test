import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding/UI/Onboarding/onboarding.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is ChangePageEvent) {
        emit(OnboardingInitial(pageIndex: event.newPageIndex, pageData: event.newPage));
      }
    });
  }
}
