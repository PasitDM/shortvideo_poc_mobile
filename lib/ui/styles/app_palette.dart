import 'dart:ui';

/// Raw/Base Colors from Figma Design System
/// These are the foundation colors - use AppColorsTheme for semantic colors
class AppPalette {
  AppPalette._();

  // Zinc Neutral Colors
  static const Color zincLevel00 = Color(0xFF18181B); // Background/Primary
  static const Color zincLevel01 = Color(0xFF27272A); // Background/Tertiary
  static const Color zincLevel02 = Color(0xFF52525C); // Background/Secondary, Text/Tertiary, Border/Secondary, Icon/Tertiary
  static const Color zincLevel03 = Color(0xFF9F9FA9); // Text/Secondary, Icon/Secondary
  static const Color zincLevel04 = Color(0xFFE4E4E7); // Text/Primary, Icon/Primary, Background/white

  // Brand Colors (Bandflippy)
  static const Color bandflippyPrimary = Color(
    0xFF8869FC,
  ); // Background/Brand-Primary, Text/Primary-Brand, Border/Primary, Button/Primary, Visual/Brand-Primary
  static const Color bandflippyPrimary2 = Color(0xFF332B51); // Background/Brand-Secondary
  static const Color bandflippySecondary = Color(
    0xFFA965DA,
  ); // Background/Brand-Secondary 2, Button/Default-Brand 2, Visual/Brand-Secondary

  // Red / Error Colors
  static const Color red400 = Color(0xFFFF6467); // Text/Error, Border/Error
  static const Color red500 = Color(0xFFFB2C36); // Button/Error

  // Warning Colors (not defined in Figma, kept for compatibility)
  static const Color warningDefault = Color(0xFFF97316);
  static const Color warningDark = Color(0xFF9A3412);

  // Success Colors (not defined in Figma, kept for compatibility)
  static const Color successDefault = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF166534);

  // Additional Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
