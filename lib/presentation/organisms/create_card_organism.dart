import 'package:flutter/cupertino.dart';
import 'package:word_link/presentation/atoms/atoms.dart';

class CreateCardOrganism extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardAtom(
      child: const SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TextFieldAtom(
              labelText: 'Item Name',
            ),
            SeparatorAtom(),
            TextFieldAtom(
              labelText: 'Secondary Name (Optional)',
            ),
            SeparatorAtom(),
            TextFieldAtom(
              labelText: 'Answer',
            ),
            SeparatorAtom(),
          ],
        ),
      ),
      onClick: () {},
    );
  }
}
