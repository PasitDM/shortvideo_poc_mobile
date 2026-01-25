import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/core/app_error.dart';
import '../../../../domain/repositories/video_repository.dart';
import 'short_video_screen_state.dart';

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
