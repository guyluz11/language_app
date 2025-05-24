import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/language_controller.dart';
import 'package:word_link/domain/objects/answers_related/answer_card_object.dart';
import 'package:word_link/domain/objects/answers_related/answer_cards_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class PracticeAnswersOrganism extends StatelessWidget {
  const PracticeAnswersOrganism({
    required this.cardCollection,
    required this.answerCards,
    this.restart,
  });

  final CollectionObject cardCollection;
  final AnswerCardsObject? answerCards;
  final VoidCallback? restart;

  LanguageEnum get language {
    return LanguageEnum.values.firstWhere(
      (lang) => lang.displayName == cardCollection.name,
      orElse: () => LanguageEnum.polish,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (answerCards == null) {
      body = const TextAtom('No answers found');
    } else {
      final List<AnswerCardObject> correctAnswers =
          answerCards!.getCorrectAnswers().toList();
      final List<AnswerCardObject> incorrectAnswers =
          answerCards!.getCorrectIncorrect().toList();

      body = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SeparatorAtom(),
            TextAtom(
              'Correct ${correctAnswers.length}/${answerCards!.getAnswers().length}',
              variant: TextVariant.medium,
            ),
            const SeparatorAtom(),
            const SeparatorAtom(),
            const SeparatorAtom(),
            const TextAtom('Correct:', variant: TextVariant.smallTitle),
            getListOfCards(correctAnswers),
            const SeparatorAtom(),
            const SeparatorAtom(),
            const SeparatorAtom(),
            const TextAtom('Incorrect:', variant: TextVariant.smallTitle),
            getListOfCards(incorrectAnswers),
            const SeparatorAtom(),
            const SeparatorAtom(),
            const SeparatorAtom(),
          ],
        ),
      );
    }

    return PageEnclosureMolecule(
      title: 'Practice Cards',
      subTitle: 'Review your cards',
      topMargin: false,
      expendChild: false,
      topBarType: TopBarType.back,
      topBarRightWidget: Hero(
        tag: 'language_flag_${cardCollection.name}',
        child: Container(
          width: 48,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(
                    (0.5 * 255).toInt(),
                  ),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              language.flagUrl,
              width: 48,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      child: body,
    );
  }

  Widget getListOfCards(List<AnswerCardObject> answers) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      itemBuilder: (context, index) {
        final String cardName = getAnswerName(answers[index]);
        return TextAtom(cardName);
      },
    );
  }

  String getAnswerName(AnswerCardObject answer) =>
      cardCollection.cards
          .where((card) => card.uniqueId == answer.cardUniqueId)
          .first
          .name ??
      'No Name Found';
}
