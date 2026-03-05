import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Semantic/Component Colors from Figma Design System
/// Use via context.appColors extension
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  // Text Colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textError;
  final Color textPrimaryBrand;

  // Background Colors
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color backgroundWhite;
  final Color backgroundBrandPrimary;
  final Color backgroundBrandSecondary;
  final Color backgroundBrandSecondary2;

  // Border Colors
  final Color borderPrimary;
  final Color borderSecondary;
  final Color borderError;

  // Icon Colors
  final Color iconPrimary;
  final Color iconPrimaryBrand;
  final Color iconSecondary;
  final Color iconTertiary;

  // Button Colors
  final Color buttonPrimary;
  final Color buttonError;
  final Color buttonDefaultBrand2;

  const AppColorsTheme({
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textError,
    required this.textPrimaryBrand,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.backgroundWhite,
    required this.backgroundBrandPrimary,
    required this.backgroundBrandSecondary,
    required this.backgroundBrandSecondary2,
    required this.borderPrimary,
    required this.borderSecondary,
    required this.borderError,
    required this.iconPrimary,
    required this.iconPrimaryBrand,
    required this.iconSecondary,
    required this.iconTertiary,
    required this.buttonPrimary,
    required this.buttonError,
    required this.buttonDefaultBrand2,
  });

  factory AppColorsTheme.light() {
    return const AppColorsTheme(
      // Text (light: dark text on white background)
      textPrimary: AppPalette.zincLevel00,
      textSecondary: AppPalette.zincLevel02,
      textTertiary: AppPalette.zincLevel03,
      textError: AppPalette.red400,
      textPrimaryBrand: AppPalette.bandflippyPrimary,

      // Background
      backgroundPrimary: AppPalette.white,
      backgroundSecondary: AppPalette.zincLevel04,
      backgroundTertiary: AppPalette.zincLevel04,
      backgroundWhite: AppPalette.zincLevel04,
      backgroundBrandPrimary: AppPalette.bandflippyPrimary,
      backgroundBrandSecondary: AppPalette.bandflippyPrimary2,
      backgroundBrandSecondary2: AppPalette.bandflippySecondary,

      // Border
      borderPrimary: AppPalette.bandflippyPrimary,
      borderSecondary: AppPalette.zincLevel03,
      borderError: AppPalette.red400,

      // Icon
      iconPrimary: AppPalette.zincLevel00,
      iconPrimaryBrand: AppPalette.bandflippyPrimary,
      iconSecondary: AppPalette.zincLevel02,
      iconTertiary: AppPalette.zincLevel03,

      // Button
      buttonPrimary: AppPalette.bandflippyPrimary,
      buttonError: AppPalette.red500,
      buttonDefaultBrand2: AppPalette.bandflippySecondary,
    );
  }

  factory AppColorsTheme.dark() {
    return const AppColorsTheme(
      // Text
      textPrimary: AppPalette.zincLevel04, // Text/Primary (#E4E4E7)
      textSecondary: AppPalette.zincLevel03, // Text/Secondary (#9F9FA9)
      textTertiary: AppPalette.zincLevel02, // Text/Tertiary (#52525C)
      textError: AppPalette.red400, // Text/Error (#FF6467)
      textPrimaryBrand: AppPalette.bandflippyPrimary, // Text/Primary-Brand (#8869FC)
      // Background
      backgroundPrimary: AppPalette.zincLevel00, // Background/Primary (#18181B)
      backgroundSecondary: AppPalette.zincLevel02, // Background/Secondary (#52525C)
      backgroundTertiary: AppPalette.zincLevel01, // Background/Tertiary (#27272A)
      backgroundWhite: AppPalette.zincLevel04, // Background/white (#E4E4E7)
      backgroundBrandPrimary: AppPalette.bandflippyPrimary, // Background/Brand-Primary (#8869FC)
      backgroundBrandSecondary: AppPalette.bandflippyPrimary2, // Background/Brand-Secondary (#332B51)
      backgroundBrandSecondary2: AppPalette.bandflippySecondary, // Background/Brand-Secondary 2 (#A965DA)
      // Border
      borderPrimary: AppPalette.bandflippyPrimary, // Border/Primary (#8869FC)
      borderSecondary: AppPalette.zincLevel02, // Border/Secondary (#52525C)
      borderError: AppPalette.red400, // Border/Error (#FF6467)
      // Icon
      iconPrimary: AppPalette.zincLevel04, // Icon/Primary (#E4E4E7)
      iconPrimaryBrand: AppPalette.bandflippyPrimary, // Icon/Primary-Brand (#8869FC)
      iconSecondary: AppPalette.zincLevel03, // Icon/Secondary (#9F9FA9)
      iconTertiary: AppPalette.zincLevel02, // Icon/Tertiary (#52525C)
      // Button
      buttonPrimary: AppPalette.bandflippyPrimary, // Button/Primary (#8869FC)
      buttonError: AppPalette.red500, // Button/Error (#FB2C36)
      buttonDefaultBrand2: AppPalette.bandflippySecondary, // Button/Default-Brand 2 (#A965DA)
    );
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textError,
    Color? textPrimaryBrand,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? backgroundWhite,
    Color? backgroundBrandPrimary,
    Color? backgroundBrandSecondary,
    Color? backgroundBrandSecondary2,
    Color? borderPrimary,
    Color? borderSecondary,
    Color? borderError,
    Color? iconPrimary,
    Color? iconPrimaryBrand,
    Color? iconSecondary,
    Color? iconTertiary,
    Color? buttonPrimary,
    Color? buttonError,
    Color? buttonDefaultBrand2,
  }) {
    return AppColorsTheme(
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textError: textError ?? this.textError,
      textPrimaryBrand: textPrimaryBrand ?? this.textPrimaryBrand,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      backgroundWhite: backgroundWhite ?? this.backgroundWhite,
      backgroundBrandPrimary: backgroundBrandPrimary ?? this.backgroundBrandPrimary,
      backgroundBrandSecondary: backgroundBrandSecondary ?? this.backgroundBrandSecondary,
      backgroundBrandSecondary2: backgroundBrandSecondary2 ?? this.backgroundBrandSecondary2,
      borderPrimary: borderPrimary ?? this.borderPrimary,
      borderSecondary: borderSecondary ?? this.borderSecondary,
      borderError: borderError ?? this.borderError,
      iconPrimary: iconPrimary ?? this.iconPrimary,
      iconPrimaryBrand: iconPrimaryBrand ?? this.iconPrimaryBrand,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      iconTertiary: iconTertiary ?? this.iconTertiary,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonError: buttonError ?? this.buttonError,
      buttonDefaultBrand2: buttonDefaultBrand2 ?? this.buttonDefaultBrand2,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(covariant ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) return this;

    return AppColorsTheme(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textPrimaryBrand: Color.lerp(textPrimaryBrand, other.textPrimaryBrand, t)!,
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary: Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundTertiary: Color.lerp(backgroundTertiary, other.backgroundTertiary, t)!,
      backgroundWhite: Color.lerp(backgroundWhite, other.backgroundWhite, t)!,
      backgroundBrandPrimary: Color.lerp(backgroundBrandPrimary, other.backgroundBrandPrimary, t)!,
      backgroundBrandSecondary: Color.lerp(backgroundBrandSecondary, other.backgroundBrandSecondary, t)!,
      backgroundBrandSecondary2: Color.lerp(backgroundBrandSecondary2, other.backgroundBrandSecondary2, t)!,
      borderPrimary: Color.lerp(borderPrimary, other.borderPrimary, t)!,
      borderSecondary: Color.lerp(borderSecondary, other.borderSecondary, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconPrimaryBrand: Color.lerp(iconPrimaryBrand, other.iconPrimaryBrand, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconTertiary: Color.lerp(iconTertiary, other.iconTertiary, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonError: Color.lerp(buttonError, other.buttonError, t)!,
      buttonDefaultBrand2: Color.lerp(buttonDefaultBrand2, other.buttonDefaultBrand2, t)!,
    );
  }
}
