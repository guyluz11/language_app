import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

class FlipAtom extends StatelessWidget {
  const FlipAtom({
    required this.front,
    required this.back,
    this.onFlip,
  });

  final Widget front;
  final Widget back;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      onFlip: onFlip,
      fill: Fill.fillBack,
      front: front,
      back: back,
    );
  }
}
