import 'package:flutter/material.dart';

class LanguageSelectionIndicator extends StatelessWidget {
  const LanguageSelectionIndicator({
    this.top = 10,
    this.right = 10,
    this.left,
    this.bottom,
    super.key,
  });

  final double? top;
  final double? right;
  final double? left;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      top: top,
      right: right,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
