import 'package:flutter/material.dart';
import 'package:word_link/domain/objects/answers_related/answer_cards_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:word_link/presentation/organisms/practice_answers_organism.dart';
import 'package:word_link/presentation/organisms/practice_collection_organism.dart';

class PracticeCardsPage extends StatefulWidget {
  const PracticeCardsPage({required this.cardCollection});

  final CollectionObject cardCollection;

  @override
  State<PracticeCardsPage> createState() => _PracticeCardsPageState();
}

class _PracticeCardsPageState extends State<PracticeCardsPage> {
  PracticeCollectionPageState state = PracticeCollectionPageState.practice;
  AnswerCardsObject? answerCards;

  void onCompletePracticeComplete(AnswerCardsObject answer) {
    answerCards = answer;
    setState(() {
      state = PracticeCollectionPageState.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PracticeCollectionPageState.practice:
        return PracticeCollectionOrganism(
          cardCollection: widget.cardCollection,
          onComplete: onCompletePracticeComplete,
        );
      case PracticeCollectionPageState.results:
        return PracticeAnswersOrganism(
          cardCollection: widget.cardCollection,
          answerCards: answerCards,
        );
    }
  }
}

enum PracticeCollectionPageState {
  practice,
  results,
  ;
}
