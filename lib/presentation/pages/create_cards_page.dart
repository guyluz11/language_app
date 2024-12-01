import 'package:flutter/cupertino.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class CreateCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Custom Collections',
      subTitle: 'Create collections and review them',
      expendChild: false,
      child: Column(
        children: [
          Expanded(
            child: CardAtom(
              child: const SizedBox(
                width: double.infinity,
                child: TextAtom('Test'),
              ),
              onClick: () {},
            ),
          ),
          const SeparatorAtom(),
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
          const SeparatorAtom(),
        ],
      ),
    );
  }
}
