import 'package:flutter/cupertino.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';

class PracticeCardMolecule extends StatelessWidget {
  const PracticeCardMolecule({
    required this.card,
    required this.onFlipped,
    this.showSecond = false,
  });

  final CardObject card;
  final VoidCallback onFlipped;
  final bool showSecond;

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
            if (showSecond || !isFront) ...[
              TextAtom(card.secondaryName ?? ''),
              const SeparatorAtom(),
            ],
            TextAtom(isFront ? '' : card.answer ?? ''),
            const SeparatorAtom(),
          ],
        ),
      ),
    );
  }
}
