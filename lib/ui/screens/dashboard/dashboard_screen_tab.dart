import 'package:flutter/material.dart';

enum DashboardScreenTab {
  home,
  shortVideo,
  addShort,
  search,
  settings;

  IconData get iconData {
    switch (this) {
      case DashboardScreenTab.home:
        return Icons.home;
      case DashboardScreenTab.shortVideo:
        return Icons.play_circle_outline;
      case DashboardScreenTab.addShort:
        return Icons.add_box_outlined;
      case DashboardScreenTab.search:
        return Icons.search;
      case DashboardScreenTab.settings:
        return Icons.settings;
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case DashboardScreenTab.home:
        return 'Home';
      case DashboardScreenTab.shortVideo:
        return 'Shorts';
      case DashboardScreenTab.addShort:
        return 'Add';
      case DashboardScreenTab.search:
        return 'Search';
      case DashboardScreenTab.settings:
        return 'Settings';
    }
  }
}
