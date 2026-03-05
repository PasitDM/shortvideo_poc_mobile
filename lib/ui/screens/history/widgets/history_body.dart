import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../styles/index.dart';
import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';
import '../data/history_model.dart';
import 'history_item.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryLoaded) {
          if (state.items.isEmpty) {
            return Center(
              child: Text('ไม่มีประวัติการรับชม', style: AppTextStyle.body1Medium.copyWith(color: context.appColors.textSecondary)),
            );
          }

          final groupedItems = _groupItemsByDateCategory(state.items);

          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(
                  bottom: state.isEditMode ? 100 : 24,
                  top: 16,
                ),
                itemCount: groupedItems.keys.length,
                itemBuilder: (context, index) {
                  final groupName = groupedItems.keys.elementAt(index);
                  final groupItems = groupedItems[groupName]!;

                  // Check if all items in this group are selected
                  final allSelected = groupItems.every((item) => state.selectedItemIds.contains(item.id));

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(groupName, style: AppTextStyle.body1Medium.copyWith(color: context.appColors.textSecondary)),
                            if (state.isEditMode)
                              GestureDetector(
                                onTap: () => context.read<HistoryCubit>().toggleSelectAllGroup(
                                  groupItems,
                                  !allSelected,
                                ),
                                child: Text(
                                  allSelected ? 'ยกเลิก' : 'เลือกทั้งหมด',
                                  style: AppTextStyle.body1Medium.copyWith(color: context.appColors.textSecondary),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // List of items in section
                      ...groupItems.map(
                        (item) => HistoryItem(
                          item: item,
                          isEditMode: state.isEditMode,
                          isSelected: state.selectedItemIds.contains(item.id),
                          onSelect: (id) => context.read<HistoryCubit>().toggleItemSelection(id),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Delete Bottom Bar
              if (state.isEditMode)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: context.appColors.backgroundPrimary,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: MediaQuery.of(context).padding.bottom + 16,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.selectedItemIds.isEmpty
                            ? context.appColors.backgroundSecondary
                            : context.appColors.buttonError,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: state.selectedItemIds.isEmpty
                          ? null
                          : () {
                              context.read<HistoryCubit>().deleteSelectedItems();
                            },
                      child: Text('ลบ (${state.selectedItemIds.length})', style: AppTextStyle.body1Medium.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
            ],
          );
        } else if (state is HistoryError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }

  // Simple hardcoded bucketing to match mock design labels
  Map<String, List<HistoryModel>> _groupItemsByDateCategory(List<HistoryModel> items) {
    final Map<String, List<HistoryModel>> grouped = {
      'วันนี้': [],
      'เมื่อวาน': [],
      'ก่อนหน้านี้': [],
    };

    final now = DateTime.now();

    for (var item in items) {
      final difference = DateTime(now.year, now.month, now.day).difference(DateTime(item.date.year, item.date.month, item.date.day)).inDays;

      if (difference == 0) {
        grouped['วันนี้']!.add(item);
      } else if (difference == 1) {
        grouped['เมื่อวาน']!.add(item);
      } else {
        grouped['ก่อนหน้านี้']!.add(item);
      }
    }

    // Remove empty categories
    grouped.removeWhere((key, value) => value.isEmpty);

    return grouped;
  }
}
