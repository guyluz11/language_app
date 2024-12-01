import 'package:flutter/cupertino.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/create_card_organism.dart';

class CreateCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Custom Collections',
      subTitle: 'Create collections and review them',
      expendChild: false,
      topMargin: false,
      child: Column(
        children: [
          const SeparatorAtom(variant: SeparatorVariant.farApart),
          Expanded(
            child: SingleChildScrollView(
              child: CreateCardOrganism(),
            ),
          ),
          const SeparatorAtom(variant: SeparatorVariant.farApart),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonAtom(
                variant: ButtonVariant.mediumHighEmphasisFilledTonal,
                onPressed: () {},
                text: 'Done',
              ),
              const SeparatorAtom(),
              ButtonAtom(
                variant: ButtonVariant.highEmphasisFilled,
                onPressed: () {},
                text: 'Another Card',
              ),
            ],
          ),
          const SeparatorAtom(variant: SeparatorVariant.farApart),
        ],
      ),
    );
  }
}
