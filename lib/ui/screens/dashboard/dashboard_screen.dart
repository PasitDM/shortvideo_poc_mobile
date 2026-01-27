import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global_widgets/loading_overlay.dart';
import '../add_short/add_short_screen.dart';
import '../home/cubit/home_screen_cubit.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';
import '../settings/cubit/settings_screen_cubit.dart';
import '../settings/settings_screen.dart';
import '../short_video/short_video_screen.dart';
import 'cubit/dashboard_screen_cubit.dart';
import 'cubit/dashboard_screen_state.dart';
import 'dashboard_screen_tab.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardScreenCubit()),
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => SettingsScreenCubit()),
      ],
      child: const DashboardScreenView(),
    );
  }
}

class DashboardScreenView extends StatefulWidget {
  const DashboardScreenView({super.key});

  @override
  State<DashboardScreenView> createState() => _DashboardScreenViewState();
}

class _DashboardScreenViewState extends State<DashboardScreenView> {
  late final DashboardScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DashboardScreenCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = [
      context.select<HomeScreenCubit, bool>(
        (cubit) => cubit.state.status.isLoading,
      ),
      context.select<SettingsScreenCubit, bool>(
        (cubit) => cubit.state.status.isLoading,
      ),
    ].any((e) => e == true);

    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Widget _body() {
    return BlocSelector<DashboardScreenCubit, DashboardScreenState, DashboardScreenTab>(
      selector: (state) => state.selectedTab,
      builder: (context, selectedTab) {
        return IndexedStack(
          index: selectedTab.index,
          children: const [
            HomeScreenView(),
            ShortVideoScreen(),
            AddShortScreen(),
            SearchScreen(),
            SettingsScreenView(),
          ],
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return BlocSelector<DashboardScreenCubit, DashboardScreenState, DashboardScreenTab>(
      selector: (state) => state.selectedTab,
      builder: (context, selectedTab) {
        return NavigationBar(
          onDestinationSelected: (index) {
            HapticFeedback.lightImpact();
            final newTab = DashboardScreenTab.values.firstWhereOrNull(
              (e) => e.index == index,
            );
            if (newTab == DashboardScreenTab.addShort) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddShortScreen(),
                  fullscreenDialog: true,
                ),
              );
              return;
            }
            if (newTab != null) {
              _cubit.setSelectedTab(newTab);
            }
          },
          selectedIndex: selectedTab.index,
          destinations: DashboardScreenTab.values.map((e) {
            if (e == DashboardScreenTab.addShort) {
              return const Padding(
                padding: EdgeInsets.only(top: 15),
                child: NavigationDestination(
                  icon: _CustomAddIcon(),
                  label: '',
                ),
              );
            }
            return NavigationDestination(
              icon: Icon(e.iconData),
              label: e.title(context),
            );
          }).toList(),
        );
      },
    );
  }
}

class _CustomAddIcon extends StatelessWidget {
  const _CustomAddIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 40,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 32, 211, 234),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
