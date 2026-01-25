import 'package:equatable/equatable.dart';
import 'package:mobile_template/utils/app_error.dart';

enum <FTName | pascalcase>ScreenStatus {
  initial,
  loading,
  ready,
  failure,
  ;

  bool get isLoading => this == <FTName | pascalcase>ScreenStatus.loading;
}

class <FTName | pascalcase>ScreenState extends Equatable {
  final <FTName | pascalcase>ScreenStatus status;
  final AppError? error;

  const <FTName | pascalcase>ScreenState({
    this.status = <FTName | pascalcase>ScreenStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
    status,
    error,
  ];

  <FTName | pascalcase>ScreenState copyWith({
    <FTName | pascalcase>ScreenStatus? status,
    AppError? error,
  }) {
    return <FTName | pascalcase>ScreenState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  <FTName | pascalcase>ScreenState loading() {
    return copyWith(
      status: <FTName | pascalcase>ScreenStatus.loading,
    );
  }

  <FTName | pascalcase>ScreenState ready() {
    return copyWith(
      status: <FTName | pascalcase>ScreenStatus.ready,
    );
  }

  <FTName | pascalcase>ScreenState failure(AppError error) {
    return copyWith(
      status: <FTName | pascalcase>ScreenStatus.failure,
      error: error,
    );
  }
}
