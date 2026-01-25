import '../../domain/repositories/video_repository.dart';
import '../data_sources/video_remote_data_source.dart';
import '../models/video_model.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource _remoteDataSource;

  VideoRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VideoModel>> getShortVideos() async {
    return _remoteDataSource.getShortVideos();
  }
}
