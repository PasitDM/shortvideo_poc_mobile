import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/requests/login_with_email_request.dart';
import '../../../../domain/core/result.dart';
import '../../../../domain/use_cases/login_with_email_use_case.dart';
import 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final LoginWithEmailUseCase loginWithEmailUseCase;

  LoginScreenCubit({required this.loginWithEmailUseCase})
    : super(const LoginScreenState());

  void skipLogin() async {
    emit(state.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.success());
  }

  void login() async {
    emit(state.loading());

    final result = await loginWithEmailUseCase.call(
      request: const LoginWithEmailRequest(
        email: '',
        password: '',
      ),
    );

    switch (result) {
      case Success():
        emit(state.success());
      case Failure(:final error):
        emit(state.failure(error));
    }
  }
}
