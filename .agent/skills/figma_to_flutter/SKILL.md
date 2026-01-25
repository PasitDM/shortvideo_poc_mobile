---
name: Figma to Flutter Implementation
description: Project-specific design system implementation guide. Teaches the agent how to translate Figma designs into Flutter code using this project's specific components (ThemedText, AppColors) and architecture patterns.
---

# Figma to Flutter Implementation Skill

Use this skill when implementing UI from Figma designs to ensure consistency with the `shortvideo_poc_mobile` codebase.

## 1. Design System & Styling Rules

### 🚫 Forbidden Patterns
- **DO NOT** use `flutter_screenutil` (e.g., `100.w`, `20.sp`). Use standard logical pixels.
- **DO NOT** use hardcoded colors (e.g., `Colors.red`). Always use `context.appColors`.
- **DO NOT** use `GoogleFonts` directly. Use `AppTextStyle` or `ThemedText`.

### ✅ Required Styling Patterns
**Colors:**
- Map Figma colors to `AppColorsTheme`:
  - Brand Primary -> `context.appColors.buttonPrimary`
  - Background -> `context.appColors.backgroundPrimary`
  - Text -> `context.appColors.textDefault`

**Typography:**
- Use `ThemedText` for chainable styling (preferred):
  ```dart
  "Hello World".titleM.bold.color(context.appColors.textDefault)
  ```
- Or use `AppTextStyle` static methods:
  ```dart
  Text("Hello", style: AppTextStyle.w600(24).colorTextDefault(context))
  ```

## 2. Component Implementation Standards

### Buttons
Primary action buttons must follow this pattern:
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: context.appColors.buttonPrimary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    minimumSize: const Size(double.infinity, 48),
  ),
  onPressed: () {},
  child: "Button Text".bodyM.semiBold.color(Colors.white),
)
```

### Page Layout
- Use `SafeArea` only when necessary (e.g., inside Scaffolds).
- For full-screen images (Onboarding), use `Stack` and ignore SafeArea for the background image.

## 3. Project Architecture

### File Structure
Place new screens in `lib/ui/screens/<feature>/`:
```
lib/ui/screens/<feature>/
├── <feature>_screen.dart       # Scaffold & Main Layout
├── widgets/                    # Sub-components (keep main file clean)
│   └── <feature>_body.dart
└── cubit/                      # Business Logic
    ├── <feature>_cubit.dart
    └── <feature>_state.dart
```

### Imports
- Use the central design system barrel file:
  ```dart
  import 'package:app_template/ui/styles/index.dart';
  ```
