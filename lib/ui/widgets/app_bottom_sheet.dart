import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';
import '../styles/index.dart';

class AppBottomSheet {
  AppBottomSheet._();

  /// Shows a confirmation bottom sheet with icon, title, description,
  /// and primary/secondary action buttons.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String description,
    required String primaryButtonText,
    required String secondaryButtonText,
    required VoidCallback onPrimaryPressed,
    required VoidCallback onSecondaryPressed,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AppBottomSheetContent(
        icon: icon,
        title: title,
        description: description,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
      ),
    );
  }
}

class _AppBottomSheetContent extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

  const _AppBottomSheetContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.backgroundTertiary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              SizedBox(
                width: 140,
                height: 140,
                child: icon,
              ),
              const SizedBox(height: 0),

              // Title
              Text(
                title,
                style: AppTextStyle.body1Bold.copyWith(
                  color: context.appColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                description,
                style: AppTextStyle.body2Regular.copyWith(
                  color: context.appColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                children: [
                  // Secondary Button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: onSecondaryPressed,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: context.appColors.borderSecondary,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          backgroundColor: context.appColors.backgroundTertiary,
                        ),
                        child: Text(
                          secondaryButtonText,
                          style: AppTextStyle.body1Medium.copyWith(
                            color: context.appColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Primary Button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: onPrimaryPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.appColors.buttonError,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          primaryButtonText,
                          style: AppTextStyle.body1Medium.copyWith(
                            color: context.appColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
