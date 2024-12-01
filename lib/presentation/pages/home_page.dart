import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/detailed_card_organism.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: GlobalVariables.appName,
      subTitle: 'Choose an activity type to start',
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
              onClick: () {},
            ),
            const SeparatorAtom(variant: SeparatorVariant.farApart),
          ],
        ),
      ),
    );
  }
}
