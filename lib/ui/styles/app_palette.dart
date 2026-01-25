import 'dart:ui';

/// Raw/Base Colors from Figma Design System
/// These are the foundation colors - use AppColorsTheme for semantic colors
class AppPalette {
  AppPalette._();

  // Neutral Colors
  static const Color neutralLevel00 = Color(0xFF121212); // Figma: System/Main
  static const Color neutralLevel01 = Color(0xFF1E1E1E);
  static const Color neutralLevel02 = Color(0xFF4F4F4F);
  static const Color neutralLevel03 = Color(0xFF787878);
  static const Color neutralLevel04 = Color(0xFFA1A1A1);
  static const Color neutralLevel06 = Color(0xFFFAFAFA);

  // Error Colors
  static const Color errorDefault = Color(0xFFF43F5E);
  static const Color errorDark = Color(0xFF881337);

  // Warning Colors
  static const Color warningDefault = Color(0xFFF97316);
  static const Color warningDark = Color(0xFF9A3412);

  // Success Colors
  static const Color successDefault = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF166534);

  // Brand Colors
  static const Color brandPrimaryDefault = Color(0xFF880185); // Figma: Action/Primary

  // ============================================================================
  // ADDITIONAL COLORS FOR LIGHT THEME
  // ============================================================================

  // Light Theme Backgrounds
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightBackgroundSecondary = Color(0xFFF5F5F5);
  static const Color lightBackgroundTertiary = Color(0xFFEEEEEE);

  // Light Theme Text Colors
  static const Color lightTextPrimary = Color(0xFF0D0D0D);
  static const Color lightTextSecondary = Color(0xFF4F4F4F);
  static const Color lightTextTertiary = Color(0xFF787878);
  static const Color lightTextDisable = Color(0xFFA1A1A1);

  // Light Theme Borders
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightBorderFocus = Color(0xFF202020);

  // Additional Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
