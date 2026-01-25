import '../../common/logger.dart';
import '../../data/models/user.dart';
import '../../data/models/version_status.dart';
import '../core/app_error.dart';
import '../core/result.dart';
import '../repositories/store_version_repository.dart';
import '../repositories/user_repository.dart';
import '../storages/token_vault.dart';

class SplashScreenUseCase {
  final TokenVault tokenVault;
  final StoreVersionRepository storeVersionRepository;
  final UserRepository userRepository;

  SplashScreenUseCase({
    required this.tokenVault,
    required this.storeVersionRepository,
    required this.userRepository,
  });

  Future<VersionStatus?> getVersionStatus() async {
    try {
      final result = await storeVersionRepository.getVersionStatus();
      return result;
    } catch (error, stackTrace) {
      Logger.logError(
        'Error getVersionStatus',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<Result<User>> getUserSession() async {
    final hasAccessToken = await tokenVault.hasAccessToken();
    if (!hasAccessToken) {
      return const Failure(AppError(message: 'Access token not found'));
    }

    final result = await userRepository.me();
    switch (result) {
      case Success(:final value):
        return Success(value);
      case Failure(:final error):
        return Failure(error);
    }
  }
}
