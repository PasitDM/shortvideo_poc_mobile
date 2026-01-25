import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../extensions/build_context_extension.dart';
import '../../styles/index.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder social icons (replace with SVGs in real implementation)
    // Using Colors/Icons for now.

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Container(
              color: context.appColors.backgroundPrimary, // Fallback
              // child: Image.asset('assets/images/get_started_bg.png', fit: BoxFit.cover),
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black,
                  ],
                  stops: const [0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Social Buttons
                  _SocialButton(
                    label: 'Sign in with Google',
                    icon: Icons.g_mobiledata, // Placeholder
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _SocialButton(
                    label: 'Sign in with Facebook',
                    icon: Icons.facebook,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _SocialButton(
                    label: 'Sign in with Apple',
                    icon: Icons.apple,
                    onPressed: () {},
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.white24)), // neutralLevel02 is roughly dark grey
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or',
                          style: AppTextStyle.w400(14).copyWith(color: Colors.white54),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.white24)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Sign in with password
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.login),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.buttonPrimary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Sign in with password',
                      style: AppTextStyle.w600(14).copyWith(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyle.w400(14).copyWith(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.signUp),
                        child: Text(
                          'Sign up',
                          style: AppTextStyle.w600(14).copyWith(color: context.appColors.buttonPrimary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.backgroundSecondary, // neutralLevel01
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyle.w600(14),
          ),
        ],
      ),
    );
  }
}
