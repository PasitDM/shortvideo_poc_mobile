import 'package:app_template/data/models/video_model.dart';
import 'package:app_template/domain/api_client/api_client.dart';

class VideoRemoteDataSource {
  final ApiClient _apiClient;

  const VideoRemoteDataSource(this._apiClient);

  Future<List<VideoModel>> getShortVideos() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final urls = [
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'https://hwztvideo.dramaboxdb.com/83/8x2/82x3/823x2/82322100014/601816738_1/601816738.1080p.wz.g264.mp4?Expires=1765882800&Signature=xA37ngWl1PPuMyueNRz3Ld3Dki4cl-VytiHbT1MTEg2LzCci7I~QbHp9MHk9l7tX5yhdrH6RIYzm5orMI1N1JXyo1npfdsx6U3OnSZTR9jNGVBBgM3gtZRewxM8tUUMVw-jBhS5hdOxJVkXKTkcH6e~zd1RUjDk47ryqOpDuy-4Jdz0yJ3PZWDGcSeM~Y-s720Nlsix0i3ZDaA9bccxNt4Swe4Bnxatfmhkqwu-4t5YuKQLLN06aKqPX5~C-d8Pmb3yw9brB-sopErlgegG7WZIrUUxOU8Br7aDpzOV65dw6FTplhXpzKX9AtIeg2ZlAcOjOgvfyayv60hfj8J~ZcQ__&Key-Pair-Id=K3HA2TLE2QH99V',
    ];

    final mockData = [
      VideoModel(
        id: 'video_1',
        url: urls[0],
        caption: 'Funny Bee Video',
        thumbnail:
            'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg',
        title: 'Divorced at the Wedding Day',
        views: '329M',
        category: 'Revenge',
        badge: 'Hot',
      ),
      VideoModel(
        id: 'video_2',
        url: urls[1],
        caption: 'Dramabox Content',
        thumbnail:
            'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
        title: 'My Poor Husband is A Billionaire',
        views: '130M',
        category: 'Mistaken Identity',
        badge: 'Members Only',
      ),
      VideoModel(
        id: 'video_3',
        url: urls[0],
        caption: 'Another Bee Video',
        thumbnail:
            'https://iso.500px.com/wp-content/uploads/2016/03/stock-photo-142984111.jpg',
        title: 'The Lost Heir: A Christmas Reckoning',
        views: '15.8M',
        category: 'Revenge',
        badge: 'Hot',
      ),
      VideoModel(
        id: 'video_4',
        url: urls[0],
        caption: 'Bee again',
        thumbnail:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Aca9G82h0eJBy8BsqaZ-D8Aci8x70Z6_Lw&s',
        title: 'Bound by Blood: The Mafia King\'s Sweetheart',
        views: '33.3M',
        category: 'Mafia',
        badge: 'Exclusive',
      ),
      VideoModel(
        id: 'video_5',
        url: urls[0],
        caption: 'Bee Bee',
        thumbnail:
            'https://img.freepik.com/free-photo/standing-young-man-isolated-yellow_171337-16474.jpg',
        title: 'Glory on the Line: The Taste of Triumph',
        views: '50.2M',
        category: 'Redemption',
        badge: 'Exclusive',
      ),
      VideoModel(
        id: 'video_6',
        url: urls[0],
        caption: 'Final Bee',
        thumbnail:
            'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
        title: 'Badass Heiress Returns',
        views: '20.1M',
        category: 'Revenge',
        badge: 'Exclusive',
      ),
    ];

    return mockData;
  }
}
