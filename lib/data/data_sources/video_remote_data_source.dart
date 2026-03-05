import '../../domain/api_client/api_client.dart';
import '../models/video_model.dart';

class VideoRemoteDataSource {
  final ApiClient _apiClient;

  const VideoRemoteDataSource(this._apiClient);

  Future<List<VideoModel>> getShortVideos() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // ignore: unused_local_variable
    final _ = _apiClient; // placeholder until API is live

    final urls = [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://hwztvideo.dramaboxdb.com/83/8x2/82x3/823x2/82322100014/601816738_1/601816738.1080p.wz.g264.mp4?Expires=1765882800&Signature=xA37ngWl1PPuMyueNRz3Ld3Dki4cl-VytiHbT1MTEg2LzCci7I~QbHp9MHk9l7tX5yhdrH6RIYzm5orMI1N1JXyo1npfdsx6U3OnSZTR9jNGVBBgM3gtZRewxM8tUUMVw-jBhS5hdOxJVkXKTkcH6e~zd1RUjDk47ryqOpDuy-4Jdz0yJ3PZWDGcSeM~Y-s720Nlsix0i3ZDaA9bccxNt4Swe4Bnxatfmhkqwu-4t5YuKQLLN06aKqPX5~C-d8Pmb3yw9brB-sopErlgegG7WZIrUUxOU8Br7aDpzOV65dw6FTplhXpzKX9AtIeg2ZlAcOjOgvfyayv60hfj8J~ZcQ__&Key-Pair-Id=K3HA2TLE2QH99V',
    ];

    return [
      VideoModel(
        id: 'video_1',
        url: urls[0],
        caption: 'Funny Bee Video',
        thumbnail: 'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
        title: 'Divorced at the Wedding Day',
        views: '329M',
        category: 'Revenge',
        badge: 'Hot',
      ),
      VideoModel(
        id: 'video_2',
        url: urls[1],
        caption: 'Dramabox Content',
        thumbnail: 'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
        title: 'My Poor Husband is A Billionaire',
        views: '130M',
        category: 'Mistaken Identity',
        badge: 'Members Only',
      ),
      VideoModel(
        id: 'video_3',
        url: urls[0],
        caption: 'Another Bee Video',
        thumbnail: 'https://iso.500px.com/wp-content/uploads/2016/03/stock-photo-142984111.jpg',
        title: 'The Lost Heir: A Christmas Reckoning',
        views: '15.8M',
        category: 'Revenge',
        badge: 'Hot',
      ),
      VideoModel(
        id: 'video_4',
        url: urls[0],
        caption: 'Bee again',
        thumbnail: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
        title: 'Bound by Blood: The Mafia King\'s Sweetheart',
        views: '33.3M',
        category: 'Mafia',
        badge: 'Exclusive',
      ),
      VideoModel(
        id: 'video_5',
        url: urls[0],
        caption: 'Bee Bee',
        thumbnail: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
        title: 'Glory on the Line: The Taste of Triumph',
        views: '50.2M',
        category: 'Redemption',
        badge: 'Exclusive',
      ),
      VideoModel(
        id: 'video_6',
        url: urls[0],
        caption: 'Final Bee',
        thumbnail: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400',
        title: 'Badass Heiress Returns',
        views: '20.1M',
        category: 'Revenge',
        badge: 'Exclusive',
      ),
      VideoModel(
        id: 'video_7',
        url: urls[0],
        caption: 'Romance Series',
        thumbnail: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
        title: 'หัวใจวุ่นวายของนายข้างห้อง',
        views: '88.4M',
        category: 'โรแมนติก',
        badge: 'Hot',
      ),
      VideoModel(
        id: 'video_8',
        url: urls[0],
        caption: 'Thriller Series',
        thumbnail: 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400',
        title: 'The Secret Billionaire\'s Baby',
        views: '102M',
        category: 'Thriller',
        badge: 'Hot',
      ),
      VideoModel(
        id: 'video_9',
        url: urls[0],
        caption: 'Action Series',
        thumbnail: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
        title: 'Dragon King\'s Beloved',
        views: '75.5M',
        category: 'Action',
        badge: 'Members Only',
      ),
      VideoModel(
        id: 'video_10',
        url: urls[0],
        caption: 'Heartwarming Story',
        thumbnail: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
        title: 'The CEO\'s Secret Wife',
        views: '210M',
        category: 'Romance',
        badge: 'Exclusive',
      ),
    ];
  }
}
