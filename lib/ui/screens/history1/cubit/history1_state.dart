import 'package:equatable/equatable.dart';

import '../../../../data/models/history1_model.dart';
import '../../../../domain/core/app_error.dart';

enum History1Status { initial, loading, ready, failure }

class History1State extends Equatable {
  final History1Status status;
  final List<History1Model> items;
  final Set<String> selectedIds;
  final bool isEditMode;
  final AppError? error;

  const History1State({
    this.status = History1Status.initial,
    this.items = const [],
    this.selectedIds = const {},
    this.isEditMode = false,
    this.error,
  });

  History1State copyWith({
    History1Status? status,
    List<History1Model>? items,
    Set<String>? selectedIds,
    bool? isEditMode,
    AppError? error,
  }) {
    return History1State(
      status: status ?? this.status,
      items: items ?? this.items,
      selectedIds: selectedIds ?? this.selectedIds,
      isEditMode: isEditMode ?? this.isEditMode,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, items, selectedIds, isEditMode, error];
}
