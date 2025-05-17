import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/tts_controller.dart';
import 'package:word_link/domain/objects/answers_related/answer_card_object.dart';
import 'package:word_link/domain/objects/answers_related/answer_cards_object.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class PracticeCollectionOrganism extends StatefulWidget {
  const PracticeCollectionOrganism({
    required this.cardCollection,
    this.onComplete,
  });

  final CollectionObject cardCollection;
  final Function(AnswerCardsObject answer)? onComplete;

  @override
  State<PracticeCollectionOrganism> createState() =>
      _PracticeCollectionOrganismState();
}

class _PracticeCollectionOrganismState
    extends State<PracticeCollectionOrganism> {
  final TtsController _ttsController = TtsController.instance;

  @override
  void initState() {
    super.initState();
    cards = widget.cardCollection.cards;
    cards.shuffle();
    currentCard = cards[currentCardIndex];
  }

  Future<void> _speakCardContent() async {
    if (currentCard == null) return;

    String textToSpeak = "";

    if (currentCard!.answer?.isNotEmpty == true) {
      textToSpeak += currentCard!.answer!;
    }

    if (textToSpeak.isNotEmpty) {
      await _ttsController.speak(textToSpeak);
    }
  }

  int currentCardIndex = 0;
  bool isCardFlipped = false;
  bool isLoadingNext = false;
  bool showHint = false;
  late List<CardObject> cards;
  AnswerCardsObject answerCardsObject = AnswerCardsObject();

  CardObject? currentCard;

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Practice Cards',
      subTitle: 'Review your cards',
      expendChild: false,
      topMargin: false,
      topBarType: TopBarType.back,
      child: currentCardIndex == cards.length || currentCard == null
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
                      : PracticeCardMolecule(
                          card: currentCard!,
                          onFlipped: () {
                            setState(() => isCardFlipped = true);
                            _speakCardContent();
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
    if (currentCard == null) {
      return;
    }

    if (currentCard?.name?.isNotEmpty == true) {
      _ttsController.speak(currentCard!.name!);
    }

    final AnswerCardObject answerCardObject = AnswerCardObject(
      correctAnswer: remembered,
      cardUniqueId: currentCard!.uniqueId,
    );
    answerCardsObject.addAnswer(answerCardObject);

    setState(() {
      isLoadingNext = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    if (currentCardIndex == cards.length - 1) {
      widget.onComplete?.call(answerCardsObject);
      return;
    }
    setState(() {
      currentCardIndex++;
      currentCard = cards[currentCardIndex];
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
