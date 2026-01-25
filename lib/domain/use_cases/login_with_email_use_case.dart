import '../../data/models/requests/login_with_email_request.dart';
import '../../ui/cubits/session/session_cubit.dart';
import '../core/result.dart';
import '../repositories/auth_repository.dart';
import 'get_user_use_case.dart';

class LoginWithEmailUseCase {
  final SessionCubit sessionCubit;
  final AuthRepository authRepository;
  final GetUserUseCase getUserUseCase;

  LoginWithEmailUseCase({
    required this.sessionCubit,
    required this.authRepository,
    required this.getUserUseCase,
  });

  Future<Result<Unit>> call({required LoginWithEmailRequest request}) async {
    final result = await authRepository.loginWithEmail(request: request);

    switch (result) {
      case Success():
        return getUserUseCase.me();
      case Failure():
        return Failure(result.error);
    }
  }
}
