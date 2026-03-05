import 'package:equatable/equatable.dart';

import '../../../../data/models/watch_history_model.dart';

enum History2ScreenStatus { initial, loading, ready, failure }

class History2ScreenState extends Equatable {
  final History2ScreenStatus status;
  final List<WatchHistoryModel> items;
  final bool isEditMode;
  final Set<String> selectedItemIds;
  final String? errorMessage;

  const History2ScreenState({
    this.status = History2ScreenStatus.initial,
    this.items = const [],
    this.isEditMode = false,
    this.selectedItemIds = const {},
    this.errorMessage,
  });

  History2ScreenState loading() => copyWith(status: History2ScreenStatus.loading);

  History2ScreenState success(List<WatchHistoryModel> data) => copyWith(
    status: History2ScreenStatus.ready,
    items: data,
  );

  History2ScreenState failure(String message) => copyWith(
    status: History2ScreenStatus.failure,
    errorMessage: message,
  );

  History2ScreenState copyWith({
    History2ScreenStatus? status,
    List<WatchHistoryModel>? items,
    bool? isEditMode,
    Set<String>? selectedItemIds,
    String? errorMessage,
  }) {
    return History2ScreenState(
      status: status ?? this.status,
      items: items ?? this.items,
      isEditMode: isEditMode ?? this.isEditMode,
      selectedItemIds: selectedItemIds ?? this.selectedItemIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    isEditMode,
    selectedItemIds,
    errorMessage,
  ];
}
