import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/logger.dart';
import '../../../data/models/video_model.dart';
import 'cubit/home_screen_cubit.dart';
import 'cubit/home_screen_state.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().loadVideos();
  }

  // void _onPageChanged(int index) {
  //   context.read<HomeScreenCubit>().updateFocusedIndex(index);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          return const Center(child: Text('Home'));
          // if (state.status.isLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          // if (state.videos.isEmpty) {
          //   return const Center(
          //     child: Text('No Videos', style: TextStyle(color: Colors.white)),
          //   );
          // }

          // return PageView.builder(
          //   scrollDirection: Axis.vertical,
          //   itemCount: state.videos.length,
          //   onPageChanged: _onPageChanged,
          //   itemBuilder: (context, index) {
          //     return _VideoPostItem(
          //       video: state.videos[index],
          //       isFocused: index == state.focusedIndex,
          //     );
          //   },
          // );
        },
      ),
    );
  }
}

class _VideoPostItem extends StatefulWidget {
  final VideoModel video;
  final bool isFocused;

  const _VideoPostItem({
    required this.video,
    required this.isFocused,
  });

  @override
  State<_VideoPostItem> createState() => _VideoPostItemState();
}

class _VideoPostItemState extends State<_VideoPostItem> {
  BetterPlayerController? _betterPlayerController;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    if (widget.isFocused) {
      _initializePlayer(fromInit: true);
    }
  }

  @override
  void didUpdateWidget(covariant _VideoPostItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFocused && !oldWidget.isFocused) {
      _initializePlayer();
    } else if (!widget.isFocused && oldWidget.isFocused) {
      _disposePlayer();
    }
  }

  void _initializePlayer({bool fromInit = false}) {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 9 / 16,
      fit: BoxFit.cover,
      autoPlay: true,
      looping: true,
      handleLifecycle: true,
      placeholder: Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.purple),
        ),
      ),
      controlsConfiguration: const BetterPlayerControlsConfiguration(
        showControls: false,
        showControlsOnInitialize: false,
      ),
    );

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.url,
      cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: false),
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController?.addEventsListener((event) {
      Logger.debug.log('BetterPlayer Event: ${event.betterPlayerEventType}');
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        if (mounted) setState(() {});
      }
    });

    _betterPlayerController
        ?.setupDataSource(dataSource)
        .then((_) {
          if (mounted) {
            setState(() {});
          }
        })
        .catchError((error) {
          Logger.debug.log('BetterPlayer Setup Error: $error');
          if (mounted) setState(() {});
        });

    if (!fromInit && mounted) {
      setState(() {});
    }
  }

  void _disposePlayer({bool fromDispose = false}) {
    _betterPlayerController?.dispose();
    _betterPlayerController = null;
    if (!fromDispose && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _disposePlayer(fromDispose: true);
    super.dispose();
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CommentBottomSheet(),
    );
  }

  void _showProfileBottomSheet() {
    _betterPlayerController?.pause();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ProfileBottomSheet(),
    ).then((_) {
      if (mounted && widget.isFocused) {
        _betterPlayerController?.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video Player or Thumbnail
        Positioned.fill(
          child: _betterPlayerController != null
              ? BetterPlayer(controller: _betterPlayerController!)
              : Container(
                  color: Colors.black,
                  child: widget.video.thumbnail.isNotEmpty
                      ? Image.network(widget.video.thumbnail, fit: BoxFit.cover)
                      : const Center(
                          child: Icon(Icons.play_circle_outline, color: Colors.white54, size: 64),
                        ),
                ),
        ),

        // Gradient Overlay (Bottom)
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
                stops: [0.6, 1.0],
              ),
            ),
          ),
        ),

        // Right Side Actions
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              _buildActionItem(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                label: '12.5K',
                color: _isLiked ? Colors.red : Colors.white,
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildActionItem(
                icon: Icons.comment,
                label: '123',
                color: Colors.white,
                onTap: _showComments,
              ),
              const SizedBox(height: 20),
              _buildActionItem(
                icon: Icons.bookmark,
                label: 'Favorites',
                color: Colors.white,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _buildActionItem(
                icon: Icons.share,
                label: 'Share',
                color: Colors.white,
                onTap: () {},
              ),
              const SizedBox(height: 40),
              _buildvinylDisk(),
            ],
          ),
        ),

        // Bottom Info
        Positioned(
          left: 16,
          bottom: 20,
          right: 80, // Leave space for right actions
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use Title as Channel Name
              GestureDetector(
                onTap: _showProfileBottomSheet,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey,
                      backgroundImage: widget.video.thumbnail.isNotEmpty ? NetworkImage(widget.video.thumbnail) : null,
                      child: widget.video.thumbnail.isEmpty ? const Icon(Icons.person, size: 16, color: Colors.white) : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.video.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Follow', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.video.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.music_note, size: 14, color: Colors.white),
                  SizedBox(width: 4),
                  Text('Original Sound - Nature', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),

        // Progress Bar (Bottom)
        if (_betterPlayerController != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _VideoProgressBar(controller: _betterPlayerController!),
          ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildvinylDisk() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 8),
      ),
      child: const Center(
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.red,
          child: Icon(Icons.music_note, size: 10, color: Colors.white),
        ),
      ),
    );
  }
}

class _VideoProgressBar extends StatefulWidget {
  final BetterPlayerController controller;

  const _VideoProgressBar({required this.controller});

  @override
  State<_VideoProgressBar> createState() => _VideoProgressBarState();
}

class _VideoProgressBarState extends State<_VideoProgressBar> {
  double _progress = 0.0;
  VoidCallback? _listener;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (_isDragging) return;
      final value = widget.controller.videoPlayerController?.value;
      final duration = value?.duration?.inMilliseconds ?? 0;
      if (value != null && value.initialized && duration > 0) {
        final percent = value.position.inMilliseconds / duration;
        if (mounted) {
          setState(() {
            _progress = percent.clamp(0.0, 1.0);
          });
        }
      }
    };
    widget.controller.videoPlayerController?.addListener(_listener!);
  }

  void _seek(Offset localPosition, double width) {
    final value = widget.controller.videoPlayerController?.value;
    final duration = value?.duration?.inMilliseconds ?? 0;
    if (value != null && value.initialized && duration > 0) {
      final percent = (localPosition.dx / width).clamp(0.0, 1.0);
      setState(() {
        _progress = percent;
      });
      final seekTo = duration * percent;
      widget.controller.seekTo(Duration(milliseconds: seekTo.toInt()));
    }
  }

  @override
  void dispose() {
    if (_listener != null) {
      widget.controller.videoPlayerController?.removeListener(_listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (details) {
            setState(() => _isDragging = true);
            _seek(details.localPosition, width);
          },
          onHorizontalDragUpdate: (details) => _seek(details.localPosition, width),
          onHorizontalDragEnd: (details) => setState(() => _isDragging = false),
          onTapDown: (details) => _seek(details.localPosition, width),
          child: Container(
            color: Colors.transparent, // Expand hit area
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: _isDragging ? 4 : 2,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class _CommentBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                const Text(
                  '123 comments',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),

          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _CommentItem(index: index),
                );
              },
            ),
          ),

          // Input
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C),
              border: Border(top: BorderSide(color: Colors.white12)),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 20, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Add comment...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.send, color: Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final int index;

  const _CommentItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User $index',
                style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                'Reply',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
        const Column(
          children: [
            Icon(Icons.favorite_border, color: Colors.white54, size: 20),
            Text('2', style: TextStyle(color: Colors.white54, fontSize: 10)),
          ],
        ),
      ],
    );
  }
}

class _ProfileBottomSheet extends StatelessWidget {
  const _ProfileBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Jenny Wilson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '@jenny_wilson',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Actress & Singer',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                    ),
                    child: const Text('Follow', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 32),
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('679', 'Posts'),
                      _buildVerticalDivider(),
                      _buildStat('2.6M', 'Followers'),
                      _buildVerticalDivider(),
                      _buildStat('648', 'Following'),
                      _buildVerticalDivider(),
                      _buildStat('245', 'Liked'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Tabs
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ProfileTab(title: 'Your posts', isActive: true),
                        _ProfileTab(title: 'Following', isActive: false),
                        _ProfileTab(title: 'Saved', isActive: false),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  // Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1517841905240-472988babdf9'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Row(
                                children: [
                                  const Icon(Icons.play_arrow, color: Colors.white, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${(index + 1) * 10}k',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white12,
    );
  }
}

class _ProfileTab extends StatelessWidget {
  final String title;
  final bool isActive;

  const _ProfileTab({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 12),
        if (isActive)
          Container(
            height: 2,
            width: 80,
            color: Colors.purple,
          ),
      ],
    );
  }
}
