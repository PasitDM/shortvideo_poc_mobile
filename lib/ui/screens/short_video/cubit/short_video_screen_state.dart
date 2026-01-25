import 'package:equatable/equatable.dart';

import '../../../../data/models/video_model.dart';
import '../../../../domain/core/app_error.dart';

enum ShortVideoScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == ShortVideoScreenStatus.loading;
}

class ShortVideoScreenState extends Equatable {
  final ShortVideoScreenStatus status;
  final List<VideoModel> videos;
  final AppError? error;

  const ShortVideoScreenState({
    this.status = ShortVideoScreenStatus.initial,
    this.videos = const [],
    this.error,
  });

  @override
  List<Object?> get props => [status, videos, error];

  ShortVideoScreenState copyWith({
    ShortVideoScreenStatus? status,
    List<VideoModel>? videos,
    AppError? error,
  }) {
    return ShortVideoScreenState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      error: error ?? this.error,
    );
  }

  ShortVideoScreenState loading() {
    return copyWith(status: ShortVideoScreenStatus.loading);
  }

  ShortVideoScreenState ready(List<VideoModel> videos) {
    return copyWith(
      status: ShortVideoScreenStatus.ready,
      videos: videos,
    );
  }

  ShortVideoScreenState failure(AppError error) {
    return copyWith(status: ShortVideoScreenStatus.failure, error: error);
  }
}
