import 'package:flutter/material.dart';
import 'package:word_link/domain/objects/cards_releated/collection_object.dart';
import 'package:word_link/presentation/organisms/practice_collection_organism.dart';
import 'package:word_link/presentation/organisms/practice_results_organism.dart';

class PracticeCardsPage extends StatefulWidget {
  const PracticeCardsPage({required this.cardCollection});

  final CollectionObject cardCollection;

  @override
  State<PracticeCardsPage> createState() => _PracticeCardsPageState();
}

class _PracticeCardsPageState extends State<PracticeCardsPage> {
  PracticeCollectionPageState state = PracticeCollectionPageState.practice;

  @override
  Widget build(BuildContext context) {
    if (state == PracticeCollectionPageState.practice) {
      return PracticeCollectionOrganism(cardCollection: widget.cardCollection);
    }
    return PracticeResultsOrganism(cardCollection: widget.cardCollection);
  }
}

enum PracticeCollectionPageState {
  practice,
  results,
  ;
}
