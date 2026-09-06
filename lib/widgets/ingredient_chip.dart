import 'package:flutter/material.dart';

class IngredientChip extends StatelessWidget {
  final String ingredient;
  final bool isHighlighted;

  const IngredientChip({
    super.key,
    required this.ingredient,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Chip(
      avatar: Icon(
        Icons.check_circle_outline,
        size: 18,
        color: isHighlighted ? theme.colorScheme.primary : null,
      ),
      label: Text(
        ingredient,
        style: TextStyle(
          color: isHighlighted ? theme.colorScheme.primary : null,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      backgroundColor: isHighlighted
          ? theme.colorScheme.primary.withValues(alpha: 0.1)
          : theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
