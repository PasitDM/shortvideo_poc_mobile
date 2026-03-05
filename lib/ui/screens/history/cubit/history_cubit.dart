import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/history_model.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  void fetchHistory() async {
    emit(HistoryLoading());
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock Data
    final now = DateTime.now();
    final mockData = [
      HistoryModel(
        id: '1',
        title: 'หัวใจวุ่นวายของนายข้างห้อง',
        prefixTitle: 'ของฉัน',
        suffixTitle: 'คือเธอ',
        subtitle: 'EP.2 / EP.35',
        genre: 'โรแมนติก',
        imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
        timestamp: 'ดูเมื่อ 19 ชั่วโมง',
        date: now, // Today
      ),
      HistoryModel(
        id: '2',
        title: 'หัวใจวุ่นวายของนายข้างห้อง',
        prefixTitle: 'ของฉัน',
        suffixTitle: 'คือเธอ',
        subtitle: 'EP.2 / EP.35',
        genre: 'โรแมนติก',
        imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9',
        timestamp: 'ดูเมื่อ 1 วันก่อน',
        date: now.subtract(const Duration(days: 1)), // Yesterday
      ),
      HistoryModel(
        id: '3',
        title: 'หัวใจวุ่นวายของนายข้างห้อง',
        prefixTitle: 'ของฉัน',
        suffixTitle: 'คือเธอ',
        subtitle: 'EP.2 / EP.35',
        genre: 'โรแมนติก',
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
        timestamp: 'ดูเมื่อ 1 วันก่อน',
        date: now.subtract(const Duration(days: 1)), // Yesterday
      ),
      HistoryModel(
        id: '4',
        title: 'หัวใจวุ่นวายของนายข้างห้อง',
        prefixTitle: 'ของฉัน',
        suffixTitle: 'คือเธอ',
        subtitle: 'EP.2 / EP.35',
        genre: 'โรแมนติก',
        imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
        timestamp: 'ดูเมื่อ 1 สัปดาห์ก่อน',
        date: now.subtract(const Duration(days: 7)), // Older
      ),
      HistoryModel(
        id: '5',
        title: 'หัวใจวุ่นวายของนายข้างห้อง',
        prefixTitle: 'ของฉัน',
        suffixTitle: 'คือเธอ',
        subtitle: 'EP.2 / EP.35',
        genre: 'โรแมนติก',
        imageUrl: 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04',
        timestamp: 'ดูเมื่อ 1 เดือนก่อน',
        date: now.subtract(const Duration(days: 30)), // Older
      ),
    ];

    emit(HistoryLoaded(items: mockData));
  }

  void toggleEditMode() {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      emit(
        currentState.copyWith(
          isEditMode: !currentState.isEditMode,
          selectedItemIds: {}, // Clear selection when toggling
        ),
      );
    }
  }

  void toggleItemSelection(String id) {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      final newSelection = Set<String>.from(currentState.selectedItemIds);
      if (newSelection.contains(id)) {
        newSelection.remove(id);
      } else {
        newSelection.add(id);
      }
      emit(currentState.copyWith(selectedItemIds: newSelection));
    }
  }

  void toggleSelectAllGroup(List<HistoryModel> groupItems, bool selectAll) {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      final newSelection = Set<String>.from(currentState.selectedItemIds);

      for (var item in groupItems) {
        if (selectAll) {
          newSelection.add(item.id);
        } else {
          newSelection.remove(item.id);
        }
      }

      emit(currentState.copyWith(selectedItemIds: newSelection));
    }
  }

  void deleteSelectedItems() {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      final newItems = currentState.items.where((item) => !currentState.selectedItemIds.contains(item.id)).toList();

      emit(
        currentState.copyWith(
          items: newItems,
          isEditMode: false,
          selectedItemIds: {},
        ),
      );
    }
  }
}
