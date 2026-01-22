class VideoModel {
  final String id;
  final String url;
  final String caption;
  final String thumbnail;
  final String title;
  final String views;
  final String category;
  final String? badge; // 'Hot', 'Exclusive', 'Members Only'

  VideoModel({
    required this.id,
    required this.url,
    required this.caption,
    required this.thumbnail,
    required this.title,
    required this.views,
    required this.category,
    this.badge,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String,
      url: json['url'] as String,
      caption: json['caption'] as String,
      thumbnail: json['thumbnail'] as String,
      title: json['title'] as String,
      views: json['views'] as String,
      category: json['category'] as String,
      badge: json['badge'] as String?,
    );
  }
}
