import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/detailed_card_organism.dart';
import 'package:word_link/presentation/pages/pages.dart';

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
              titleText: LanguageEnum.polish.displayName,
              subTitle:
                  'Practice your ${LanguageEnum.polish.displayName} vocabulary',
              buttonText: 'Open',
              background: SvgPicture.asset(
                'assets/images/folders_image.svg',
                fit: BoxFit.cover,
              ),
              onClick: () =>
                  practiceCollectionsClicked(context, LanguageEnum.polish),
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

  Future<void> practiceCollectionsClicked(
      BuildContext context, LanguageEnum language) async {
    final cardCollection = await LanguageController.instance
        .getMostUsedWords(sourceLanguage: language);

    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PracticeCardsPage(cardCollection: cardCollection),
      ),
    );
  }
}
