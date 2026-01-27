import 'package:equatable/equatable.dart';

import '../../../../data/models/video_model.dart';
import '../../../../domain/core/app_error.dart';

enum HomeScreenStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == HomeScreenStatus.loading;
}

class HomeScreenState extends Equatable {
  final HomeScreenStatus status;
  final List<VideoModel> videos;
  final int focusedIndex;
  final AppError? error;

  const HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.videos = const [],
    this.focusedIndex = 0,
    this.error,
  });

  @override
  List<Object?> get props => [status, videos, focusedIndex, error];

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    List<VideoModel>? videos,
    int? focusedIndex,
    AppError? error,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      videos: videos ?? this.videos,
      focusedIndex: focusedIndex ?? this.focusedIndex,
      error: error ?? this.error,
    );
  }

  HomeScreenState loading() {
    return copyWith(status: HomeScreenStatus.loading);
  }

  HomeScreenState ready(List<VideoModel> videos) {
    return copyWith(
      status: HomeScreenStatus.ready,
      videos: videos,
    );
  }

  HomeScreenState failure(AppError error) {
    return copyWith(status: HomeScreenStatus.failure, error: error);
  }
}
