import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/detailed_card_organism.dart';
import 'package:word_link/presentation/pages/custom_collections_page.dart';

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
}
