import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/app_localizations.dart';
import '../cubits/app_language_cubit.dart';
import '../cubits/session/session_cubit.dart';
import '../cubits/theme_mode_cubit.dart';
import '../styles/app_colors.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  AppColorsTheme get appColors => Theme.of(this).extension<AppColorsTheme>()!;

  ThemeModeCubit get themeModeCubit => read<ThemeModeCubit>();
  AppLanguageCubit get appLanguageCubit => read<AppLanguageCubit>();
  SessionCubit get sessionCubit => read<SessionCubit>();
}
