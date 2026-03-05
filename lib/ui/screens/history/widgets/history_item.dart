import 'package:flutter/material.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../styles/index.dart';
import '../data/history_model.dart';

class HistoryItem extends StatelessWidget {
  final HistoryModel item;
  final bool isEditMode;
  final bool isSelected;
  final ValueChanged<String>? onSelect;

  const HistoryItem({
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
            // Selection Checkbox (Only visible in Edit Mode)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isEditMode ? 32 : 0,
              child: isEditMode
                  ? Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        color: isSelected ? context.appColors.buttonPrimary : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? context.appColors.buttonPrimary : context.appColors.borderDefault,
                          width: 1.5,
                        ),
                      ),
                      width: 24,
                      height: 24,
                      child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                    )
                  : const SizedBox.shrink(),
            ),

            // Image Thumbnail
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
                  color: context.appColors.backgroundSecondary,
                  child: Icon(Icons.image, color: context.appColors.iconDisable),
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
                      color: context.appColors.backgroundThirdary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      item.genre,
                      style: AppTextStyle.captionMedium.copyWith(color: context.appColors.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title (Multi-style)
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: AppTextStyle.w700(14).copyWith(
                        color: context.appColors.textDefault,
                        height: 24 / 14,
                      ),
                      children: [
                        TextSpan(text: item.title),
                        TextSpan(
                          text: item.prefixTitle,
                          style: AppTextStyle.w700(14).copyWith(color: context.appColors.textDefault),
                        ),
                        TextSpan(text: '\n${item.suffixTitle}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // EPS & Timestamp
                  Row(
                    children: [
                      // Subtitle
                      Expanded(
                        child: Text(
                          item.subtitle,
                          style: AppTextStyle.w400(12).copyWith(
                            color: context.appColors.textSecondary,
                            height: 20 / 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Timestamp
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_outlined, // Fallback if no SVG clock
                            size: 16,
                            color: context.appColors.iconSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.timestamp,
                            style: AppTextStyle.captionRegular.copyWith(color: context.appColors.textSecondary),
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
}
