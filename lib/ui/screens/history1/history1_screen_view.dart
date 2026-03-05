import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/history1_model.dart';
import '../../extensions/build_context_extension.dart';
import '../../styles/index.dart';
import '../../widgets/app_bottom_sheet.dart';
import 'cubit/history1_cubit.dart';
import 'cubit/history1_state.dart';

class History1ScreenView extends StatelessWidget {
  const History1ScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<History1Cubit, History1State>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.appColors.backgroundPrimary,
          appBar: _buildAppBar(context, state),
          body: _buildBody(context, state),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, History1State state) {
    if (state.isEditMode) {
      final isAllSelected = state.items.isNotEmpty && state.selectedIds.length == state.items.length;
      return AppBar(
        leading: IconButton(
          icon: Icon(
            isAllSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: context.appColors.iconPrimary,
          ),
          onPressed: () {
            if (isAllSelected) {
              context.read<History1Cubit>().deselectAll();
            } else {
              context.read<History1Cubit>().selectAll();
            }
          },
        ),
        title: Text(
          'เลือกทั้งหมด',
          style: AppTextStyle.body1Regular.copyWith(color: context.appColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => context.read<History1Cubit>().toggleEditMode(),
            child: Text(
              'ยกเลิก',
              style: AppTextStyle.body1Regular.copyWith(color: context.appColors.textPrimary),
            ),
          ),
        ],
      );
    }

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: context.appColors.iconPrimary),
        onPressed: () => context.pop(),
      ),
      centerTitle: true,
      title: Text(
        'ประวัติการรับชม',
        style: AppTextStyle.body1Regular.copyWith(color: context.appColors.textPrimary),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.edit, color: context.appColors.iconPrimary),
          onPressed: () => context.read<History1Cubit>().toggleEditMode(),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, History1State state) {
    if (state.status == History1Status.loading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.items.isEmpty) {
      return Center(
        child: Text(
          'ไม่มีประวัติการรับชม',
          style: AppTextStyle.body2Regular.copyWith(color: context.appColors.textSecondary),
        ),
      );
    }

    final groupedItems = _groupItems(state.items);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: groupedItems.length,
            itemBuilder: (context, index) {
              final group = groupedItems[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      group.title,
                      style: AppTextStyle.body1Medium.copyWith(
                        color: context.appColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ...group.items.map(
                    (item) => _HistoryItemRow(
                      item: item,
                      isEditMode: state.isEditMode,
                      isSelected: state.selectedIds.contains(item.id),
                      onToggle: () => context.read<History1Cubit>().toggleSelection(item.id),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (state.isEditMode && state.selectedIds.isNotEmpty) _buildDeleteFooter(context),
      ],
    );
  }

  Widget _buildDeleteFooter(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.buttonError,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          ),
          onPressed: () => _showConfirmDelete(context),
          child: const Text('ลบ', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  void _showConfirmDelete(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      icon: Icon(Icons.delete_outline, size: 64, color: context.appColors.iconTertiary),
      title: 'ลบประวัติการดู',
      description: 'ยืนยันลบเนื้อหาที่เลือกออกจากรายการหรือไม่',
      primaryButtonText: 'ลบ',
      secondaryButtonText: 'ยกเลิก',
      onPrimaryPressed: () {
        context.read<History1Cubit>().deleteSelected();
        Navigator.pop(context);
      },
      onSecondaryPressed: () => Navigator.pop(context),
    );
  }

  List<_GroupedHistory> _groupItems(List<History1Model> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final groups = <String, List<History1Model>>{};

    for (var item in items) {
      final date = DateTime(item.date.year, item.date.month, item.date.day);
      String title;
      if (date == today) {
        title = 'วันนี้';
      } else if (date == yesterday) {
        title = 'เมื่อวาน';
      } else if (now.difference(date).inDays < 7) {
        title = 'สัปดาห์นี้';
      } else {
        title = 'ก่อนหน้านี้';
      }

      groups.putIfAbsent(title, () => []).add(item);
    }

    return groups.entries.map((e) => _GroupedHistory(e.key, e.value)).toList();
  }
}

class _HistoryItemRow extends StatelessWidget {
  final History1Model item;
  final bool isEditMode;
  final bool isSelected;
  final VoidCallback onToggle;

  const _HistoryItemRow({
    required this.item,
    required this.isEditMode,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: isEditMode ? onToggle : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditMode) ...[
              Padding(
                padding: const EdgeInsets.only(top: 44, right: 12),
                child: Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? context.appColors.iconPrimaryBrand : context.appColors.iconTertiary,
                ),
              ),
            ],
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 84,
                height: 112,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(color: Colors.grey, width: 84, height: 112),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.appColors.backgroundTertiary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.genre,
                      style: AppTextStyle.captionMedium.copyWith(color: context.appColors.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: AppTextStyle.body2Bold.copyWith(color: context.appColors.textPrimary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: item.prefixTitle,
                              style: AppTextStyle.captionBold.copyWith(color: context.appColors.textPrimary),
                            ),
                            TextSpan(
                              text: ' / ${item.suffixTitle}',
                              style: AppTextStyle.captionRegular.copyWith(color: context.appColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.access_time, size: 14, color: context.appColors.iconSecondary),
                      const SizedBox(width: 4),
                      Text(
                        item.timestamp,
                        style: AppTextStyle.captionRegular.copyWith(color: context.appColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupedHistory {
  final String title;
  final List<History1Model> items;
  _GroupedHistory(this.title, this.items);
}
