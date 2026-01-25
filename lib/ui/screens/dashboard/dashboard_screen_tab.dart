import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

enum DashboardScreenTab {
  home,
  shorts,
  settings;

  IconData get iconData {
    switch (this) {
      case DashboardScreenTab.home:
        return Icons.home;
      case DashboardScreenTab.shorts:
        return Icons.ondemand_video;
      case DashboardScreenTab.settings:
        return Icons.settings;
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case DashboardScreenTab.home:
        return context.l10n.dashboard_screen_tab_home;
      case DashboardScreenTab.shorts:
        return context.l10n.dashboard_screen_tab_shorts;
      case DashboardScreenTab.settings:
        return context.l10n.dashboard_screen_tab_settings;
    }
  }
}
