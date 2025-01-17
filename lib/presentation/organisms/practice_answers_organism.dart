import 'package:flutter/cupertino.dart';
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

      body = Column(
        children: [
          TextAtom('Total Questions: ${answerCards!.getAnswers().length}'),
          const SeparatorAtom(),
          TextAtom('Correct: ${correctAnswers.length}'),
          const SeparatorAtom(),
          TextAtom('Incorrect: ${incorrectAnswers.length}'),
          const SeparatorAtom(),
          const SeparatorAtom(),
          const SeparatorAtom(),
          const TextAtom('Correct Names', variant: TextVariant.medium),
          const SeparatorAtom(),
          getListOfCards(correctAnswers),
          const SeparatorAtom(),
          const SeparatorAtom(),
          const SeparatorAtom(),
          const TextAtom('Incorrect Names', variant: TextVariant.medium),
          const SeparatorAtom(),
          getListOfCards(incorrectAnswers),
          const SeparatorAtom(),
          const SeparatorAtom(),
          const SeparatorAtom(),
        ],
      );
    }

    return PageEnclosureMolecule(
      title: 'Practice Cards',
      subTitle: 'Review your cards',
      expendChild: false,
      topMargin: false,
      topBarType: TopBarType.back,
      child: body,
    );
  }

  Widget getListOfCards(List<AnswerCardObject> answers) {
    return ListView.builder(
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
