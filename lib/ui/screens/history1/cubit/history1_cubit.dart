import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/history1_model.dart';
import '../../../../domain/core/result.dart';
import '../../../../domain/repositories/history1_repository.dart';
import 'history1_state.dart';

class History1Cubit extends Cubit<History1State> {
  final History1Repository _repository;

  History1Cubit(this._repository) : super(const History1State());

  Future<void> loadHistory() async {
    emit(state.copyWith(status: History1Status.loading));
    final result = await _repository.getHistory1();

    if (result is Success<List<History1Model>>) {
      emit(
        state.copyWith(
          status: History1Status.ready,
          items: result.value,
        ),
      );
    } else if (result is Failure<List<History1Model>>) {
      emit(
        state.copyWith(
          status: History1Status.failure,
          error: result.error,
        ),
      );
    }
  }

  void toggleEditMode() {
    emit(
      state.copyWith(
        isEditMode: !state.isEditMode,
        selectedIds: {},
      ),
    );
  }

  void toggleSelection(String id) {
    final selectedIds = Set<String>.from(state.selectedIds);
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    emit(state.copyWith(selectedIds: selectedIds));
  }

  void selectAll() {
    final allIds = state.items.map((e) => e.id).toSet();
    emit(state.copyWith(selectedIds: allIds));
  }

  void deselectAll() {
    emit(state.copyWith(selectedIds: {}));
  }

  Future<void> deleteSelected() async {
    if (state.selectedIds.isEmpty) return;

    emit(state.copyWith(status: History1Status.loading));
    final result = await _repository.deleteHistory1(state.selectedIds);

    if (result is Success<Unit>) {
      final remainingItems = state.items.where((e) => !state.selectedIds.contains(e.id)).toList();
      emit(
        state.copyWith(
          status: History1Status.ready,
          items: remainingItems,
          selectedIds: {},
          isEditMode: remainingItems.isNotEmpty ? state.isEditMode : false,
        ),
      );
    } else if (result is Failure<Unit>) {
      emit(
        state.copyWith(
          status: History1Status.failure,
          error: result.error,
        ),
      );
    }
  }
}
