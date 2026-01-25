import 'package:equatable/equatable.dart';

import '../../../../domain/core/app_error.dart';

enum OnboardingScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == OnboardingScreenStatus.loading;
}

class OnboardingScreenState extends Equatable {
  final OnboardingScreenStatus status;
  final AppError? error;
  final int pageIndex;

  const OnboardingScreenState({
    this.status = OnboardingScreenStatus.initial,
    this.error,
    this.pageIndex = 0,
  });

  @override
  List<Object?> get props => [
    status,
    error,
    pageIndex,
  ];

  OnboardingScreenState copyWith({
    OnboardingScreenStatus? status,
    AppError? error,
    int? pageIndex,
  }) {
    return OnboardingScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  OnboardingScreenState loading() {
    return copyWith(
      status: OnboardingScreenStatus.loading,
    );
  }

  OnboardingScreenState ready() {
    return copyWith(
      status: OnboardingScreenStatus.ready,
    );
  }

  OnboardingScreenState failure(AppError error) {
    return copyWith(
      status: OnboardingScreenStatus.failure,
      error: error,
    );
  }
}
