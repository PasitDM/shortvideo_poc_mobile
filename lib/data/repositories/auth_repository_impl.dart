import '../../domain/core/app_error.dart';
import '../../domain/core/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/auth.dart';
import '../models/requests/login_with_email_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Auth>> loginWithEmail({
    required LoginWithEmailRequest request,
  }) async {
    try {
      final result = await _remoteDataSource.loginWithEmail(
        request: request,
      );
      return Success(result);
    } catch (error) {
      return Failure(AppError.from(error));
    }
  }
}
