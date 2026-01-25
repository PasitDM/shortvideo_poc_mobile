import '../../domain/core/app_error.dart';
import '../../domain/core/result.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/user_remote_data_source.dart';
import '../models/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  const UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<User>> me() async {
    try {
      final result = await _remoteDataSource.me();
      return Success(result);
    } catch (error) {
      return Failure(AppError.from(error));
    }
  }
}
