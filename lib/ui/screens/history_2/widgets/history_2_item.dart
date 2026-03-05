import 'package:flutter/material.dart';

import '../../../../data/models/watch_history_model.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../styles/index.dart';

class History2Item extends StatelessWidget {
  final WatchHistoryModel item;
  final bool isEditMode;
  final bool isSelected;
  final ValueChanged<String>? onSelect;

  const History2Item({
    super.key,
    required this.item,
    this.isEditMode = false,
    this.isSelected = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEditMode ? () => onSelect?.call(item.id) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Checkbox (Edit Mode)
            if (isEditMode) ...[
              _buildCheckbox(context),
              const SizedBox(width: 16),
            ],

            // Image Thumbnail (84x112)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 84,
                height: 112,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 84,
                  height: 112,
                  decoration: BoxDecoration(
                    color: context.appColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.image, color: context.appColors.iconTertiary),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Genre Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.appColors.backgroundTertiary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      item.genre,
                      style: AppTextStyle.captionMedium.copyWith(
                        color: context.appColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title (Multi-style RichText)
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: AppTextStyle.w700(14).copyWith(
                        color: context.appColors.textPrimary,
                        height: 24 / 14,
                      ),
                      children: [
                        TextSpan(text: item.title),
                        TextSpan(
                          text: item.prefixTitle,
                          style: AppTextStyle.w700(14).copyWith(
                            color: context.appColors.textPrimary,
                          ),
                        ),
                        TextSpan(text: '\n${item.suffixTitle}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // EP & Timestamp row
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: item.subtitle.split(' / ').first,
                                style: AppTextStyle.w700(12).copyWith(
                                  color: context.appColors.textPrimary,
                                  height: 20 / 12,
                                ),
                              ),
                              TextSpan(
                                text: ' / ${item.subtitle.split(' / ').last}',
                                style: AppTextStyle.w400(12).copyWith(
                                  color: context.appColors.textSecondary,
                                  height: 20 / 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 16,
                            color: context.appColors.iconSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.timestamp,
                            style: AppTextStyle.captionRegular.copyWith(
                              color: context.appColors.textSecondary,
                            ),
                          ),
                        ],
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

  Widget _buildCheckbox(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? context.appColors.buttonPrimary : Colors.transparent,
        border: Border.all(
          color: isSelected ? context.appColors.buttonPrimary : context.appColors.borderSecondary,
          width: 1.5,
        ),
      ),
      child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
    );
  }
}
