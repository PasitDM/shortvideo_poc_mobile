import 'package:app_template/data/data_sources/auth_remote_data_source.dart';
import 'package:app_template/data/data_sources/user_remote_data_source.dart';
import 'package:app_template/domain/api_client/api_client.dart';
import 'package:app_template/domain/repositories/auth_repository.dart';
import 'package:app_template/domain/repositories/store_version_repository.dart';
import 'package:app_template/domain/repositories/user_repository.dart';
import 'package:app_template/domain/storages/app_storage.dart';
import 'package:app_template/domain/storages/secure_storage.dart';
import 'package:app_template/domain/storages/token_vault.dart';
import 'package:app_template/domain/use_cases/get_user_use_case.dart';
import 'package:app_template/domain/use_cases/login_with_email_use_case.dart';
import 'package:app_template/domain/use_cases/splash_use_case.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ApiClient,
  AppStorage,
  AuthRemoteDataSource,
  AuthRepository,
  Dio,
  GetUserUseCase,
  LoginWithEmailUseCase,
  SecureStorage,
  SessionCubit,
  SplashScreenUseCase,
  StoreVersionRepository,
  TokenVault,
  UserRemoteDataSource,
  UserRepository,
])
void main() {}
