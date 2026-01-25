import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';

/// Typography definitions with GraphikThai font family
class AppTextStyle {
  AppTextStyle._();

  static const String fontFamily = 'GraphikThai';

  static TextStyle get _base => const TextStyle(
    fontFamily: fontFamily,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Thin - w100
  static TextStyle w100(double fontSize) => _base.copyWith(fontWeight: FontWeight.w100, fontSize: fontSize);

  /// ExtraLight - w200
  static TextStyle w200(double fontSize) => _base.copyWith(fontWeight: FontWeight.w200, fontSize: fontSize);

  /// Light - w300
  static TextStyle w300(double fontSize) => _base.copyWith(fontWeight: FontWeight.w300, fontSize: fontSize);

  /// Regular - w400
  static TextStyle w400(double fontSize) => _base.copyWith(fontWeight: FontWeight.w400, fontSize: fontSize);

  /// Medium - w500
  static TextStyle w500(double fontSize) => _base.copyWith(fontWeight: FontWeight.w500, fontSize: fontSize);

  /// SemiBold - w600
  static TextStyle w600(double fontSize) => _base.copyWith(fontWeight: FontWeight.w600, fontSize: fontSize);

  /// Bold - w700
  static TextStyle w700(double fontSize) => _base.copyWith(fontWeight: FontWeight.w700, fontSize: fontSize);

  /// ExtraBold - w800
  static TextStyle w800(double fontSize) => _base.copyWith(fontWeight: FontWeight.w800, fontSize: fontSize);

  /// Black - w900
  static TextStyle w900(double fontSize) => _base.copyWith(fontWeight: FontWeight.w900, fontSize: fontSize);

  // Common styles (examples)
  static TextStyle get header1 => w700(32);
  static TextStyle get header2 => w600(24);
  static TextStyle get header3 => w500(20);
  static TextStyle get bodyLarge => w400(16);
  static TextStyle get bodyMedium => w400(14);
  static TextStyle get bodySmall => w400(12);
}

/// TextStyle extensions for common modifications
extension TextStyleExtension on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline, decorationColor: color);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough, decorationColor: color);

  TextStyle withAlpha(double alpha) => copyWith(color: color?.withValues(alpha: alpha));

  // ColorScheme colors (for Material defaults)
  TextStyle colorPrimary(BuildContext context) => copyWith(color: context.colorScheme.primary);

  TextStyle colorSecondary(BuildContext context) => copyWith(color: context.colorScheme.secondary);

  TextStyle colorTertiary(BuildContext context) => copyWith(color: context.colorScheme.tertiary);

  TextStyle colorError(BuildContext context) => copyWith(color: context.colorScheme.error);

  TextStyle colorOnPrimary(BuildContext context) => copyWith(color: context.colorScheme.onPrimary);

  TextStyle colorOnSecondary(BuildContext context) => copyWith(color: context.colorScheme.onSecondary);

  TextStyle colorOnSurface(BuildContext context) => copyWith(color: context.colorScheme.onSurface);

  TextStyle colorOnSurfaceVariant(BuildContext context) => copyWith(color: context.colorScheme.onSurfaceVariant);

  // AppColorsTheme colors (for custom Figma colors)
  TextStyle colorTextDefault(BuildContext context) => copyWith(color: context.appColors.textDefault);

  TextStyle colorTextSecondary(BuildContext context) => copyWith(color: context.appColors.textSecondary);

  TextStyle colorTextThirdary(BuildContext context) => copyWith(color: context.appColors.textThirdary);

  TextStyle colorTextDisable(BuildContext context) => copyWith(color: context.appColors.textDisable);

  TextStyle colorTextBrand(BuildContext context) => copyWith(color: context.appColors.textBrand);

  TextStyle colorTextSuccess(BuildContext context) => copyWith(color: context.appColors.textSuccess);

  TextStyle colorTextWarning(BuildContext context) => copyWith(color: context.appColors.textWarning);

  TextStyle colorTextError(BuildContext context) => copyWith(color: context.appColors.textError);
}
