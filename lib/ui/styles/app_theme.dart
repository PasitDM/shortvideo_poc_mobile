import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_palette.dart';
import 'app_text_style.dart';

/// App Theme configuration with Material 3 + custom AppColorsTheme
class AppTheme {
  const AppTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppPalette.bandflippyPrimary,
      onPrimary: AppPalette.white,
      secondary: AppPalette.zincLevel02,
      onSecondary: AppPalette.white,
      error: AppPalette.red400,
      onError: AppPalette.white,
      surface: AppPalette.white,
      onSurface: AppPalette.zincLevel00,
    );
  }

  ThemeData light() {
    return theme(
      lightScheme(),
      extensions: [AppColorsTheme.light()],
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: AppPalette.bandflippyPrimary,
      onPrimary: AppPalette.white,
      secondary: AppPalette.zincLevel02,
      onSecondary: AppPalette.zincLevel04,
      error: AppPalette.red400,
      onError: AppPalette.white,
      surface: AppPalette.zincLevel00,
      onSurface: AppPalette.zincLevel04,
    );
  }

  ThemeData dark() {
    return theme(
      darkScheme(),
      extensions: [AppColorsTheme.dark()],
    );
  }

  ThemeData theme(
    ColorScheme colorScheme, {
    Iterable<ThemeExtension<AppColorsTheme>>? extensions,
  }) {
    const baseTextTheme = TextTheme();

    final appColors =
        extensions?.firstOrNull as AppColorsTheme? ??
        (colorScheme.brightness == Brightness.light ? AppColorsTheme.light() : AppColorsTheme.dark());

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      fontFamily: AppTextStyle.fontFamily,
      textTheme: baseTextTheme.apply(
        fontFamily: AppTextStyle.fontFamily,
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      extensions: extensions,
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.backgroundPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: appColors.iconPrimary),
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
          color: appColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.buttonPrimary,
          foregroundColor: appColors.textPrimary,
          disabledBackgroundColor: appColors.backgroundSecondary,
          disabledForegroundColor: appColors.textTertiary,
          minimumSize: const Size(120, 36),
          padding: EdgeInsets.zero,
          elevation: 1,
          textStyle: baseTextTheme.bodyMedium?.copyWith(
            fontFamily: AppTextStyle.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: appColors.buttonPrimary,
          side: BorderSide(color: appColors.borderSecondary),
          disabledForegroundColor: appColors.textTertiary,
          minimumSize: const Size(64, 36),
          padding: EdgeInsets.zero,
          textStyle: baseTextTheme.bodyMedium?.copyWith(
            fontFamily: AppTextStyle.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.backgroundSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: baseTextTheme.bodyMedium?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
          color: appColors.textTertiary,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.borderSecondary),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.borderSecondary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.borderPrimary, width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.borderError),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.borderSecondary),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: appColors.textSecondary,
        contentTextStyle: baseTextTheme.bodyMedium?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
          color: appColors.backgroundPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: appColors.textPrimary,
        unselectedLabelColor: appColors.textTertiary,
        labelStyle: baseTextTheme.bodyMedium?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: baseTextTheme.bodyMedium?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: appColors.backgroundPrimary,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
          color: appColors.textPrimary,
        ),
        contentTextStyle: baseTextTheme.bodyMedium?.copyWith(
          fontFamily: AppTextStyle.fontFamily,
          color: appColors.textSecondary,
        ),
      ),
    );
  }
}
