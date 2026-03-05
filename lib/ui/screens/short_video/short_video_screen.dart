import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/initializers/dependencies_initializer.dart';
import '../dashboard/cubit/dashboard_screen_cubit.dart';
import '../dashboard/cubit/dashboard_screen_state.dart';
import '../dashboard/dashboard_screen_tab.dart';
import 'cubit/short_video_screen_cubit.dart';
import 'cubit/short_video_screen_state.dart';
import 'widgets/video_player_item.dart';

class ShortVideoScreen extends StatelessWidget {
  final int initialIndex;

  const ShortVideoScreen({super.key, this.initialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShortVideoScreenCubit(
        videoRepository: getIt(),
        history1Repository: getIt(),
        watchHistoryRepository: getIt(),
      ),
      child: _ShortVideoView(initialIndex: initialIndex),
    );
  }
}

class _ShortVideoView extends StatefulWidget {
  final int initialIndex;

  const _ShortVideoView({this.initialIndex = 0});

  @override
  State<_ShortVideoView> createState() => _ShortVideoViewState();
}

class _ShortVideoViewState extends State<_ShortVideoView> {
  late final PageController _pageController;
  late final ShortVideoScreenCubit _cubit;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ShortVideoScreenCubit>();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _cubit.loadVideos();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashboardScreenCubit, DashboardScreenState, DashboardScreenTab>(
      selector: (state) => state.selectedTab,
      builder: (context, selectedTab) {
        final isShortsTabSelected = selectedTab == DashboardScreenTab.shortVideo;

        return Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<ShortVideoScreenCubit, ShortVideoScreenState>(
            builder: (context, state) {
              if (state.status == ShortVideoScreenStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == ShortVideoScreenStatus.failure) {
                return Center(
                  child: Text(
                    state.error?.message ?? 'Something went wrong',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              } else if (state.status == ShortVideoScreenStatus.ready) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemCount: state.videos.length,
                  onPageChanged: (index) {
                    // Record the previously watched video before moving to next
                    final previousVideo = state.videos[_currentIndex];
                    _cubit.recordWatched(previousVideo);

                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final video = state.videos[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        VideoPlayerItem(
                          videoUrl: video.url,
                          isVisible: index == _currentIndex && isShortsTabSelected,
                        ),
                        // Overlay for Caption
                        Positioned(
                          bottom: 40,
                          left: 20,
                          right: 20,
                          child: Text(
                            video.caption,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
