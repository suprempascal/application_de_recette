import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final double maxRating;
  final double size;
  final bool showText;

  const RatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5.0,
    this.size = 20.0,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(maxRating.toInt(), (index) {
          final starValue = index + 1.0;
          if (starValue <= rating.floor()) {
            return Icon(Icons.star, size: size, color: Colors.amber);
          } else if (starValue - 0.5 <= rating) {
            return Icon(Icons.star_half, size: size, color: Colors.amber);
          } else {
            return Icon(Icons.star_border, size: size, color: Colors.amber);
          }
        }),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.amber[700],
            ),
          ),
        ],
      ],
    );
  }
}
