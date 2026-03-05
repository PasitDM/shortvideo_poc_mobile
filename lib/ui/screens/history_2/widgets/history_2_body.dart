import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/watch_history_model.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../styles/index.dart';
import '../../../widgets/app_bottom_sheet.dart';
import '../cubit/history_2_cubit.dart';
import '../cubit/history_2_state.dart';
import 'history_2_item.dart';

class History2Body extends StatelessWidget {
  const History2Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<History2ScreenCubit, History2ScreenState, History2ScreenStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        switch (status) {
          case History2ScreenStatus.initial:
          case History2ScreenStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case History2ScreenStatus.failure:
            return Center(
              child: Text(
                'เกิดข้อผิดพลาด',
                style: AppTextStyle.body1Medium.copyWith(
                  color: context.appColors.textSecondary,
                ),
              ),
            );
          case History2ScreenStatus.ready:
            return _buildReadyState(context);
        }
      },
    );
  }

  Widget _buildReadyState(BuildContext context) {
    return BlocSelector<History2ScreenCubit, History2ScreenState, List<WatchHistoryModel>>(
      selector: (state) => state.items,
      builder: (context, items) {
        if (items.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildHistoryList(context);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration icon placeholder
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.appColors.iconTertiary,
              ),
              child: Icon(
                Icons.history,
                size: 64,
                color: context.appColors.backgroundPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              'ยังไม่มีประวัติการรับชม',
              style: AppTextStyle.subtitleBold.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),

            // Description
            Text(
              'ลองดูซีรี่ใหม่ๆได้เลย',
              style: AppTextStyle.body2Regular.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            // CTA Button (gradient)
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.appColors.buttonPrimary,
                    context.appColors.buttonPrimary.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to home or content discovery
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Text(
                  'ไปดูหนังกัน',
                  style: AppTextStyle.body1Medium.copyWith(
                    color: context.appColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return BlocBuilder<History2ScreenCubit, History2ScreenState>(
      builder: (context, state) {
        final groupedItems = _groupItemsByDateCategory(state.items);

        return Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(
                bottom: state.isEditMode ? 100 : 24,
                top: 8,
              ),
              itemCount: groupedItems.keys.length,
              itemBuilder: (context, index) {
                final groupName = groupedItems.keys.elementAt(index);
                final groupItems = groupedItems[groupName]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        groupName,
                        style: AppTextStyle.body1Medium.copyWith(
                          fontSize: 14,
                          color: context.appColors.textSecondary,
                        ),
                      ),
                    ),

                    // Items in section
                    ...groupItems.map(
                      (item) => History2Item(
                        item: item,
                        isEditMode: state.isEditMode,
                        isSelected: state.selectedItemIds.contains(item.id),
                        onSelect: (id) => context.read<History2ScreenCubit>().toggleItemSelection(id),
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
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: state.selectedItemIds.isEmpty
                            ? context.appColors.backgroundTertiary
                            : context.appColors.buttonError,
                        side: BorderSide(
                          color: context.appColors.borderSecondary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: state.selectedItemIds.isEmpty ? null : () => _showDeleteConfirmation(context),
                      child: Text(
                        'ลบ (${state.selectedItemIds.length})',
                        style: AppTextStyle.body1Medium.copyWith(
                          color: context.appColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Map<String, List<WatchHistoryModel>> _groupItemsByDateCategory(
    List<WatchHistoryModel> items,
  ) {
    final Map<String, List<WatchHistoryModel>> grouped = {
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

  void _showDeleteConfirmation(BuildContext context) {
    final cubit = context.read<History2ScreenCubit>();
    AppBottomSheet.show(
      context: context,
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.appColors.iconTertiary,
        ),
        child: Icon(
          Icons.delete_outline,
          size: 64,
          color: context.appColors.backgroundPrimary,
        ),
      ),
      title: 'ลบประวัติการดู',
      description: 'ยืนยันลบเนื้อหาที่เลือกออกจากรายการหรือไม่',
      primaryButtonText: 'ลบ',
      secondaryButtonText: 'ยกเลิก',
      onPrimaryPressed: () {
        Navigator.pop(context);
        cubit.deleteSelectedItems();
      },
      onSecondaryPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
