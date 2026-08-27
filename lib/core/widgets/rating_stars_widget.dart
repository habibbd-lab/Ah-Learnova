import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class RatingStarsWidget extends StatelessWidget {
  final double rating;
  final double starSize;
  final int reviewsCount;
  final bool showCount;

  const RatingStarsWidget({
    super.key,
    required this.rating,
    this.starSize = 14,
    this.reviewsCount = 0,
    this.showCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: starSize,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(width: 4),
        ...List.generate(5, (index) {
          final starValue = index + 1;
          if (rating >= starValue) {
            return Icon(Icons.star_rounded, size: starSize + 2, color: AppColors.warning);
          } else if (rating > index && rating < starValue) {
            return Icon(Icons.star_half_rounded, size: starSize + 2, color: AppColors.warning);
          } else {
            return Icon(Icons.star_outline_rounded, size: starSize + 2, color: AppColors.secondary.withOpacity(0.4));
          }
        }),
        if (showCount) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewsCount)',
            style: TextStyle(
              fontSize: starSize - 2,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}
