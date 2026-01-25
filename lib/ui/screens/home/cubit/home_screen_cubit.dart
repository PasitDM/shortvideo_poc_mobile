import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/video_model.dart';
import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState());

  void loadVideos() async {
    emit(state.loading());
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock Data
    final videos = [
      VideoModel(
        id: '1',
        url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        caption: 'Beautiful Butterfly #nature #flutter',
        thumbnail: '',
        title: 'Nature World', // Channel Name
        views: '1.2M',
        category: 'Nature',
        badge: 'Official',
      ),
      VideoModel(
        id: '2',
      url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        caption: 'Buzzing Bee 🐝 #bee #honey',
        thumbnail: '',
        title: 'Insect Life',
        views: '500K',
        category: 'Animals',
      ),
    ];

    emit(state.ready(videos));
  }
}
