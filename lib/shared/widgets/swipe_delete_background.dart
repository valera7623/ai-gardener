import 'package:flutter/material.dart';

class SwipeDeleteBackground extends StatelessWidget {
  const SwipeDeleteBackground({this.borderRadius = 16, super.key});

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.error,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.delete_outline, color: scheme.onError),
        ),
      ),
    );
  }
}
