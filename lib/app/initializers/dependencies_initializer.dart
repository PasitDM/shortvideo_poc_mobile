import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/data_sources/store_version_remote_data_source.dart';
import '../../data/data_sources/user_remote_data_source.dart';
import '../../data/data_sources/video_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/store_version_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/video_repository_impl.dart';
import '../../data/storages/app_storage_impl.dart';
import '../../data/storages/token_vault_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/store_version_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/video_repository.dart';
import '../../domain/storages/app_storage.dart';
import '../../domain/storages/secure_storage.dart';
import '../../domain/storages/token_vault.dart';
import '../../domain/use_cases/get_user_use_case.dart';
import '../../domain/use_cases/login_with_email_use_case.dart';
import '../../ui/cubits/app_language_cubit.dart';
import '../../ui/cubits/session/session_cubit.dart';
import '../../ui/cubits/theme_mode_cubit.dart';
import 'api_client_initializer.dart';
import 'secure_storage_initializer.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final storage = AppStorageImpl(sharedPrefs);
  getIt.registerSingleton<AppStorage>(storage);

  final secureStorage = await initializeSecureStorage(storage);
  getIt.registerSingleton<SecureStorage>(secureStorage);

  final tokenVault = TokenVaultImpl(secureStorage);
  getIt.registerSingleton<TokenVault>(tokenVault);

  final themeModeCubit = ThemeModeCubit(storage);
  getIt.registerSingleton<ThemeModeCubit>(themeModeCubit);
  await themeModeCubit.initialize();

  final appLanguageCubit = AppLanguageCubit(storage);
  getIt.registerSingleton<AppLanguageCubit>(appLanguageCubit);
  await appLanguageCubit.initialize();

  final sessionCubit = SessionCubit();
  getIt.registerSingleton<SessionCubit>(sessionCubit);

  final apiClient = initializeApiClient(
    tokenVault: tokenVault,
    appLanguageCubit: appLanguageCubit,
  );

  final externalApiClient = initializeExternalApiClient();

  /// Repositories

  getIt.registerLazySingleton<StoreVersionRepository>(
    () => StoreVersionRepositoryImpl(
      StoreVersionRemoteDataSource(externalApiClient),
    ),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(AuthRemoteDataSource(apiClient)),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(UserRemoteDataSource(apiClient)),
  );
  getIt.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(VideoRemoteDataSource(apiClient)),
  );

  /// UseCases

  getIt.registerFactory<GetUserUseCase>(
    () => GetUserUseCase(sessionCubit: sessionCubit, userRepository: getIt()),
  );
  getIt.registerFactory<LoginWithEmailUseCase>(
    () => LoginWithEmailUseCase(
      sessionCubit: sessionCubit,
      authRepository: getIt(),
      getUserUseCase: getIt(),
    ),
  );
}
