import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final String id;
  final String title;
  final String prefixTitle;
  final String suffixTitle;
  final String subtitle;
  final String genre;
  final String imageUrl;
  final String timestamp;
  final DateTime date;

  const HistoryModel({
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
