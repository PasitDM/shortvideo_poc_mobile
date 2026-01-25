import 'package:flutter_bloc/flutter_bloc.dart';

import '../dashboard_screen_tab.dart';
import 'dashboard_screen_state.dart';

class DashboardScreenCubit extends Cubit<DashboardScreenState> {
  DashboardScreenCubit() : super(const DashboardScreenState());

  void setSelectedTab(DashboardScreenTab newTab) {
    emit(state.copyWith(selectedTab: newTab));
  }
}
