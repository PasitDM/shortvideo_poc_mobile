import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.videos.isEmpty) {
            return const Center(
              child: Text('No Videos', style: TextStyle(color: Colors.white)),
            );
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.videos.length,
            itemBuilder: (context, index) {
              return _VideoPostItem(video: state.videos[index]);
            },
          );
        },
      ),
    );
  }
}

class _VideoPostItem extends StatefulWidget {
  final VideoModel video;

  const _VideoPostItem({required this.video});

  @override
  State<_VideoPostItem> createState() => _VideoPostItemState();
}

class _VideoPostItemState extends State<_VideoPostItem> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 9 / 16,
      fit: BoxFit.cover,
      autoPlay: true,
      looping: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControls: false,
        showControlsOnInitialize: false,
      ),
    );

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.url,
      cacheConfiguration: const BetterPlayerCacheConfiguration(useCache: true),
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Video Player
        Positioned.fill(
          child: BetterPlayer(controller: _betterPlayerController),
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
              _buildActionItem(Icons.favorite, '12.5K', Colors.red),
              const SizedBox(height: 20),
              _buildActionItem(Icons.comment, '123', Colors.white),
              const SizedBox(height: 20),
              _buildActionItem(Icons.bookmark, 'Favorites', Colors.white),
              const SizedBox(height: 20),
              _buildActionItem(Icons.share, 'Share', Colors.white),
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
              Row(
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
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 32, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
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
