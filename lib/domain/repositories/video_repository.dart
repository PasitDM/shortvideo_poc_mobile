import '../../data/models/video_model.dart';

abstract interface class VideoRepository {
  Future<List<VideoModel>> getShortVideos();
}
