import 'package:flutter/material.dart';
import 'package:word_link/domain/objects/card_object.dart';
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
  @override
  void initState() {
    super.initState();
    cards = widget.cardCollection.cards;
    cards.shuffle();
  }

  int currentCardIndex = 0;
  bool isCardFlipped = false;
  bool isLoadingNext = false;
  bool showHint = false;
  late List<CardObject> cards;

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Practice Cards',
      subTitle: 'Review your cards',
      expendChild: false,
      topMargin: false,
      topBarType: TopBarType.back,
      child: currentCardIndex == cards.length
          ? const TextAtom('Done')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SeparatorAtom(variant: SeparatorVariant.farApart),
                TextAtom(
                  '${currentCardIndex + 1}/${cards.length}',
                ),
                const SeparatorAtom(),
                Expanded(
                  child: isLoadingNext
                      ? Center(child: ProgressAtom())
                      : PracticeCardOrganism(
                          card: cards[currentCardIndex],
                          onFlipped: () {
                            setState(() => isCardFlipped = true);
                          },
                          showSecond: showHint,
                        ),
                ),
                const SeparatorAtom(),
                if (!isCardFlipped)
                  Column(
                    children: [
                      const SeparatorAtom(),
                      const SizedBox(width: double.infinity),
                      const TextAtom(''),
                      const SeparatorAtom(),
                      const SeparatorAtom(),
                      ButtonAtom(
                        variant: ButtonVariant.highEmphasisFilled,
                        onPressed: toggleHint,
                        text: 'Hint',
                        icon: showHint
                            ? Icons.mail_rounded
                            : Icons.mail_lock_rounded,
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      const SeparatorAtom(),
                      const TextAtom('Did you remember it correctly?'),
                      const SeparatorAtom(),
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

  void toggleHint() {
    setState(() {
      showHint = !showHint;
    });
  }
}
