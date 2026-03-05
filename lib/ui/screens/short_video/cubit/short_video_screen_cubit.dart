import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/history1_model.dart';
import '../../../../data/models/video_model.dart';
import '../../../../data/models/watch_history_model.dart';
import '../../../../domain/core/app_error.dart';
import '../../../../domain/repositories/history1_repository.dart';
import '../../../../domain/repositories/video_repository.dart';
import '../../../../domain/repositories/watch_history_repository.dart';
import 'short_video_screen_state.dart';

class ShortVideoScreenCubit extends Cubit<ShortVideoScreenState> {
  final VideoRepository _videoRepository;
  final History1Repository _history1Repository;
  final WatchHistoryRepository _watchHistoryRepository;

  ShortVideoScreenCubit({
    required VideoRepository videoRepository,
    required History1Repository history1Repository,
    required WatchHistoryRepository watchHistoryRepository,
  }) : _videoRepository = videoRepository,
       _history1Repository = history1Repository,
       _watchHistoryRepository = watchHistoryRepository,
       super(const ShortVideoScreenState());

  Future<void> loadVideos() async {
    emit(state.loading());
    try {
      final videos = await _videoRepository.getShortVideos();
      emit(state.ready(videos));
    } catch (e) {
      emit(state.failure(AppError(message: e.toString())));
    }
  }

  /// Call this when a video has been watched (e.g. user swipes to next video).
  /// Saves the watched video into both History1 and WatchHistory local storage.
  Future<void> recordWatched(VideoModel video) async {
    final now = DateTime.now();

    final h1Item = History1Model(
      id: video.id,
      title: video.title,
      prefixTitle: '',
      suffixTitle: '',
      subtitle: video.category,
      genre: video.category,
      imageUrl: video.thumbnail,
      timestamp: _relativeTimestamp(now),
      date: now,
    );

    final h2Item = WatchHistoryModel(
      id: video.id,
      title: video.title,
      prefixTitle: '',
      suffixTitle: '',
      subtitle: video.category,
      genre: video.category,
      imageUrl: video.thumbnail,
      timestamp: _relativeTimestamp(now),
      date: now,
    );

    await Future.wait([
      _history1Repository.addToHistory1(h1Item),
      _watchHistoryRepository.addToWatchHistory(h2Item),
    ]);
  }

  String _relativeTimestamp(DateTime now) {
    final hour = now.hour;
    if (hour < 12) return 'ดูเมื่อเช้านี้';
    if (hour < 17) return 'ดูเมื่อช่วงบ่าย';
    return 'ดูเมื่อ $hour:${now.minute.toString().padLeft(2, '0')} น.';
  }
}
