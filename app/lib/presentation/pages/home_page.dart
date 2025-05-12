import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/detailed_card_organism.dart';
import 'package:word_link/presentation/pages/custom_collections_page.dart';
import 'package:word_link/presentation/pages/practice_collection_page.dart';
import 'package:word_link/domain/objects/cards_related/card_object.dart';
import 'package:word_link/domain/objects/cards_related/collection_object.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: GlobalVariables.appName,
      subTitle: 'What would you like to work on?',
      expendChild: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailedCardOrganism(
              titleText: 'Polish',
              subTitle: 'Practice your Polish vocabulary',
              buttonText: 'Open',
              background: SvgPicture.asset(
                'assets/images/folders_image.svg',
                fit: BoxFit.cover,
              ),
              onClick: () => practiceCollectionsClicked(context),
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
            DetailedCardOrganism(
              titleText: 'Custom Collections',
              subTitle: 'Create and manage your flip cards list',
              buttonText: 'Open',
              background: SvgPicture.asset(
                'assets/images/folders_image.svg',
                fit: BoxFit.cover,
              ),
              onClick: () => customCollectionClicked(context),
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
          ],
        ),
      ),
    );
  }

  void customCollectionClicked(BuildContext context) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CustomCollectionsPage(),
        ),
      );
  
  void practiceCollectionsClicked(BuildContext context) async {
    final fileContent = await rootBundle.loadString('assets/words/polish_words.txt');
    final lines = fileContent.split('\n').where((line) => line.trim().isNotEmpty).take(5).toList();

    final polishCards = lines.map((line) {
      final parts = line.split(',');
      final polish = parts[0].trim();
      final english = parts.length > 1 ? parts[1].trim() : '';
      return CardObject(name: polish, answer: english);
    }).toList();

    final polishCollection = CollectionObject(
      name: 'Polish',
      cardsTemp: polishCards,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PracticeCardsPage(cardCollection: polishCollection),
      ),
    );
  }

}
