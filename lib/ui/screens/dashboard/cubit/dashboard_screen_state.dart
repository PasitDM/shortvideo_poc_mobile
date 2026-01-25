import 'package:equatable/equatable.dart';

import '../dashboard_screen_tab.dart';

class DashboardScreenState extends Equatable {
  final DashboardScreenTab selectedTab;

  const DashboardScreenState({this.selectedTab = DashboardScreenTab.home});

  @override
  List<Object?> get props => [selectedTab];

  DashboardScreenState copyWith({DashboardScreenTab? selectedTab}) {
    return DashboardScreenState(selectedTab: selectedTab ?? this.selectedTab);
  }
}
