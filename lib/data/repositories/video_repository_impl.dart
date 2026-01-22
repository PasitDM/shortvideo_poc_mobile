import 'package:app_template/data/data_sources/video_remote_data_source.dart';
import 'package:app_template/data/models/video_model.dart';
import 'package:app_template/domain/repositories/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource _remoteDataSource;

  VideoRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<VideoModel>> getShortVideos() async {
    return _remoteDataSource.getShortVideos();
  }
}
