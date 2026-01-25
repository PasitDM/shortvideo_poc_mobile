import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_screen_state.dart';

class OnboardingScreenCubit extends Cubit<OnboardingScreenState> {
  OnboardingScreenCubit() : super(const OnboardingScreenState());

  void setPageIndex(int index) {
    emit(state.copyWith(pageIndex: index));
  }
}
