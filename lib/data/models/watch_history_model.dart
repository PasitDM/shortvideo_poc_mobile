import 'package:equatable/equatable.dart';

class WatchHistoryModel extends Equatable {
  final String id;
  final String title;
  final String prefixTitle;
  final String suffixTitle;
  final String subtitle;
  final String genre;
  final String imageUrl;
  final String timestamp;
  final DateTime date;

  const WatchHistoryModel({
    required this.id,
    required this.title,
    required this.prefixTitle,
    required this.suffixTitle,
    required this.subtitle,
    required this.genre,
    required this.imageUrl,
    required this.timestamp,
    required this.date,
  });

  factory WatchHistoryModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      prefixTitle: json['prefixTitle'] as String? ?? '',
      suffixTitle: json['suffixTitle'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date'] as String) ?? DateTime.now() : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'prefixTitle': prefixTitle,
    'suffixTitle': suffixTitle,
    'subtitle': subtitle,
    'genre': genre,
    'imageUrl': imageUrl,
    'timestamp': timestamp,
    'date': date.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    id,
    title,
    prefixTitle,
    suffixTitle,
    subtitle,
    genre,
    imageUrl,
    timestamp,
    date,
  ];
}
