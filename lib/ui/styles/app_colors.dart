import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Semantic/Component Colors from Figma Design System
/// Use via context.appColors extension
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  // Text Colors
  final Color textDefault;
  final Color textError;
  final Color textErrorDisable;
  final Color textWarning;
  final Color textWarningDisable;
  final Color textSuccess;
  final Color textSuccessDisable;
  final Color textSecondary;
  final Color textThirdary;
  final Color textDisable;
  final Color textButtonDisable;
  final Color textBrand;

  // Background Colors
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundError;
  final Color backgroundErrorDisable;
  final Color backgroundWarning;
  final Color backgroundWarningDisable;
  final Color backgroundSuccess;
  final Color backgroundSuccessDisable;
  final Color backgroundDisable;
  final Color backgroundBrand;
  final Color backgroundThirdary;

  // Border Colors
  final Color borderDefault;
  final Color borderSuccess;
  final Color borderFocus;
  final Color borderDisable;
  final Color borderError;
  final Color borderErrorDisable;
  final Color borderButtonThird;
  final Color borderWarning;
  final Color borderWarningDisable;

  // Icon Colors
  final Color iconDefault;
  final Color iconSuccess;
  final Color iconDisable;
  final Color iconError;
  final Color iconErrorDisable;
  final Color iconSuccessDisable;
  final Color iconSecondary;
  final Color iconWarning;
  final Color iconWarningDisable;

  // Button Colors
  final Color buttonPrimary;
  final Color buttonPrimaryDisable;
  final Color buttonSuccess;
  final Color buttonSuccessDisable;
  final Color buttonError;
  final Color buttonErrorDisable;
  final Color buttonSecondary;
  final Color buttonSecondaryDisable;
  final Color buttonThird;
  final Color buttonThirdDisable;

  const AppColorsTheme({
    required this.textDefault,
    required this.textError,
    required this.textErrorDisable,
    required this.textWarning,
    required this.textWarningDisable,
    required this.textSuccess,
    required this.textSuccessDisable,
    required this.textSecondary,
    required this.textThirdary,
    required this.textDisable,
    required this.textButtonDisable,
    required this.textBrand,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundError,
    required this.backgroundErrorDisable,
    required this.backgroundWarning,
    required this.backgroundWarningDisable,
    required this.backgroundSuccess,
    required this.backgroundSuccessDisable,
    required this.backgroundDisable,
    required this.backgroundBrand,
    required this.backgroundThirdary,
    required this.borderDefault,
    required this.borderSuccess,
    required this.borderFocus,
    required this.borderDisable,
    required this.borderError,
    required this.borderErrorDisable,
    required this.borderButtonThird,
    required this.borderWarning,
    required this.borderWarningDisable,
    required this.iconDefault,
    required this.iconSuccess,
    required this.iconDisable,
    required this.iconError,
    required this.iconErrorDisable,
    required this.iconSuccessDisable,
    required this.iconSecondary,
    required this.iconWarning,
    required this.iconWarningDisable,
    required this.buttonPrimary,
    required this.buttonPrimaryDisable,
    required this.buttonSuccess,
    required this.buttonSuccessDisable,
    required this.buttonError,
    required this.buttonErrorDisable,
    required this.buttonSecondary,
    required this.buttonSecondaryDisable,
    required this.buttonThird,
    required this.buttonThirdDisable,
  });

  factory AppColorsTheme.light() {
    return AppColorsTheme(
      // Text
      textDefault: AppPalette.lightTextPrimary,
      textError: AppPalette.errorDefault,
      textErrorDisable: AppPalette.errorDark,
      textWarning: AppPalette.warningDefault,
      textWarningDisable: AppPalette.warningDark,
      textSuccess: AppPalette.successDefault,
      textSuccessDisable: AppPalette.successDark,
      textSecondary: AppPalette.lightTextSecondary,
      textThirdary: AppPalette.lightTextTertiary,
      textDisable: AppPalette.lightTextDisable,
      textButtonDisable: AppPalette.lightTextTertiary,
      textBrand: AppPalette.brandPrimaryDefault,

      // Background
      backgroundPrimary: AppPalette.lightBackground,
      backgroundSecondary: AppPalette.lightBackgroundSecondary,
      backgroundError: AppPalette.errorDefault,
      backgroundErrorDisable: AppPalette.errorDark,
      backgroundWarning: AppPalette.warningDefault,
      backgroundWarningDisable: AppPalette.warningDark,
      backgroundSuccess: AppPalette.successDefault,
      backgroundSuccessDisable: AppPalette.successDark,
      backgroundDisable: AppPalette.lightBackgroundSecondary,
      backgroundBrand: AppPalette.brandPrimaryDefault,
      backgroundThirdary: AppPalette.lightBackgroundTertiary,

      // Border
      borderDefault: AppPalette.lightBorder,
      borderSuccess: AppPalette.successDefault,
      borderFocus: AppPalette.lightBorderFocus,
      borderDisable: AppPalette.lightBorder,
      borderError: AppPalette.errorDefault,
      borderErrorDisable: AppPalette.errorDark,
      borderButtonThird: AppPalette.brandPrimaryDefault,
      borderWarning: AppPalette.warningDefault,
      borderWarningDisable: AppPalette.warningDark,

      // Icon
      iconDefault: AppPalette.lightTextPrimary,
      iconSuccess: AppPalette.successDefault,
      iconDisable: AppPalette.lightTextDisable,
      iconError: AppPalette.errorDefault,
      iconErrorDisable: AppPalette.errorDark,
      iconSuccessDisable: AppPalette.successDark,
      iconSecondary: AppPalette.lightTextTertiary,
      iconWarning: AppPalette.warningDefault,
      iconWarningDisable: AppPalette.warningDark,

      // Button
      buttonPrimary: AppPalette.brandPrimaryDefault,
      buttonPrimaryDisable: AppPalette.lightTextDisable,
      buttonSuccess: AppPalette.successDefault,
      buttonSuccessDisable: AppPalette.successDark,
      buttonError: AppPalette.errorDefault,
      buttonErrorDisable: AppPalette.errorDark,
      buttonSecondary: AppPalette.white,
      buttonSecondaryDisable: AppPalette.lightBackgroundSecondary,
      buttonThird: AppPalette.brandPrimaryDefault.withValues(alpha: 0.2),
      buttonThirdDisable: AppPalette.lightTextDisable,
    );
  }

  factory AppColorsTheme.dark() {
    return AppColorsTheme(
      textDefault: AppPalette.neutralLevel06,
      textError: AppPalette.errorDefault,
      textErrorDisable: AppPalette.errorDark,
      textWarning: AppPalette.warningDefault,
      textWarningDisable: AppPalette.warningDark,
      textSuccess: AppPalette.successDefault,
      textSuccessDisable: AppPalette.successDark,
      textSecondary: AppPalette.neutralLevel04,
      textThirdary: AppPalette.neutralLevel03,
      textDisable: AppPalette.neutralLevel02,
      textButtonDisable: AppPalette.neutralLevel03,
      textBrand: AppPalette.brandPrimaryDefault,
      backgroundPrimary: AppPalette.neutralLevel00,
      backgroundSecondary: AppPalette.neutralLevel01,
      backgroundError: AppPalette.errorDefault,
      backgroundErrorDisable: AppPalette.errorDark,
      backgroundWarning: AppPalette.warningDefault,
      backgroundWarningDisable: AppPalette.warningDark,
      backgroundSuccess: AppPalette.successDefault,
      backgroundSuccessDisable: AppPalette.successDark,
      backgroundDisable: AppPalette.neutralLevel01,
      backgroundBrand: AppPalette.brandPrimaryDefault,
      backgroundThirdary: AppPalette.neutralLevel02,
      borderDefault: AppPalette.neutralLevel02,
      borderSuccess: AppPalette.successDefault,
      borderFocus: AppPalette.neutralLevel04,
      borderDisable: AppPalette.neutralLevel02,
      borderError: AppPalette.errorDefault,
      borderErrorDisable: AppPalette.errorDark,
      borderButtonThird: AppPalette.brandPrimaryDefault,
      borderWarning: AppPalette.warningDefault,
      borderWarningDisable: AppPalette.warningDark,
      iconDefault: AppPalette.neutralLevel06,
      iconSuccess: AppPalette.successDefault,
      iconDisable: AppPalette.neutralLevel03,
      iconError: AppPalette.errorDefault,
      iconErrorDisable: AppPalette.errorDark,
      iconSuccessDisable: AppPalette.successDark,
      iconSecondary: AppPalette.neutralLevel03,
      iconWarning: AppPalette.warningDefault,
      iconWarningDisable: AppPalette.warningDark,
      buttonPrimary: AppPalette.brandPrimaryDefault,
      buttonPrimaryDisable: AppPalette.neutralLevel02,
      buttonSuccess: AppPalette.successDefault,
      buttonSuccessDisable: AppPalette.successDark,
      buttonError: AppPalette.errorDefault,
      buttonErrorDisable: AppPalette.errorDark,
      buttonSecondary: AppPalette.neutralLevel00,
      buttonSecondaryDisable: AppPalette.neutralLevel01,
      buttonThird: AppPalette.brandPrimaryDefault.withValues(alpha: 0.2),
      buttonThirdDisable: AppPalette.neutralLevel02,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({
    Color? textDefault,
    Color? textError,
    Color? textErrorDisable,
    Color? textWarning,
    Color? textWarningDisable,
    Color? textSuccess,
    Color? textSuccessDisable,
    Color? textSecondary,
    Color? textThirdary,
    Color? textDisable,
    Color? textButtonDisable,
    Color? textBrand,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundError,
    Color? backgroundErrorDisable,
    Color? backgroundWarning,
    Color? backgroundWarningDisable,
    Color? backgroundSuccess,
    Color? backgroundSuccessDisable,
    Color? backgroundDisable,
    Color? backgroundBrand,
    Color? backgroundThirdary,
    Color? borderDefault,
    Color? borderSuccess,
    Color? borderFocus,
    Color? borderDisable,
    Color? borderError,
    Color? borderErrorDisable,
    Color? borderButtonThird,
    Color? borderWarning,
    Color? borderWarningDisable,
    Color? iconDefault,
    Color? iconSuccess,
    Color? iconDisable,
    Color? iconError,
    Color? iconErrorDisable,
    Color? iconSuccessDisable,
    Color? iconSecondary,
    Color? iconWarning,
    Color? iconWarningDisable,
    Color? buttonPrimary,
    Color? buttonPrimaryDisable,
    Color? buttonSuccess,
    Color? buttonSuccessDisable,
    Color? buttonError,
    Color? buttonErrorDisable,
    Color? buttonSecondary,
    Color? buttonSecondaryDisable,
    Color? buttonThird,
    Color? buttonThirdDisable,
  }) {
    return AppColorsTheme(
      textDefault: textDefault ?? this.textDefault,
      textError: textError ?? this.textError,
      textErrorDisable: textErrorDisable ?? this.textErrorDisable,
      textWarning: textWarning ?? this.textWarning,
      textWarningDisable: textWarningDisable ?? this.textWarningDisable,
      textSuccess: textSuccess ?? this.textSuccess,
      textSuccessDisable: textSuccessDisable ?? this.textSuccessDisable,
      textSecondary: textSecondary ?? this.textSecondary,
      textThirdary: textThirdary ?? this.textThirdary,
      textDisable: textDisable ?? this.textDisable,
      textButtonDisable: textButtonDisable ?? this.textButtonDisable,
      textBrand: textBrand ?? this.textBrand,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundError: backgroundError ?? this.backgroundError,
      backgroundErrorDisable: backgroundErrorDisable ?? this.backgroundErrorDisable,
      backgroundWarning: backgroundWarning ?? this.backgroundWarning,
      backgroundWarningDisable: backgroundWarningDisable ?? this.backgroundWarningDisable,
      backgroundSuccess: backgroundSuccess ?? this.backgroundSuccess,
      backgroundSuccessDisable: backgroundSuccessDisable ?? this.backgroundSuccessDisable,
      backgroundDisable: backgroundDisable ?? this.backgroundDisable,
      backgroundBrand: backgroundBrand ?? this.backgroundBrand,
      backgroundThirdary: backgroundThirdary ?? this.backgroundThirdary,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSuccess: borderSuccess ?? this.borderSuccess,
      borderFocus: borderFocus ?? this.borderFocus,
      borderDisable: borderDisable ?? this.borderDisable,
      borderError: borderError ?? this.borderError,
      borderErrorDisable: borderErrorDisable ?? this.borderErrorDisable,
      borderButtonThird: borderButtonThird ?? this.borderButtonThird,
      borderWarning: borderWarning ?? this.borderWarning,
      borderWarningDisable: borderWarningDisable ?? this.borderWarningDisable,
      iconDefault: iconDefault ?? this.iconDefault,
      iconSuccess: iconSuccess ?? this.iconSuccess,
      iconDisable: iconDisable ?? this.iconDisable,
      iconError: iconError ?? this.iconError,
      iconErrorDisable: iconErrorDisable ?? this.iconErrorDisable,
      iconSuccessDisable: iconSuccessDisable ?? this.iconSuccessDisable,
      iconSecondary: iconSecondary ?? this.iconSecondary,
      iconWarning: iconWarning ?? this.iconWarning,
      iconWarningDisable: iconWarningDisable ?? this.iconWarningDisable,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonPrimaryDisable: buttonPrimaryDisable ?? this.buttonPrimaryDisable,
      buttonSuccess: buttonSuccess ?? this.buttonSuccess,
      buttonSuccessDisable: buttonSuccessDisable ?? this.buttonSuccessDisable,
      buttonError: buttonError ?? this.buttonError,
      buttonErrorDisable: buttonErrorDisable ?? this.buttonErrorDisable,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,
      buttonSecondaryDisable: buttonSecondaryDisable ?? this.buttonSecondaryDisable,
      buttonThird: buttonThird ?? this.buttonThird,
      buttonThirdDisable: buttonThirdDisable ?? this.buttonThirdDisable,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(covariant ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) return this;

    return AppColorsTheme(
      textDefault: Color.lerp(textDefault, other.textDefault, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textErrorDisable: Color.lerp(textErrorDisable, other.textErrorDisable, t)!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      textWarningDisable: Color.lerp(textWarningDisable, other.textWarningDisable, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textSuccessDisable: Color.lerp(textSuccessDisable, other.textSuccessDisable, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textThirdary: Color.lerp(textThirdary, other.textThirdary, t)!,
      textDisable: Color.lerp(textDisable, other.textDisable, t)!,
      textButtonDisable: Color.lerp(textButtonDisable, other.textButtonDisable, t)!,
      textBrand: Color.lerp(textBrand, other.textBrand, t)!,
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary: Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundError: Color.lerp(backgroundError, other.backgroundError, t)!,
      backgroundErrorDisable: Color.lerp(backgroundErrorDisable, other.backgroundErrorDisable, t)!,
      backgroundWarning: Color.lerp(backgroundWarning, other.backgroundWarning, t)!,
      backgroundWarningDisable: Color.lerp(backgroundWarningDisable, other.backgroundWarningDisable, t)!,
      backgroundSuccess: Color.lerp(backgroundSuccess, other.backgroundSuccess, t)!,
      backgroundSuccessDisable: Color.lerp(backgroundSuccessDisable, other.backgroundSuccessDisable, t)!,
      backgroundDisable: Color.lerp(backgroundDisable, other.backgroundDisable, t)!,
      backgroundBrand: Color.lerp(backgroundBrand, other.backgroundBrand, t)!,
      backgroundThirdary: Color.lerp(backgroundThirdary, other.backgroundThirdary, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderSuccess: Color.lerp(borderSuccess, other.borderSuccess, t)!,
      borderFocus: Color.lerp(borderFocus, other.borderFocus, t)!,
      borderDisable: Color.lerp(borderDisable, other.borderDisable, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      borderErrorDisable: Color.lerp(borderErrorDisable, other.borderErrorDisable, t)!,
      borderButtonThird: Color.lerp(borderButtonThird, other.borderButtonThird, t)!,
      borderWarning: Color.lerp(borderWarning, other.borderWarning, t)!,
      borderWarningDisable: Color.lerp(borderWarningDisable, other.borderWarningDisable, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconSuccess: Color.lerp(iconSuccess, other.iconSuccess, t)!,
      iconDisable: Color.lerp(iconDisable, other.iconDisable, t)!,
      iconError: Color.lerp(iconError, other.iconError, t)!,
      iconErrorDisable: Color.lerp(iconErrorDisable, other.iconErrorDisable, t)!,
      iconSuccessDisable: Color.lerp(iconSuccessDisable, other.iconSuccessDisable, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconWarning: Color.lerp(iconWarning, other.iconWarning, t)!,
      iconWarningDisable: Color.lerp(iconWarningDisable, other.iconWarningDisable, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonPrimaryDisable: Color.lerp(buttonPrimaryDisable, other.buttonPrimaryDisable, t)!,
      buttonSuccess: Color.lerp(buttonSuccess, other.buttonSuccess, t)!,
      buttonSuccessDisable: Color.lerp(buttonSuccessDisable, other.buttonSuccessDisable, t)!,
      buttonError: Color.lerp(buttonError, other.buttonError, t)!,
      buttonErrorDisable: Color.lerp(buttonErrorDisable, other.buttonErrorDisable, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonSecondaryDisable: Color.lerp(buttonSecondaryDisable, other.buttonSecondaryDisable, t)!,
      buttonThird: Color.lerp(buttonThird, other.buttonThird, t)!,
      buttonThirdDisable: Color.lerp(buttonThirdDisable, other.buttonThirdDisable, t)!,
    );
  }
}
