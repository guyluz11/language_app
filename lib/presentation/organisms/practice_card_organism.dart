import 'package:flutter/cupertino.dart';
import 'package:word_link/domain/objects/card_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';

class PracticeCardOrganism extends StatelessWidget {
  const PracticeCardOrganism({
    required this.card,
    required this.onFlipped,
  });

  final CardObject card;
  final VoidCallback onFlipped;

  @override
  Widget build(BuildContext context) {
    return FlipAtom(
      front: body(isFront: true),
      back: body(isFront: false),
      onFlip: onFlipped,
    );
  }

  Widget body({required bool isFront}) {
    return CardAtom(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(),
              ],
            ),
            const SeparatorAtom(),
            TextAtom(card.name ?? ''),
            const SeparatorAtom(),
            TextAtom(card.secondaryName ?? ''),
            const SeparatorAtom(),
            TextAtom(isFront ? '' : card.answer ?? ''),
            const SeparatorAtom(),
          ],
        ),
      ),
    );
  }
}
