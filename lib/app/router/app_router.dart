import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../ui/screens/auth/get_started_screen.dart';
import '../../ui/screens/dashboard/dashboard_screen.dart';
import '../../ui/screens/history/history_screen.dart';
import '../../ui/screens/history1/history1_screen.dart';
import '../../ui/screens/history_2/history_2_screen.dart';
import '../../ui/screens/login/login_screen.dart';
import '../../ui/screens/onboarding/onboarding_screen.dart';
import '../../ui/screens/product/product_screen.dart';
import '../../ui/screens/products/products_screen.dart';
import '../../ui/screens/sign_up/sign_up_screen.dart';
import '../../ui/screens/splash/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.getStarted,
        builder: (context, state) {
          return const GetStartedScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.products,
        builder: (context, state) {
          return const ProductsScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.product,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'];
          return ProductScreen(productId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) {
          return const HistoryScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.history2,
        builder: (context, state) {
          return const History2Screen();
        },
      ),
      GoRoute(
        path: AppRoutes.history1,
        builder: (context, state) {
          return const History1Screen();
        },
      ),
    ],
  );
}
