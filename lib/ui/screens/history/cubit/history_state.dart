import 'package:equatable/equatable.dart';

import '../data/history_model.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryModel> items;
  final bool isEditMode;
  final Set<String> selectedItemIds;

  const HistoryLoaded({
    required this.items,
    this.isEditMode = false,
    this.selectedItemIds = const {},
  });

  HistoryLoaded copyWith({
    List<HistoryModel>? items,
    bool? isEditMode,
    Set<String>? selectedItemIds,
  }) {
    return HistoryLoaded(
      items: items ?? this.items,
      isEditMode: isEditMode ?? this.isEditMode,
      selectedItemIds: selectedItemIds ?? this.selectedItemIds,
    );
  }

  @override
  List<Object?> get props => [items, isEditMode, selectedItemIds];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
