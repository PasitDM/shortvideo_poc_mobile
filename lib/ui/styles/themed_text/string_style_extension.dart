import 'package:flutter/material.dart';

import '../font_sizes.dart';
import 'themed_text.dart';

/// String extension for creating ThemedText with predefined styles
/// Usage: "Hello".titleM.bold.color(Colors.red)
extension TextLess on String {
  ThemedText style(TextStyle style) => ThemedText(data: this, style: (t) => style);
  ThemedText get text => ThemedText(data: this, style: (t) => const TextStyle());

  // Display styles
  ThemedText get displayS => ThemedText(
    data: this,
    style: (t) => t.displaySmall!.copyWith(fontSize: AppFontSizes.displaySmall),
  );
  ThemedText get displayM => ThemedText(
    data: this,
    style: (t) => t.displayMedium!.copyWith(fontSize: AppFontSizes.displayMedium),
  );
  ThemedText get displayL => ThemedText(
    data: this,
    style: (t) => t.displayLarge!.copyWith(fontSize: AppFontSizes.displayLarge),
  );

  // Title styles
  ThemedText get titleS => ThemedText(
    data: this,
    style: (t) => t.titleSmall!.copyWith(fontSize: AppFontSizes.titleSmall),
  );
  ThemedText get titleM => ThemedText(
    data: this,
    style: (t) => t.titleMedium!.copyWith(fontSize: AppFontSizes.titleMedium, fontWeight: FontWeight.w600),
  );
  ThemedText get titleL => ThemedText(
    data: this,
    style: (t) => t.titleLarge!.copyWith(fontSize: AppFontSizes.titleLarge),
  );

  // Body styles
  ThemedText get bodyS => ThemedText(
    data: this,
    style: (t) => t.bodySmall!.copyWith(fontSize: AppFontSizes.bodySmall),
  );
  ThemedText get bodyM => ThemedText(
    data: this,
    style: (t) => t.bodyMedium!.copyWith(fontSize: AppFontSizes.bodyMedium),
  );
  ThemedText get bodyL => ThemedText(
    data: this,
    style: (t) => t.bodyLarge!.copyWith(fontSize: AppFontSizes.bodyLarge),
  );

  // Header styles
  ThemedText get headerS => ThemedText(
    data: this,
    style: (t) => t.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
  );
  ThemedText get headerM => ThemedText(
    data: this,
    style: (t) => t.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
  );
  ThemedText get headerL => ThemedText(
    data: this,
    style: (t) => t.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
  );

  // Label styles
  ThemedText get labelXS => ThemedText(
    data: this,
    style: (t) => t.bodySmall!.copyWith(fontSize: AppFontSizes.labelXS),
  );
  ThemedText get labelS => ThemedText(
    data: this,
    style: (t) => t.bodySmall!.copyWith(fontSize: AppFontSizes.labelSmall),
  );
  ThemedText get labelM => ThemedText(
    data: this,
    style: (t) => t.bodySmall!.copyWith(fontSize: AppFontSizes.labelMedium),
  );
  ThemedText get labelL => ThemedText(
    data: this,
    style: (t) => t.bodySmall!.copyWith(fontSize: AppFontSizes.labelLarge),
  );
}
