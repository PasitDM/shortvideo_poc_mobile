import 'package:flutter/material.dart';

import 'font_sizes.dart';

class AppTextStyle {
  static const String fontFamily = '';

  static TextStyle _base(double size, FontWeight weight, double lineHeightPx) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: lineHeightPx / size,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  // Weight helper methods (for backward compatibility)
  static TextStyle w400(double fontSize) => _base(fontSize, FontWeight.w400, fontSize * 1.5);
  static TextStyle w500(double fontSize) => _base(fontSize, FontWeight.w500, fontSize * 1.5);
  static TextStyle w600(double fontSize) => _base(fontSize, FontWeight.w600, fontSize * 1.5);
  static TextStyle w700(double fontSize) => _base(fontSize, FontWeight.w700, fontSize * 1.5);

  // ============================================================================
  // FIGMA DESIGN TOKENS
  // ============================================================================
  /// LargeTitle Regular - Size: 24, LineHeight: 36
  static TextStyle get largeTitleRegular => _base(AppFontSizes.fontSize24, FontWeight.w400, 36);

  /// LargeTitle Medium - Size: 24, LineHeight: 36
  static TextStyle get largeTitleMedium => _base(AppFontSizes.fontSize24, FontWeight.w500, 36);

  /// LargeTitle Bold - Size: 24, LineHeight: 36
  static TextStyle get largeTitleBold => _base(AppFontSizes.fontSize24, FontWeight.w700, 36);

  /// Subtitle Regular - Size: 20, LineHeight: 30
  static TextStyle get subtitleRegular => _base(AppFontSizes.fontSize20, FontWeight.w400, 30);

  /// Subtitle Medium - Size: 20, LineHeight: 30
  static TextStyle get subtitleMedium => _base(AppFontSizes.fontSize20, FontWeight.w500, 30);

  /// Subtitle Bold - Size: 20, LineHeight: 30
  static TextStyle get subtitleBold => _base(AppFontSizes.fontSize20, FontWeight.w700, 30);

  /// Body1 Regular (Content1) - Size: 16, LineHeight: 24
  static TextStyle get body1Regular => _base(AppFontSizes.fontSize16, FontWeight.w400, 24);

  /// Body1 Medium (Content1) - Size: 16, LineHeight: 24
  static TextStyle get body1Medium => _base(AppFontSizes.fontSize16, FontWeight.w500, 24);

  /// Body1 Bold (Content1) - Size: 16, LineHeight: 24
  static TextStyle get body1Bold => _base(AppFontSizes.fontSize16, FontWeight.w700, 24);

  /// Body2 Regular (Content2) - Size: 14, LineHeight: 24
  static TextStyle get body2Regular => _base(AppFontSizes.fontSize14, FontWeight.w400, 24);

  /// Body2 Medium (Content2) - Size: 14, LineHeight: 24
  static TextStyle get body2Medium => _base(AppFontSizes.fontSize14, FontWeight.w500, 24);

  /// Body2 Bold (Content2) - Size: 14, LineHeight: 24
  static TextStyle get body2Bold => _base(AppFontSizes.fontSize14, FontWeight.w700, 24);

  /// Caption Regular - Size: 12, LineHeight: 20
  static TextStyle get captionRegular => _base(AppFontSizes.fontSize12, FontWeight.w400, 20);

  /// Caption Medium - Size: 12, LineHeight: 20
  static TextStyle get captionMedium => _base(AppFontSizes.fontSize12, FontWeight.w500, 20);

  /// Caption Bold - Size: 12, LineHeight: 20
  static TextStyle get captionBold => _base(AppFontSizes.fontSize12, FontWeight.w700, 20);
}
