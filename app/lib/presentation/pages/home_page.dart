import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/core/theme_data.dart';
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
      child: Container(
        margin: const EdgeInsets.only(bottom: AppThemeData.generalSpacing),
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            LanguageCardMolecule(
              language: LanguageEnum.polish,
              onClick: () =>
                  practiceCollectionsClicked(context, LanguageEnum.polish),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: DetailedCardOrganism(
                titleText: 'Custom Collections',
                subTitle: 'Create and manage your flip cards list',
                buttonText: 'Open',
                background: SvgPicture.asset(
                  'assets/images/folders_image.svg',
                  fit: BoxFit.cover,
                ),
                onClick: () => customCollectionClicked(context),
              ),
            ),
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
