import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/core/result.dart';
import '../../../../domain/repositories/watch_history_repository.dart';
import 'history_2_state.dart';

class History2ScreenCubit extends Cubit<History2ScreenState> {
  final WatchHistoryRepository _repository;

  History2ScreenCubit({
    required WatchHistoryRepository repository,
  }) : _repository = repository,
       super(const History2ScreenState());

  Future<void> initialize() async {
    emit(state.loading());
    final result = await _repository.getWatchHistory();
    switch (result) {
      case Success(:final value):
        emit(state.success(value));
      case Failure(:final error):
        emit(state.failure(error.message ?? 'Unknown error'));
    }
  }

  void toggleEditMode() {
    emit(
      state.copyWith(
        isEditMode: !state.isEditMode,
        selectedItemIds: {},
      ),
    );
  }

  void toggleItemSelection(String id) {
    final newSelection = Set<String>.from(state.selectedItemIds);
    if (newSelection.contains(id)) {
      newSelection.remove(id);
    } else {
      newSelection.add(id);
    }
    emit(state.copyWith(selectedItemIds: newSelection));
  }

  void selectAll() {
    final allIds = state.items.map((e) => e.id).toSet();
    final allSelected = state.selectedItemIds.length == state.items.length;
    emit(
      state.copyWith(
        selectedItemIds: allSelected ? {} : allIds,
      ),
    );
  }

  Future<void> deleteSelectedItems() async {
    if (state.selectedItemIds.isEmpty) return;

    emit(state.loading());
    final result = await _repository.deleteWatchHistory(state.selectedItemIds);
    switch (result) {
      case Success():
        final fetchResult = await _repository.getWatchHistory();
        switch (fetchResult) {
          case Success(:final value):
            emit(
              state
                  .success(value)
                  .copyWith(
                    isEditMode: false,
                    selectedItemIds: {},
                  ),
            );
          case Failure(:final error):
            emit(state.failure(error.message ?? 'Unknown error'));
        }
      case Failure(:final error):
        emit(state.failure(error.message ?? 'Unknown error'));
    }
  }
}
