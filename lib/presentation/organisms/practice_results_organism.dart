import 'package:flutter/cupertino.dart';
import 'package:word_link/domain/objects/cards_releated/collection_object.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class PracticeResultsOrganism extends StatelessWidget {
  const PracticeResultsOrganism({
    required this.cardCollection,
    this.restart,
  });

  final CollectionObject cardCollection;
  final VoidCallback? restart;

  @override
  Widget build(BuildContext context) {
    return const PageEnclosureMolecule(
      title: 'Practice Cards',
      subTitle: 'Review your cards',
      expendChild: false,
      topMargin: false,
      topBarType: TopBarType.back,
      child: Text('Done'),
    );
  }
}
