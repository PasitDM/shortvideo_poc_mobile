import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up Screen (Placeholder)'),
            ElevatedButton(
              onPressed: () {
                // Mock Sign up
                context.go(AppRoutes.dashboard);
              },
              child: const Text('Sign Up & Go to Dashboard'),
            ),
            TextButton(
              onPressed: () {
                context.push(AppRoutes.login);
              },
              child: const Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
