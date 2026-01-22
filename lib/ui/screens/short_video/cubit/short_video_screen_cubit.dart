import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/repositories/video_repository.dart';
import 'package:app_template/ui/screens/short_video/cubit/short_video_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShortVideoScreenCubit extends Cubit<ShortVideoScreenState> {
  final VideoRepository _videoRepository;

  ShortVideoScreenCubit({required VideoRepository videoRepository})
    : _videoRepository = videoRepository,
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
}
