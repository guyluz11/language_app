import 'package:flutter/material.dart';
import 'package:word_link/domain/objects/cards_collection_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/organisms.dart';

class PracticeCardsPage extends StatefulWidget {
  const PracticeCardsPage({required this.cardCollection});

  final CardsCollectionObject cardCollection;

  @override
  State<PracticeCardsPage> createState() => _PracticeCardsPageState();
}

class _PracticeCardsPageState extends State<PracticeCardsPage> {
  int currentCardIndex = 0;
  bool isCardFlipped = false;
  bool isLoadingNext = false;

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Practice Cards',
      subTitle: 'Review your cards',
      expendChild: false,
      topMargin: false,
      topBarType: TopBarType.back,
      child: currentCardIndex == widget.cardCollection.cards.length
          ? const TextAtom('Done')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SeparatorAtom(variant: SeparatorVariant.farApart),
                TextAtom(
                  '$currentCardIndex/${widget.cardCollection.cards.length}',
                ),
                const SeparatorAtom(),
                Expanded(
                  child: isLoadingNext
                      ? Center(child: ProgressAtom())
                      : SingleChildScrollView(
                          child: PracticeCardOrganism(
                            card: widget.cardCollection.cards[currentCardIndex],
                            onFlipped: () {
                              setState(() => isCardFlipped = true);
                            },
                          ),
                        ),
                ),
                const SeparatorAtom(),
                IgnorePointer(
                  ignoring: !isCardFlipped,
                  child: Visibility(
                    visible: isCardFlipped,
                    child: Column(
                      children: [
                        const SeparatorAtom(),
                        const TextAtom('Did you remember it correctly?'),
                        const SeparatorAtom(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonAtom(
                              onPressed: () => userResponse(remembered: false),
                              variant:
                                  ButtonVariant.mediumHighEmphasisFilledTonal,
                              text: 'No',
                              icon: Icons.close,
                            ),
                            const SeparatorAtom(),
                            ButtonAtom(
                              variant:
                                  ButtonVariant.mediumHighEmphasisFilledTonal,
                              onPressed: () => userResponse(remembered: true),
                              text: 'Yes',
                              icon: Icons.check_circle_outline,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SeparatorAtom(),
              ],
            ),
    );
  }

  Future<void> userResponse({required bool remembered}) async {
    setState(() {
      isLoadingNext = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      currentCardIndex++;
      isCardFlipped = false;
      isLoadingNext = false;
    });
  }
}
