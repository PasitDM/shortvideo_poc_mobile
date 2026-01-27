import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/logger.dart';
import '../../../../domain/core/app_error.dart';
import '../../../../domain/core/result.dart';
import '../../../../domain/use_cases/splash_use_case.dart';
import '../../../cubits/session/session_cubit.dart';
import 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final SessionCubit sessionCubit;
  final SplashScreenUseCase useCase;

  SplashScreenCubit({
    required this.sessionCubit,
    required this.useCase,
  }) : super(const SplashScreenState());

  void initialize() async {
    try {
      Logger.debug.log('Splash: Initializing...');

      // Add a timeout to prevent hanging on slow store lookups
      final status = await useCase.getVersionStatus().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          Logger.debug.log('Splash: Version check timed out, proceeding to check session');
          return null;
        },
      );

      final canUpdate = status?.canUpdate ?? false;
      final storeVersion = status?.storeVersion;
      final appStoreLink = status?.appStoreLink;

      if (canUpdate && appStoreLink != null) {
        Logger.debug.log('Splash: New version available: $storeVersion');
        emit(
          state.newVersionAvailable(
            appStoreLink: appStoreLink,
            storeVersion: storeVersion,
          ),
        );
      } else {
        Logger.debug.log('Splash: No update needed or check skipped, checking session...');
        final result = await useCase.getUserSession().timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            Logger.debug.log('Splash: Session check timed out');
            return const Failure(AppError(message: 'Session check timed out'));
          },
        );

        switch (result) {
          case Success(:final value):
            Logger.debug.log('Splash: User authenticated: ${value.email}');
            sessionCubit.setUser(value);
            emit(state.authenticated());

          case Failure():
            Logger.debug.log('Splash: User unauthenticated or session check failed');
            emit(state.unauthenticated());
        }
      }
    } catch (e, stack) {
      Logger.logError('Splash: Initialization unexpected error', error: e, stackTrace: stack);
      emit(state.unauthenticated());
    }
  }
}
