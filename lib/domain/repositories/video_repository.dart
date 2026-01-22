import 'package:app_template/data/models/video_model.dart';

abstract interface class VideoRepository {
  Future<List<VideoModel>> getShortVideos();
}
